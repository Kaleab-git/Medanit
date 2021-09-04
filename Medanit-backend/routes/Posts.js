const debug = require('debug')('app:posts');        // set/export DEBUG=app:posts
const express = require('express');

const { Post, validatePost, validatePut } = require('../Models/post');

const router = express.Router();


/* GET POSTS. */
router.get('/', async (req, res) => {
    const pageSize = 10;
    const pageNumber = req.query.pageNumber;
    let skipFactor = pageNumber ? (pageNumber - 1) * pageSize : 0;
    let limitFactor = pageNumber ? pageSize : 0;

    debug(`Page size: ${pageSize}\nPage number: ${pageNumber}`);
    
    const posts = await Post
        .find()
        .skip( skipFactor )
        .limit( limitFactor )
        .sort( { date: 1 } )
        .select()
    
    res.send(posts);     

});


/* GET POST WITH ID */
router.get('/:id', async (req, res) => {
    const id = req.params.id;
    
    //to validate the id of the post, if it's a valid objecId


    const post = await Post.findById(id);
    if(!post) return res.status(404).send('Resource not found!');
    res.send(post);
});


/* POST A NEW POST */
router.post('/', async (req, res) => {
    const { error, value } = validatePost(req.body);
    if (error) return res.status(400).send(error.message);

    let post = new Post({
        user_id: req.body.user_id,
        title: req.body.title,
        content: req.body.content,
        side_effects: req.body.side_effects
    });

    post = await post.save()

    res.status(201).json(post);
});

/* PUT METHOD FOR A POST */
router.put('/:id', async (req, res) => {
    const id = req.params.id;

    const { error, value } = validatePut(req.body);
    if (error) return res.status(400).send(error.message);

    const oldPost = await Post.findById(id);
    if(!oldPost) return res.status(404).send('Resource not found!');
    
    let result;

    if(req.query.action){

        handleUpvoteDownvoteNotification(req);
        result = handleUpvoteDownvoteDB(req);

    }else{

        const newPost = {
            title: req.body.title || oldPost.title,
            content: req.body.content || oldPost.content,
            side_effects: req.body.side_effects || oldPost.side_effects
        };

        debug(newPost)

        oldPost.set(newPost);
        result = await  oldPost.save();
    }
    

    res.status(204).send(result);
});


/* DELETE METHOD FOR A POST */
router.delete('/:id', async  (req, res) => {
    const id = req.params.id;

    const result = await Post.deleteOne( { _id: id } )
    if(!result) res.status(404).send('Resource not found!');
    res.send(result);
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
    let result;

    if(action === "upvote"){
        debug("Upvote");
        result = await Post.updateOne({ _id: postId }, {
            $inc: {
                likes: 1
            }
        }, { new: true });
    }else if(action === "downvote"){
        debug("Downvote");
        result = await Post.updateOne({ _id: postId }, {
            $inc: {
                dislikes: 1
            }
        }, { new: true });
    }
    
    
}

module.exports = router;
