const _ = require('lodash');
const bcrypt = require('bcrypt');
const debug = require('debug')('app:users');        // set/export DEBUG=app:users
const express = require('express');

const { User, validatePost, validatePut, validateId } = require('../Models/user');
const auth = require('../Middlewares/auth');

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
                    
                    const token = user.generateAuthToken();

                    return res.header('x-auth-token', token).status(201).send(_.pick(result, ['_id', 'name', 'username', 'email']));
                }catch(err){
                    debug(err);
                    return res.status(500).send("Internal server error while trying to create a new post!");
                }
            }
        });
        
        
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error!");
    }

});

/* GET my account info and posts */
router.get('/me', auth, async (req, res) => {
    try{
        const user = await User.findById(req.user._id).populate('posts');
        return res.status(200).send(user);
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error!");
    }
});


/* GET a user account info and posts */
router.get('/:id', auth, async (req, res) => {
    const id = req.params.id;
    try{
        const user = await User.findById(id).populate('posts').select('-password -isAdmin -email');
        return res.status(200).send(user);
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error!");
    }
});





/* PUT method on a user */
router.put('/me', auth, (req, res) => {
    const id = req.params.id;
    res.send(`User put method on user with ID: ${id}`);
});


/* DELETE my account */
router.delete('/', auth, async (req, res) => {
    const { isAdmin, _id } = req.user;
    const accountID = req.query.id;

    console.log(isAdmin, accountID)

    // delete account as an admin
    if(accountID && isAdmin){
        const result = await User.findOneAndDelete( { _id: accountID });
        return res.send(result);
    }

    // delete own account
    if(accountID){
        return res.status(400).send('Invalid operation!');
    }else{
        const result = await User.findOneAndDelete( { _id: _id } );
        return res.send(result);
    }
});

module.exports = router;
