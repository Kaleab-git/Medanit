const moment = require('moment');
const mongoose = require('mongoose');
const jwt = require('jsonwebtoken');
const Joi = require('joi');
const config = require('config');
Joi.objectId = require('joi-objectid')(Joi);

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
        minLength: 0,
        maxLength: 50
    },
    username: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        minLength: 1,
        maxLength: 15
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
    isAdmin: {
        type: Boolean,
        default: false
    },
    bio: {
        type: String,
        maxLength: 250
    },
    joined: {
        type: Date,
        default: new Date(),
        get: date => moment(date, "YYYY-MM-DD[T00:00:00.000Z]").fromNow()
    },

    birthdate: {
        type: Date,
        get: date => moment(date).format('LL')
    }
});

userSchema.methods.generateAuthToken = function(){
    const payload = { _id: this._id, isAdmin: this.isAdmin };
    return jwt.sign(payload , config.get('jwtPrivateKey'));
}

const User = mongoose.model('User', userSchema);





function validatePost(user) {
    const schema = Joi.object({
        name: Joi.string().max(50).required(),
        username: Joi.string().min(5).max(15).regex(/^@?(\w){1,15}$/).required(),
        email: Joi.string().email().min(5).max(255).required(),
        password: Joi.string().min(8).max(20).required(),
        birthdate: Joi.date().max('01-01-2003').iso().messages({'date.format': `Date format is YYYY-MM-DD`,'date.max':`Age must be 18+`}).required()
    })

    return schema.validate(user);
};

function validatePut(user) {
    const schema = Joi.object({
        name: Joi.string().max(50),
        username: Joi.string().min(5).max(15).regex(/^@?(\w){1,15}$/),
        email: Joi.string().email().min(5).max(255),
        password: Joi.string().min(8).max(20),
        bio: Joi.string().max(250),
        profile_pic_url: Joi.string()
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