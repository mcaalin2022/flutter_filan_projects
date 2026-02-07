const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');
const { protect } = require('../middleware/authMiddleware');

// Middleware to check if user is admin
const adminOnly = (req, res, next) => {
    if (req.user && req.user.role === 'admin') {
        next();
    } else {
        res.status(403).json({ success: false, message: 'Access denied: Admin privileges required' });
    }
};

// @route   POST api/admin/users
// @desc    Register a new user manually
router.post('/users', protect, adminOnly, adminController.createUser);

// @route   GET api/admin/users
// @desc    Get all registered users
router.get('/users', protect, adminOnly, adminController.getAllUsers);

// @route   PUT api/admin/users/:id
// @desc    Update user details
router.put('/users/:id', protect, adminOnly, adminController.updateUser);

// @route   DELETE api/admin/users/:id
// @desc    Delete a user
router.delete('/users/:id', protect, adminOnly, adminController.deleteUser);

// @route   GET api/admin/raw-users
// @desc    Get all users with full raw data
router.get('/raw-users', protect, adminOnly, adminController.getAllRawUsers);

module.exports = router;
