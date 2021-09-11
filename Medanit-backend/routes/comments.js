const debug = require('debug')('app:comments');  // set/export DEBUG=app:comments
const _ = require('lodash');
const express = require('express');

const { Comment, validatePost, validatePut, validateId } = require('../Models/comment');
const { Post } = require('../Models/post');
const { User } = require('../Models/user');
const { Notification } = require('../Models/notification');
const auth = require('../Middlewares/auth');


const router = express.Router({mergeParams:true});


/* get comments under a post */
router.get('/', auth, async (req, res) => {
    const postId = req.params.post_id;
    const pageNumber = req.query.pageNumber;
    const pageSize = 20;
    const skipFactor = pageNumber ? (pageNumber - 1) * pageSize : 0;
    const limitFactor = pageNumber ? pageSize : 0;

    // debug(`Page size: ${pageSize}\nPage number: ${pageNumber}`);

    if(!validateId(postId)) return res.status(404).send('Invalid Post Id!');
    
    try{
        // check if the post exists
        const post = await Post.findById(postId);
        if(!post) return res.status(404).send('Post with provided Id does not exist!');

        let comments = await Comment
            .find( { post_id: postId } )
            .skip( skipFactor )
            .limit( limitFactor )
            .sort( { date: -1 } )
            .select()
        

        comments = updateDate(comments); 

        return res.send(comments);

    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error while getting comments!");
    }

});


/* POST COMMENT */
router.post('/', auth, async (req, res) => {
    const postId = req.params.post_id;
    const userId = req.user._id;

    const { error, result } = validatePost(req.body);
    if (error) return res.status(400).send(error.message);

    if(!validateId(postId)) return res.status(404).send('Invalid Post Id!');


    // check if the post exists
    try{
        const post = await Post.findById(postId);
        if(!post) return res.status(404).send('Post with provided Id does not exist!');

        let user = await User.findById(post.user_id);
        if(!user) return res.status(400).send('Invalid id.');

        let notification = new Notification({
            from: userId,
            trigger: "comment",
            target: "post",
            targetId: postId,
            date: new Date() 
        });

        
        debug(notification)
        user.notifications.push(notification);
        // await user.save();

        let comment = new Comment({
            user_id: req.user._id,
            content: req.body.content,
            post_id: postId,
            date: new Date()
        }); 

        post.comments.push(comment);
        // post.save();

        // comment = await comment.save()
        return res.status(201).send({...comment._doc, date: comment.date});
        
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error while saving comment!")
    }
});

/* PUT METHOD COMMENT */
router.put('/:id', auth, async (req, res) => {
    const postId = req.params.post_id;
    const currentUser = req.user._id.toString();
    const id = req.params.id;
    const isAdmin = req.user.isAdmin;


    const { error, value } = validatePut(req.body);
    if (error) return res.status(400).send(error.message);

    if(!validateId(id)) return res.status(404).send('Invalid Comment Id!');
    if(!validateId(postId)) return res.status(404).send('Invalid Post Id!');


    
    
    try{
        // check if it exists first
        const oldComment = await Comment.findById(id);
        if(!oldComment) return res.status(404).send('Resource not found!');
        
        let result;

        if(req.query.action){
            handleUpvoteDownvoteNotification(req, res);
            result = await handleUpvoteDownvoteDB(req, res);
        }else{

            if(oldComment.user_id.toString() !== currentUser && !isAdmin) return res.status(403).send('Forbidden action!');


            let newComment = {
                content: req.body.content || oldComment.content
            };
            debug(newComment);
            oldComment.set(newComment);
            result = await oldComment.save();
        }

        return res.status(204).send(result);

    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error while modifying comment!")
    }
});


/* DELETE COMMENT */
router.delete('/:id', auth, async (req, res) => {
    const id = req.params.id;
    const postId = req.params.post_id;
    const isAdmin = req.user.isAdmin;
    const currentUser = req.user._id.toString();

    if(!validateId(postId)) return res.status(404).send('Invalid Post Id!');
    if(!validateId(id)) return res.status(404).send('Invalid Comment Id!');
    
    try{
        const oldComment = await Comment.findById( id )
        if(!oldComment) return res.status(404).send('Resource not found!');
        if(oldComment.user_id.toString() !== currentUser && !isAdmin) return res.status(403).send('Forbidden action!');
        oldComment.remove();
        return res.send(oldComment);
    }catch(err){
        debug(err);
        return res.status(500).send("Internal server error while trying to delete comment!");
    }
    
});



async function handleUpvoteDownvoteNotification(req, res){
    const action = req.query.action;
    const commentId = req.params.id;
    const userId = req.user._id;

    let comment = await Comment.findById(commentId);
    let user = await User.findById(comment.user_id);
    if(!comment) return res.status(400).send('Invalid id.');

    let notification = new Notification({
        from: userId,
        trigger: "",
        target: "comment",
        targetId: commentId,
        date: new Date() 
    });

    if (action) {
        if (action === "upvote") {
            debug(`Send a user who commented a comment(id=${commentId}) that a user(id=${userId}) has liked his post`);
            
            notification.trigger = "like";
            user.notifications.push(notification);
            await user.save();
        }

        if (action === "downvote") {
            debug(`Send a user who commented a comment(id=${commentId}) that a user(id=${userId}) has disliked his post`);
            
            notification.trigger = "like";
            user.notifications.push(notification);
            await user.save();
        }
    }
}

async function handleUpvoteDownvoteDB(req, res){
    const action = req.query.action;
    const commentId = req.params.id;
    const userId = req.user._id;
    let hasLiked = hasDisliked = false;

    const user = await User.findById(userId);
    if(!user) return res.status(400).send('Invalid id;');

    let likes = user.likedComments.map(obj => obj.toString());
    let dislikes = user.dislikedComments.map(obj => obj.toString());

    if(_.includes(likes, commentId)) hasLiked = true;
    if(_.includes(dislikes, commentId)) hasDisliked = true;

    async function alterLikes(value){
        await Comment.updateOne({ _id: commentId }, {
            $inc: {
                likes: value
            }
        } , { new: true });

        if(value === 1){
            user.likedComments.push(commentId);
            await user.save();
        }else if(value === -1){
            const updatedArr = _.remove(likes, commentId);
            user.likedComments = updatedArr;
            await user.save();
        }
    }

    async function alterDislikes(value){
        await Comment.updateOne({ _id: commentId }, {
            $inc: {
                dislikes: value
            }
        }, { new: true });

        if(value === 1){
            user.dislikedComments.push(commentId);
            await user.save();
        }else if(value === -1){
            const updatedArr = _.remove(dislikes, commentId);
            user.dislikedComments = updatedArr;
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

function updateDate(comments){
    let commentsFinal = [];
    comments.forEach(comment => {
        let date = comment.date
        commentsFinal.push({
            ...comment._doc,
            date: date
        });
    });
    return commentsFinal;
}

module.exports = router;
