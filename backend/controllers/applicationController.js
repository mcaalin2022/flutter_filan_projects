const Application = require('../models/Application');
const University = require('../models/University');
const User = require('../models/User');

// ApplicationController handles logic for submitting and retrieving student applications
exports.submitApplication = async (req, res) => {
    try {
        console.log('Application Submission Attempt:', req.body);
        console.log('User ID from Token:', req.user ? req.user.id : 'NO USER');

        const {
            universityId,
            fullName,
            address,
            phone,
            graduateSchool,
            grade,
            age,
            gender,
            facultiesInterested
        } = req.body;

        // Strict Validation: Check for empty fields
        if (!universityId || !fullName || !address || !phone || !graduateSchool || !grade || !age || !gender || !facultiesInterested || facultiesInterested.length === 0) {
            console.log('Validation Failed: Missing Fields');
            return res.status(400).json({ success: false, message: 'All fields are required and cannot be empty' });
        }

        // Phone Validation: Only numeric values accepted
        const phoneRegex = /^[0-9]+$/;
        if (!phoneRegex.test(phone)) {
            console.log('Validation Failed: Invalid Phone');
            return res.status(400).json({ success: false, message: 'Phone number must contain only digits' });
        }

        const newApplication = new Application({
            studentId: req.user.id,
            universityId,
            fullName,
            address,
            phone,
            graduateSchool,
            grade,
            age,
            gender,
            facultiesInterested
        });

        const savedApplication = await newApplication.save();
        console.log('Application Saved Successfully:', savedApplication._id);

        res.status(201).json({
            success: true,
            message: 'Application submitted successfully',
            data: savedApplication
        });
    } catch (error) {
        console.error('Submit Application Error:', error, error.stack);
        res.status(500).json({ success: false, message: 'Server error while submitting application', error: error.message });
    }
};

// Admin: Get all applications for dashboard
exports.getAllApplications = async (req, res) => {
    try {
        const applications = await Application.find()
            .populate('universityId', 'name')
            .populate('studentId', 'name email');
        res.status(200).json({ success: true, data: applications });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

// Admin: Get Dashboard Stats
exports.getAdminStats = async (req, res) => {
    try {
        const totalUniversities = await University.countDocuments();
        const totalApplications = await Application.countDocuments();
        const totalStudents = await User.countDocuments({ role: 'user' });
        const totalAdmins = await User.countDocuments({ role: 'admin' });
        const totalUsers = await User.countDocuments();

        res.status(200).json({
            success: true,
            data: {
                totalUniversities,
                totalApplications,
                totalStudents,
                totalAdmins,
                totalUsers
            }
        });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

// Admin: Update Application status or details
exports.updateApplication = async (req, res) => {
    try {
        const { id } = req.params;
        const updatedApp = await Application.findByIdAndUpdate(id, req.body, { new: true });
        if (!updatedApp) return res.status(404).json({ success: false, message: 'Application not found' });
        res.status(200).json({ success: true, message: 'Application updated successfully', data: updatedApp });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

// Admin: Delete Application
exports.deleteApplication = async (req, res) => {
    try {
        const { id } = req.params;
        const deletedApp = await Application.findByIdAndDelete(id);
        if (!deletedApp) return res.status(404).json({ success: false, message: 'Application not found' });
        res.status(200).json({ success: true, message: 'Application deleted successfully' });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

// Get all applications for the logged-in user
exports.getMyApplications = async (req, res) => {
    try {
        const applications = await Application.find({ studentId: req.user.id })
            .populate('universityId', 'name imageUrl location');
        res.status(200).json({ success: true, data: applications });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};
