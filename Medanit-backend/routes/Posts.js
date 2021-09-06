const moment = require('moment');
const mongoose = require('mongoose');
const debug = require('debug')('app:posts');        // set/export DEBUG=app:posts
const express = require('express');

const { Post, validatePost, validatePut } = require('../Models/post');

const router = express.Router();


/* GET POSTS. */
router.get('/', async (req, res) => {
    const pageSize = 10;
    const pageNumber = req.query.pageNumber;
    const skipFactor = pageNumber ? (pageNumber - 1) * pageSize : 0;
    const limitFactor = pageNumber ? pageSize : 0;

    // debug(`Page size: ${pageSize}\nPage number: ${pageNumber}`);
    
    try{
        let posts = await Post
            .find()
            .skip( skipFactor )
            .limit( limitFactor )
            .sort( { date: -1 } )
            .select()
        
        
        posts = updateDate(posts)
        posts = updateComment(posts);
        res.send(posts);

    }catch(err){
        debug(err);
        res.status(500).send("Internal server error while trying to get posts!");
    }

});


/* GET POST WITH ID */
router.get('/:id', async (req, res) => {

    if(!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(404).send('Invalid Post Id!');

    try {
        //to validate the id of the post, if it's a valid objecId
        const post = await Post.findById(req.params.id).populate('comments');
        if(!post) return res.status(404).send('Resource not found!');
        res.send({...post._doc, date: post.date, comments: post.comments.length});

    }catch(err){
        debug(err.message);
        res.status(500).send("Internal server error while trying to get a post!");
    }
});


/* POST A NEW POST */
router.post('/', async (req, res) => {
    const { error, value } = validatePost(req.body);
    if (error) return res.status(400).send(error.message);

    let post = new Post({
        user_id: req.body.user_id,
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
                res.status(201).send({...post._doc, date: post.date});
            }
        });
        
        
    }catch(err){
        debug(err.message);
        res.status(500).send("Internal server error while trying to create a new post!");
    }
});

/* PUT METHOD FOR A POST */
router.put('/:id', async (req, res) => {
    const id = req.params.id;

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
            res.status(204).send();
        }else{

            let newPost = {
                user_id: oldPost.user_id,
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
                        res.status(204).send(result);
                    }catch(err){
                        debug(err.message);
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
router.delete('/:id', async  (req, res) => {
    const id = req.params.id;

    if(!mongoose.Types.ObjectId.isValid(id)) return res.status(404).send('Invalid Post Id!');


    try{
        const result = await Post.deleteOne( { _id: id } )
        if(!result) res.status(404).send('Resource not found!');
        res.send(result);
    }catch(err){
        debug(err.message);
        res.status(500).send("Internal server error while trying to delete a post!");

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

    debug(action);
    if(action === "upvote"){
        return await Post.updateOne({ _id: postId }, {
            $inc: {
                likes: 1
            }}, 
            { new: true });
        
    }else if(action === "downvote"){
        return await Post.updateOne({ _id: postId }, {
            $inc: {
                dislikes: 1
            }}, 
            { new: true });
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
