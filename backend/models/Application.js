const mongoose = require('mongoose');

// ApplicationSchema defines the structure for university student applications
const ApplicationSchema = new mongoose.Schema({
    // Reference to the student who is applying
    studentId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    // Reference to the university being applied to
    universityId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'University',
        required: true
    },
    // Full legal name of the applicant
    fullName: {
        type: String,
        required: true
    },
    // Current residential address
    address: {
        type: String,
        required: true
    },
    // Contact phone number
    phone: {
        type: String,
        required: true
    },
    // Name of the high school or previous institution
    graduateSchool: {
        type: String,
        required: true
    },
    // Final grade or GPA from previous school
    grade: {
        type: String,
        required: true
    },
    // Age of the applicant
    age: {
        type: Number,
        required: true
    },
    // Gender selection (Male/Female)
    gender: {
        type: String,
        enum: ['Male', 'Female'],
        required: true
    },
    // List of faculties or programs the student is interested in
    facultiesInterested: [{
        type: String
    }],
    // Date when the application was submitted
    submittedAt: {
        type: Date,
        default: Date.now
    },
    // Current status of the application
    status: {
        type: String,
        enum: ['Pending', 'Reviewed', 'Accepted', 'Rejected'],
        default: 'Pending'
    }
}, { timestamps: true });

// Export the model to be used in controllers
module.exports = mongoose.model('Application', ApplicationSchema);
