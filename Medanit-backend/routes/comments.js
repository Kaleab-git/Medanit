const debug = require('debug')('app:comments');  // set/export DEBUG=app:comments
const express = require('express');
const Joi = require('joi');
Joi.objectId = require('joi-objectid')(Joi)
const router = express.Router({mergeParams:true});

/* GET COMMENTS UNDER A POST */
router.get('/', (req, res) => {
    const postId = req.params.post_id;

    debug('Comment get params: ' + JSON.stringify(req.params)    );
    // check if it exists first

    res.send(`Getting comments for Post with ID: ${postId}`);
});


/* POST COMMENT */
router.post('/', (req, res) => {
    const postId = req.params.post_id;

    const { error, result } = validatePostComment(req.body);
    if (error) return res.status(400).send(error.message);

    res.json(req.body);
});

/* PUT METHOD COMMENT */
router.put('/:id', (req, res) => {
    const id = req.params.id;

    // check if it exists first

    const { error, result } = validateEditComment(req.body);
    if (error) return res.status(400).send(error.message);

    debug(req.body);
    handleUpvoteDownvote(req);

    res.send(`Put method on comment with ID: ${id}`);
});


/* DELETE COMMENT */
router.delete('/:id', (req, res) => {
    const id = req.params.id;

    // check if it exists 

    res.send(`Deleting a comment with ID: ${id}`);
});

function validatePostComment(comment) {
    const schema = Joi.object({
        user_id: Joi.objectId().required(),
        content: Joi.string().max(1000).required()
    });

    return schema.validate(comment);
};

function validateEditComment(comment) {
    const schema = Joi.object({
        user_id: Joi.objectId().required(),
        content: Joi.string().max(1000)
    });
    return schema.validate(comment);
}

function handleUpvoteDownvote(req){
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
module.exports = router;
