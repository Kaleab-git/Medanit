const moment = require('moment');
const mongoose = require('mongoose');
const { Comment } = require('./comment');
const Joi = require('joi');
Joi.objectId = require('joi-objectid')(Joi);


const Post = mongoose.model('Post', new mongoose.Schema({
    user_id: {
        type: mongoose.Types.ObjectId,
        required: true
    },

    title: {
        type: String,
        required: true,
        minlength: 2,
        maxlength: 70,
        trim: true
    },

    content: {
        type: String,
        required: true,
        minlength: 100,
        maxlength: 1000,
        trim: true
    },

    side_effects: {
        type: [ String ],
        required: true,
        minlength: 0,
        maxlength: 10,
        enum: ["headache", "dizziness", "constipation", "skin rash or dermatitis", 
                "drowsiness", "dry mouth", "headache", "insomnia", "nausea"]
    },

    comments: {
        type: [ mongoose.Schema.Types.ObjectId ] ,
        ref: 'Comment'
    },

    likes: { 
        type: Number, 
        default: 0
    },

    dislikes: { 
        type: Number, 
        default: 0
    },

    date: {
        type: Date,
        required: false,
        default: new Date(),
        get: date => moment(date, "YYYY-MM-DD[T00:00:00.000Z]").fromNow()
    }


}));


function validatePost(post) {

    const schema = Joi.object({
        user_id: Joi.objectId().required(),
        title: Joi.string().min(2).max(70).required(),
        content: Joi.string().min(100).max(1000).required(),
        side_effects: Joi.array().required().min(0)
    });

    return schema.validate(post);
};


function validatePut(post) {

    const schema = Joi.object({
        user_id: Joi.objectId().required(),
        title: Joi.string().min(2).max(70),
        content: Joi.string().min(100).max(1000),
        side_effects: Joi.array().min(0)
    });

    return schema.validate(post);
};

exports.Post = Post;
exports.validatePost = validatePost;
exports.validatePut = validatePut;