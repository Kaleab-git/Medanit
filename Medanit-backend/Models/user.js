const moment = require('moment');
const mongoose = require('mongoose');
const Joi = require('joi');
Joi.objectId = require('joi-objectid')(Joi);


const User = mongoose.model('User', new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
        minLength: 0,
        maxLength: 50
    },
    account_name: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        minLength: 0,
        maxLength: 50
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    profile_pic_url: {
        type: String
    },
    password: {
        type: String,
        required: true
    },
    verified: {
        type: Boolean,
        default: false
    },
    bio: {
        type: String,
        maxLength: 250
    },
    date: {
        type: Date,
        default: new Date(),
        get: date => moment(date, "YYYY-MM-DD[T00:00:00.000Z]").fromNow()
    }
}));



function validatePost(user) {
    const schema = Joi.object({
    });

    return schema.validate(user);
};

function validatePut(user) {
    const schema = Joi.object({
    });
    return schema.validate(user);
}

function validateId(id){
    return mongoose.Types.ObjectId.isValid(id)
}

exports.User = User;
exports.validatePost = validatePost;
exports.validatePut = validatePut;
exports.validateId = validateId;