// Importing the mongoose library to create the schema and model
const mongoose = require('mongoose');

// Defining the schema for the User model
const userSchema = mongoose.Schema({
    // Field for the user's full name
    name: {
        // Specifying the type as String
        type: String,
        // Making this field required with a custom error message
        required: [true, 'Please add a name'],
    },
    // Field for the user's email address
    email: {
        // Specifying the type as String
        type: String,
        // Making this field required with a custom error message
        required: [true, 'Please add an email'],
        // Ensuring the email is unique in the database
        unique: true,
    },
    // Field for the user's encrypted password
    password: {
        // Specifying the type as String
        type: String,
        // Making this field required with a custom error message
        required: [true, 'Please add a password'],
    },
    // Field for storing the user's academic background details
    academicBackground: {
        // Sub-schema for subjects taken (e.g., Mathematics, Biology)
        subjects: [{
            // Name of the subject
            name: String,
            // Grade or score achieved in the subject
            grade: String,
        }],
        // Field for the national exam score (optional)
        nationalExamScore: {
            // Specifying the type as Number
            type: Number,
        },
        // Field for the user's career interest (e.g., Software Engineer)
        careerInterest: {
            // Specifying the type as String
            type: String,
        },
    },
}, {
    // Option to automatically add createdAt and updatedAt timestamps
    timestamps: true,
});

// Exporting the User model based on the userSchema
module.exports = mongoose.model('User', userSchema);
