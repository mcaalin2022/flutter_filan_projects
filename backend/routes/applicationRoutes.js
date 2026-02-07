const express = require('express');
const router = express.Router();
const applicationController = require('../controllers/applicationController');
const { protect } = require('../middleware/authMiddleware'); // Middleware to verify JWT token

// @route   POST api/applications
// @desc    Submit a new university application
// @access  Private (Logged-in students)
router.post('/', protect, applicationController.submitApplication);

// @route   GET api/applications/my
// @desc    Get all applications submitted by the logged-in student
// @access  Private
router.get('/my', protect, applicationController.getMyApplications);

// @route   GET api/applications/stats
// @desc    Get dashboard stats (Admin only)
router.get('/stats', protect, applicationController.getAdminStats);

// @route   GET api/applications/all
// @desc    Get all applications (Admin only)
router.get('/all', protect, applicationController.getAllApplications);

// @route   PUT api/applications/:id
// @desc    Update application (Admin only)
router.put('/:id', protect, applicationController.updateApplication);

// @route   DELETE api/applications/:id
// @desc    Delete application (Admin only)
router.delete('/:id', protect, applicationController.deleteApplication);

module.exports = router;
