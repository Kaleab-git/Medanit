const mongoose = require('mongoose');
const _ = require('lodash');
const bcrypt = require('bcrypt');
const debug = require('debug')('app:users');        // set/export DEBUG=app:users
const express = require('express');

const { User, validatePost, validatePut, validateId } = require('../Models/user');

const router = express.Router();


/* Register a user */
router.post('/', async (req, res) => {
    const { error, value } = validatePost(req.body);
    let result;
    if (error) return res.status(400).send(error.message);

    

    try{

        let user = await User.findOne( { email: value.email } )
        if(user) return res.status(400).send('Email already taken.');
        
        user = await User.findOne( { username: value.username } )
        if(user) return res.status(400).send('Username already taken.')


        user = new User({
            ...value,
            joined: new Date()
        });


        user.validate(async (err) => {
            if(err){
                return res.status(400).send(err.message);
            }else{  
                try{
                    const salt = await bcrypt.genSalt(10);
                    user.password = await bcrypt.hash(user.password, salt);
                    result = await user.save();
                    return res.status(201).send(_.pick(result, ['_id', 'name', 'username', 'email']));
                }catch(err){
                    debug(err);
                    return res.status(500).send("Internal server error while trying to create a new post!");
                }
            }
        });
        
        
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error while trying to create a new post!");
    }

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
