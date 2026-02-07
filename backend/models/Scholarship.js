
const mongoose = require('mongoose');

const scholarshipSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    eligibility: {
        type: String,
        required: true
    },
    deadline: {
        type: Date,
        required: true
    }
}, {
    timestamps: true
});

module.exports = mongoose.model('Scholarship', scholarshipSchema);
