const _ = require('lodash');
const bcrypt = require('bcrypt');
const debug = require('debug')('app:users');        // set/export DEBUG=app:users
const express = require('express');

const { Post } = require('../Models/post');
const { Comment } = require('../Models/comment');
const { User, validatePost, validatePut, validateId } = require('../Models/user');


const mongoose = require('mongoose');
const Fawn = require('fawn');

const auth = require('../Middlewares/auth');

const router = express.Router();
const port = process.env.PORT || 3000;
Fawn.init(`mongodb://localhost:27017/Medanit`);


/* Register a user */
router.post('/', async (req, res) => {
    const { error, value } = validatePost(req.body);
    let result;
    if (error) return res.status(400).send({message: error.message});

    

    try{

        let user = await User.findOne( { email: value.email } );
        if(user) return res.status(400).json({message: "Email already exists"});
            
        user = await User.findOne( { username: value.username } );
        if(user) return res.status(400).json({message: "Username already exists."});
        

        user = new User({
            ...value,
            joined: new Date()
        });


        user.validate(async (err) => {
            if(err){
                return res.status(400).json({message: err.message});
            }else{  
                try{
                    const salt = await bcrypt.genSalt(10);
                    user.password = await bcrypt.hash(user.password, salt);
                    result = await user.save();
                    
                    const token = user.generateAuthToken();
                    
                    // reallly sorry for changing this part of your code. It was really cool. I just needed more info
                    // return res.header('x-auth-token', token).status(201).send(_.pick(result, ['_id', 'name', 'username', 'email']));

                    return res.header('x-auth-token', token).status(201).json({message:"success"});
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

/* GET my account info */
router.get('/me', auth, async (req, res) => {
    let postCount = upvoteCount = downvoteCount = 0 ;
    try{
        const user = await User.findById(req.user._id);
        const posts = await Post.find( { user_id: req.user._id } );

        if(!user) return res.status(400).send('Invalid id.');   

        postCount = posts.length;
        posts.forEach(post => {
            upvoteCount += post.likes;
            downvoteCount += post.dislikes;
        });

        return res.status(200).send({ ...user._doc, upvotes: upvoteCount, downvotes: downvoteCount, posts: postCount});
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error!");
    }
});


/* GET a user account info */
router.get('/:id', auth, async (req, res) => {
    const id = req.params.id;
    let postCount = upvoteCount = downvoteCount = 0 ;

    if(!validateId(id)) return res.status(400).send('Invalid Id.');

    try{
        const user = await User.findById(id).select('-password -isAdmin -email');
        if(!user) return res.status(400).send('Invalid request.');

        const posts = await Post.find( { user_id: id } );

        postCount = posts.length;
        posts.forEach(post => {
            upvoteCount += post.likes;
            downvoteCount += post.dislikes;
        });

        return res.status(200).send({ ...user._doc, upvotes: upvoteCount, downvotes: downvoteCount, posts: postCount, notifications: undefined});
    }catch(err){
        debug(err.message);
        return res.status(500).send("Internal server error!");
    }
});

/* GET a user's posts */
router.get('/:id/posts', async (req, res) => {
    const id = req.params.id;
    if(!mongoose.isValidObjectId(id)) return res.status(400).send('Invalid Id.');

    try{
        let posts = await Post.find( { user_id: id } );

        posts = updateDate(posts)
        posts = updateComment(posts);

        return res.send(posts);
    }catch(err){
        debug(err.message);
        return res.status(500).send('Internal server error!');
    }
});



/* PUT method on a user */
router.put('/me', auth, async (req, res) => {
    const { error, value } = validatePut(req.body);
    if (error) return res.status(400).send(error.message);

    try{
        const oldAccount = await User.findOne( {_id: req.user._id} );

        let password = req.body.password;
        if(password){
            const salt = await bcrypt.genSalt(10);
            password = await bcrypt.hash(password, salt);
        }
        let newAccount = {
            name: req.body.name || oldAccount.name,
            username: req.body.username || oldAccount.username,
            email: req.body.email || oldAccount.email,
            password: password || oldAccount.password,
            bio: req.body.bio || oldAccount.bio,
            profile_pic_url: req.body.profile_pic_url || oldAccount.profile_pic_url

        }

        oldAccount.set(newAccount);
        let result = await oldAccount.save();
        return res.status(204).send(result);
    }catch(err){
        debug(err);
        return res.status(500).send('Internal server error.');
    }

    
});


/* DELETE my account */
router.delete('/', auth, async (req, res) => {
    const { isAdmin, _id } = req.user;
    const accountID = req.query.id;


    // delete account as an admin
    if(accountID && isAdmin){
        debug('deleting account as admin...')
        try{
            await User.deleteOne( {_id: accountID })
            await Post.deleteMany( { user_id: accountID })
            await Comment.deleteMany( {user_id: accountID })
            return res.status(204).send('Account deleted');
        }catch(err){
            debug(err.message);
            return res.status(500).send("Internal server error!");
        };

    }

    // TODO: transaction not working, maybe only delete the user account 
    // delete own account
    if(accountID){
        return res.status(400).send('Invalid operation!');
    }else{
        try{
            await User.deleteOne( {_id: _id })
            await Post.deleteMany( { user_id: _id })
            await Comment.deleteMany( {user_id: _id })
            return res.status(204).send('Account deleted');
        }catch(err){
            debug(err.message);
            return res.status(500).send("Internal server error!");
        };
    }
});



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
