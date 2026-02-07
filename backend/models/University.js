
const mongoose = require('mongoose');

const universitySchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    location: {
        type: String,
        required: true
    },
    tuitionRange: {
        type: String,
        required: true
    },
    faculties: [{
        type: String
    }],
    contactInfo: {
        type: String,
        required: true
    },
    admissionInfo: {
        type: String,
        default: 'Admission process follows national guidelines.'
    },
    feesInfo: {
        type: String,
        default: 'Fees vary by faculty.'
    },
    requirementsInfo: {
        type: String,
        default: 'High school certificate and entrance exam required.'
    },
    imageUrl: {
        type: String,
        default: 'https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=1000'
    }
}, {
    timestamps: true
});


module.exports = mongoose.model('University', universitySchema);
