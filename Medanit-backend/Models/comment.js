const moment = require('moment');
const mongoose = require('mongoose');
const Joi = require('joi');
Joi.objectId = require('joi-objectid')(Joi);


const Comment = mongoose.model('Comment', new mongoose.Schema({
    user_id: {
        type: mongoose.Types.ObjectId,
        required: true
    },

    post_id: {
        type: mongoose.Types.ObjectId,
        required: false
    },

    content: {
        type: String,
        required: true,
        min: 1,
        max: 1000
    },

    dislikes: {
        type: Number,
        default: 0
    },

    likes: {
        type: Number,
        default: 0
    },
    
    date: {
        type: Date,
        default: new Date(),
        get: date => moment(date, "YYYY-MM-DD[T00:00:00.000Z]").fromNow()
    }
}));



function validatePost(comment) {
    const schema = Joi.object({
        user_id: Joi.objectId().required(),
        content: Joi.string().min(1).max(1000).required()
    });

    return schema.validate(comment);
};

function validatePut(comment) {
    const schema = Joi.object({
        user_id: Joi.objectId().required(),
        content: Joi.string().min(1).max(1000)
    });
    return schema.validate(comment);
}

function validateId(id){
    return mongoose.Types.ObjectId.isValid(id)
}

exports.Comment = Comment;
exports.validatePost = validatePost;
exports.validatePut = validatePut;
exports.validateId = validateId;