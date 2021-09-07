const debug = require('debug')('app:users'); // set/export DEBUG=app:users
const express = require('express');
const Joi = require('joi');
Joi.objectId = require('joi-objectid')(Joi)
const router = express.Router();

/* GET users listing. */
router.get('/', (req, res) => {
    res.send('Users get method');
});


/* GET a user */
router.get('/:id', (req, res) => {
    const id = req.params.id;
    res.send(`Get a user with ID: ${id}`)
});

/* GET a user's posts */
router.get('/:id/posts', (req, res) => {
    const id = req.params.id;
    res.send(`Get posts from a user with ID ${id}`);
});

/* GET a user's posts */
router.get('/posts', (req, res) => {
    res.send('Get a specific user\'s posts');
});


/* PUT methon on a user */
router.put('/:id', (req, res) => {
    const id = req.params.id;
    res.send(`User put method on user with ID: ${id}`);
});

module.exports = router;
