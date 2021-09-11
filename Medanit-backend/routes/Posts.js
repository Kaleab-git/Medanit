const _ = require('lodash');
const mongoose = require('mongoose');
const debug = require('debug')('app:posts');        // set/export DEBUG=app:posts
const express = require('express');

const { Post, validatePost, validatePut } = require('../Models/post');
const { User } = require('../Models/user');
const auth = require('../Middlewares/auth');

const router = express.Router();


/* GET POSTS. */
router.get('/', auth, async (req, res) => {
    const pageSize = 10;
    const pageNumber = req.query.pageNumber;
    const searchTerm = req.query.search ? req.query.search.trim(): undefined;
    const skipFactor = pageNumber ? (pageNumber - 1) * pageSize : 0;
    const limitFactor = pageNumber ? pageSize : 0;

    // debug(`Page size: ${pageSize}\nPage number: ${pageNumber}`);

    if(searchTerm) debug(`Search term: '${searchTerm}'`);
    
    try{
        let posts = await Post
            .find()
            .or([ 
                { title: new RegExp(searchTerm, 'i') },
                { content: new RegExp(searchTerm, 'i') }
            ])
            .skip( skipFactor )
            .limit( limitFactor )
            .sort( { date: -1 } )
            .select()
        
        
        posts = updateDate(posts)
        posts = updateComment(posts);
        return res.send(posts);

    }catch(err){
        debug(err);
        return res.status(500).send("Internal server error while trying to get posts!");
    }

});


/* GET POST WITH ID */
router.get('/:id', auth, async (req, res) => {

    if(!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(404).send('Invalid Post Id!');

    try {
        //to validate the id of the post, if it's a valid objecId
        const post = await Post.findById(req.params.id).populate('comments');
        if(!post) return res.status(404).send('Resource not found!');
        return res.send({...post._doc, date: post.date, comments: post.comments.length});

    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error while trying to get a post!");
    }
});


/* POST A NEW POST */
router.post('/', auth, async (req, res) => {
    const { error, value } = validatePost(req.body);
    if (error) return res.status(400).send(error.message);

    let post = new Post({
        user_id: req.user._id,
        title: req.body.title,
        content: req.body.content,
        side_effects: req.body.side_effects,
        date: new Date()
    });

    try{
        post.validate(async (err) => {
            if(err){
                return res.status(400).send(err.message);
            }else{
                post = await post.save();
                return res.status(201).send({...post._doc, date: post.date, comments: post.comments.length});
            }
        });
        
        
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error while trying to create a new post!");
    }
});

/* PUT METHOD FOR A POST */
router.put('/:id', auth, async (req, res) => {
    const id = req.params.id;
    const isAdmin = req.user.isAdmin
    const currentUser = req.user._id.toString();


    if(!mongoose.Types.ObjectId.isValid(id)) return res.status(404).send('Invalid Post Id!');
    

    const { error, value } = validatePut(req.body);
    if (error) return res.status(400).send(error.message);

    let oldPost;

    try{
        oldPost = await Post.findById(id);
        if(!oldPost) return res.status(404).send('Resource not found!');

        if(req.query.action){

            handleUpvoteDownvoteNotification(req, res);
            await handleUpvoteDownvoteDB(req, res);
            return res.status(204).send();
        }else{

            if(oldPost.user_id.toString() !== currentUser && !isAdmin) return res.status(403).send('Forbidden action!');

            let newPost = {
                user_id: oldPost.user_id,
                username: oldPost.username,
                title: req.body.title || oldPost.title,
                content: req.body.content || oldPost.content,
                side_effects: req.body.side_effects || oldPost.side_effects
            };

            newPost = new Post(newPost);
            newPost._id = oldPost._id; // we need to update it to the old ID b/c the object we just created gets a new ID
            newPost.validate(async (err) => {
                if(err){
                    res.status(400).send(err.message);
                }else{
                    try{
                        oldPost.set(newPost);
                        let result = await oldPost.save();
                        return res.status(204).send(result);
                    }catch(err){
                        debug(err.message);
                        res.status(500).send("Internal server error while trying to edit a post!");
                    }
                }
            });
            
        }

        

    }catch(err){
        debug(err.message);
        res.status(500).send("Internal server error while trying to edit a post!");

    }
    
    
});


/* DELETE METHOD FOR A POST */
router.delete('/:id', auth, async  (req, res) => {
    const id = req.params.id;
    const currentUser = req.user._id.toString();
    const isAdmin = req.user.isAdmin;

    if(!mongoose.Types.ObjectId.isValid(id)) return res.status(404).send('Invalid Post Id!');


    try{
        let oldPost = await Post.findById(id);
        if(!oldPost) res.status(404).send('Resource not found!');
        if(oldPost.user_id.toString() !== currentUser && !isAdmin) return res.status(403).send('Forbidden action!');

        oldPost.remove();
        return res.send(oldPost);
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error while trying to delete a post!");

    }
});




async function handleUpvoteDownvoteNotification(req) {
    const action = req.query.action;
    const postId = req.params.id;
    const userId = req.body.user_id;

    if (action) {
        if (action === "upvote") {
            debug(`Send a user who posted a post(id=${postId}) that ${userId} has liked his post`);
        }
        if (action === "downvote") {
            debug(`Send a user who posted a post(id=${postId}) that ${userId} has disliked his post`);
        }

    }
};

async function handleUpvoteDownvoteDB(req){
    const action = req.query.action;
    const postId = req.params.id;
    const userId = req.user._id;
    let hasLiked = hasDisliked = false;

    const user = await User.findById(userId);
    if(!user) return res.status(400).send('Invalid id;');

    let likes = user.likedPosts.map(obj => obj.toString());
    let dislikes = user.dislikedPosts.map(obj => obj.toString());

    if(_.includes(likes, postId)) hasLiked = true;
    if(_.includes(dislikes, postId)) hasDisliked = true;

    async function alterLikes(value){
        await Post.updateOne({ _id: postId }, {
            $inc: {
                likes: value
            }}, 
            { new: true }); 
        
        if(value === 1){
            user.likedPosts.push(postId)
            await user.save();
        }else if(value === -1){
            const updatedArr = _.remove(likes, postId);
            user.likedPosts = updatedArr;
            await user.save();
        }
    }

    async function alterDislikes(value){
        await Post.updateOne({ _id: postId }, {
            $inc: {
                dislikes: value
            }}, 
            { new: true }); 

        if(value === 1){
            user.dislikedPosts.push(postId)
            await user.save();
        }else if(value === -1){
            const updatedArr = _.remove(dislikes, postId);
            user.dislikedPosts = updatedArr;
            await user.save();
        }
    }


    debug(action);


    if(action === "upvote"){

        if(hasLiked){   
            await alterLikes(-1);       

        }else if(hasDisliked){
            await alterLikes(1);
            await alterDislikes(-1);

        }else{
            await alterLikes(1);
        }

        
        
    }else if(action === "downvote"){

        if(hasLiked){
            await alterDislikes(1);
            await alterLikes(-1);
        }else if(hasDisliked){
            await alterDislikes(-1);
        }else{
            await alterDislikes(1);
        }
        
    }
    
    
}

function updateDate(posts){
    let postsFinal = [];
    posts.forEach(post =>{
        let date = post.date;

        postsFinal.push({
            ...post._doc,
            date: date
        })
    });
    return postsFinal;
}

function updateComment(posts){
    let postsFinal = [];
    posts.forEach(post =>{
        let count = post.comments.length;
        postsFinal.push({
            ...post,
            comments: count
        })
    });
    return postsFinal;
}

module.exports = router;
