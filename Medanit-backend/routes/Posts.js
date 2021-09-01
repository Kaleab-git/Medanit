const debug = require('debug')('app:posts');        // set/export DEBUG=app:posts
const express = require('express');
const Joi = require('joi');
Joi.objectId = require('joi-objectid')(Joi)
const router = express.Router();


/* GET POSTS. */
router.get('/', (req, res) => {
    res.send("Get Posts");
});


/* GET POST WITH ID */
router.get('/:id', (req, res) => {
    const id = req.params.id;

    // first look up resource, if it doesn't exist return with 404


    res.send(`Get post with ID: ${id}`);
});


/* POST A NEW POST */
router.post('/', (req, res) => {
    const { error, value } = validatePost(req.body);
        if (error) return res.status(400).send(error.message);


    res.status(201).json(value);
});

/* PUT METHOD FOR A POST */
router.put('/:id', (req, res) => {
    const id = req.params.id;

    

    // first look up resource, if it doesn't exist return with 404

    const { error, value } = validateEdit(req.body);
    if (error) return res.status(400).send(error.message);


    handleUpvoteDownvote(req);
    

    res.send(`Put method on post with ID: ${id}`);
});


/* DELETE METHOD FOR A POST */
router.delete('/:id',  (req, res) => {
    const id = req.params.id;

    // first look up resource, if it doesn't exist return with 404


    res.send(`Deleting a post with ID: ${id}`);
});



function validatePost(post) {

    const schema = Joi.object({
        user_id: Joi.objectId().required(),
        title: Joi.string().max(50).required(),
        content: Joi.string().max(1000).required(),
        side_effects: Joi.array().required().min(0)
    });

    return schema.validate(post);
};


function validateEdit(post) {

    const schema = Joi.object({
        user_id: Joi.objectId().required(),
        title: Joi.string().max(50),
        content: Joi.string().max(1000),
        side_effects: Joi.array().min(0)
    });

    return schema.validate(post);
};

function handleUpvoteDownvote(req) {
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

module.exports = router;
