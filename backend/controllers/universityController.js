
const University = require('../models/University');
const { sendResponse } = require('../utils/responseHelper');

// @desc    Get all universities
// @route   GET /api/universities
exports.getUniversities = async (req, res) => {
    try {
        const universities = await University.find();
        sendResponse(res, 200, true, 'Universities fetched successfully', universities);
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};

// @desc    Get single university
// @route   GET /api/universities/:id
exports.getUniversity = async (req, res) => {
    try {
        const university = await University.findById(req.params.id);
        if (university) {
            sendResponse(res, 200, true, 'University fetched successfully', university);
        } else {
            sendResponse(res, 404, false, 'University not found');
        }
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};

// @desc    Create a university
// @route   POST /api/universities
exports.createUniversity = async (req, res) => {
    try {
        const university = await University.create(req.body);
        sendResponse(res, 201, true, 'University created successfully', university);
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};

// @desc    Update a university
// @route   PUT /api/universities/:id
exports.updateUniversity = async (req, res) => {
    try {
        const university = await University.findByIdAndUpdate(req.params.id, req.body, {
            new: true,
            runValidators: true
        });

        if (university) {
            sendResponse(res, 200, true, 'University updated successfully', university);
        } else {
            sendResponse(res, 404, false, 'University not found');
        }
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};
// @desc    Delete a university
// @route   DELETE /api/universities/:id
exports.deleteUniversity = async (req, res) => {
    try {
        const university = await University.findByIdAndDelete(req.params.id);
        if (university) {
            sendResponse(res, 200, true, 'University deleted successfully');
        } else {
            sendResponse(res, 404, false, 'University not found');
        }
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};
