// Importing the mongoose library to create the schema and model
const mongoose = require('mongoose');

// Defining the schema for the University model
const universitySchema = mongoose.Schema({
    // Field for the university's name
    name: {
        // Specifying the type as String
        type: String,
        // Making this field required
        required: true,
    },
    // Field for the university's location (e.g., Mogadishu, Somalia)
    location: {
        // Specifying the type as String
        type: String,
        // Making this field required
        required: true,
    },
    // Field for the URL or path to the university's image
    imageUrl: {
        // Specifying the type as String
        type: String,
        // Making this field required
        required: true,
    },
    // Field for a brief description of the university
    description: {
        // Specifying the type as String
        type: String,
        // Making this field required
        required: true,
    },
    // Field to indicate if the university is public or private
    type: {
        // Specifying the type as String (e.g., 'Public', 'Private')
        type: String,
        // Making this field required
        required: true,
    },
    // Field for the duration of programs (e.g., '4 Years')
    duration: {
        // Specifying the type as String
        type: String,
        // Making this field required
        required: true,
    },
    // Field for the tuition fees
    tuition: {
        // Specifying the type as String or Number (String allowed for currency symbols)
        type: String,
        // Making this field required
        required: true,
    },
    // Field for the list of programs/faculties offered
    programs: [{
        // Name of the faculty/program (e.g., Faculty of Medicine)
        name: String,
        // Description or details about the program
        details: String,
    }],
    // Field for admission requirements
    admissionRequirements: {
        // Minimum grade required
        minimumGrade: String,
        // Examination basis
        examination: String,
        // List of required documents
        requiredDocuments: [String],
    },
    // Field for contact information
    contact: {
        // Phone number
        phone: String,
        // Email address
        email: String,
        // Website URL
        website: String,
    },
}, {
    // Option to automatically add createdAt and updatedAt timestamps
    timestamps: true,
});

// Exporting the University model based on the universitySchema
module.exports = mongoose.model('University', universitySchema);
