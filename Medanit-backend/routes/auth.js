const Joi = require('joi');
const bcrypt = require('bcrypt');
const debug = require('debug')('app:auth');        // set/export DEBUG=app:auth
const express = require('express');

const { User } = require('../Models/user');

const router = express.Router();


/* Login */
router.post('/', async (req, res) => {
    const { error, value } = validate(req.body);
    if(error) return res.status(400).send(error.message);

    
    try{
        
        let user = await User.findOne( { username: value.username } )
        if(!user) return res.status(400).send('Invalid username or password.');
        
        const validPassword = await bcrypt.compare(req.body.password, user.password);
        if(!validPassword) return res.status(400).send('Invalid username or password.');
        
        const token = user.generateAuthToken();
        
        return res.send(token);
        
        
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error while trying to create a new post!");
    }

});

function validate(user) {
    const schema = Joi.object({
        username: Joi.string().min(5).max(15).regex(/^@?(\w){1,15}$/).required(),
        password: Joi.string().min(8).max(20).required()
    });

    return schema.validate(user);
};


module.exports = router;
