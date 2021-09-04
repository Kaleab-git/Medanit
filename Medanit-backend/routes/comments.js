const debug = require('debug')('app:comments');  // set/export DEBUG=app:comments
const express = require('express');

const { Comment, validatePost, validatePut } = require('../Models/comment');
const { Post } = require('../Models/post');

const router = express.Router({mergeParams:true});


/* get comments under a post */
router.get('/', async (req, res) => {
    const postId = req.params.post_id;
    const pageNumber = req.query.pageNumber;
    const pageSize = 20;
    const skipFactor = pageNumber ? (pageNumber - 1) * pageSize : 0;
    const limitFactor = pageNumber ? pageSize : 0;

    debug(`Page size: ${pageSize}\nPage number: ${pageNumber}`);

    // check if the post exists
    const post = await Post.findById(postId);
    if(!post) return res.status(404).send('Post with provided Id does not exist!');

    const comments = await Comment
        .find( { post_id: postId } )
        .skip( skipFactor )
        .limit( limitFactor )
        .sort( { date: 1 } )
        .select()
    
    res.send(comments);

});


/* POST COMMENT */
router.post('/', async (req, res) => {
    const postId = req.params.post_id;

    const { error, result } = validatePost(req.body);
    if (error) return res.status(400).send(error.message);

    // check if the post exists
    const post = await Post.findById(postId);
    if(!post) return res.status(404).send('Post with provided Id does not exist!');

    let comment = new Comment({
        user_id: req.body.user_id,
        content: req.body.content,
        post_id: postId,
        date: new Date()
    });

    comment = await comment.save()

    res.status(201).send(comment);
});

/* PUT METHOD COMMENT */
router.put('/:id', async (req, res) => {
    const id = req.params.id;

    const { error, value } = validatePut(req.body);
    if (error) return res.status(400).send(error.message);

    // check if it exists first
    const oldComment = await Comment.findById(id);
    if(!oldComment) return res.status(404).send('Resource not found!');
    
    let result;

    if(req.query.action){

        handleUpvoteDownvoteNotification(req);
        result = await handleUpvoteDownvoteDB(req);

    }else{
        
        let newComment = {
            content: req.body.content || oldComment.content
        };

        debug(newComment);

        oldComment.set(newComment);
        result = await oldComment.save();

    }


    res.status(204).send(result);
});


/* DELETE COMMENT */
router.delete('/:id', async (req, res) => {
    const id = req.params.id;

    const result = await Comment.deleteOne( { _id: id } )
    if(!result) res.status(404).send('Resource not found!');
    res.send(result);
});



async function handleUpvoteDownvoteNotification(req){
    const action = req.query.action;
    const commentId = req.params.id;
    const userId = req.body.user_id;
    if (action) {
        if (action === "upvote") {
            debug(`Send a user who commented a comment(id=${commentId}) that a user(id=${userId}) has liked his post`);
        }

        if (action === "downvote") {
            debug(`Send a user who commented a comment(id=${commentId}) that a user(id=${userId}) has disliked his post`);
        }
    }
}

async function handleUpvoteDownvoteDB(req){
    const action = req.query.action;
    const id = req.params.id;

    debug(action);

    if(action === "upvote"){
        return await Comment.updateOne( {_id: id}, {
            $inc: {
                likes: 1
            }},
            { new: true })

    }else if(action === "downvote"){
        return await Comment.updateOne( {_id: id}, {
            $inc: {
                dislikes: 1
            }}, 
            { new: true });
    }

}

module.exports = router;
