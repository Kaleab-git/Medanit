const mongoose = require('mongoose');

const NotificationSchema = new mongoose.Schema({
    // TODO: add custom validation b/c trigger and target cannot be the same 

    from: {
        type: mongoose.Schema.Types.ObjectId,
        required: true
    },

    trigger: {
        type: String,
        enum: ["like", "dislike", "comment"],
        required: true 
    },

    target: {
        type: String,
        enum: ["comment", "post"],
        required: true
    },
    
    targetId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true
    },
    
    date: {
        type: Date,
        default: new Date()
    }
})

const Notification = mongoose.model('Notification', NotificationSchema);



exports.Notification = Notification;
exports.NotificationSchema = NotificationSchema;
