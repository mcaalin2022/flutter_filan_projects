
const mongoose = require('mongoose');

const programSchema = new mongoose.Schema({
    universityId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'University',
        required: true
    },
    name: {
        type: String,
        required: true
    },
    duration: {
        type: String,
        required: true
    },
    requirements: {
        type: String,
        required: true
    }
}, {
    timestamps: true
});

module.exports = mongoose.model('Program', programSchema);
