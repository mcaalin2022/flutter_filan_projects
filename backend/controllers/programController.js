
const Program = require('../models/Program');
const { sendResponse } = require('../utils/responseHelper');

// @desc    Get all programs (optionally filter by university)
// @route   GET /api/programs
exports.getPrograms = async (req, res) => {
    try {
        let query = {};
        if (req.query.universityId) {
            query.universityId = req.query.universityId;
        }

        const programs = await Program.find(query).populate('universityId', 'name location');
        sendResponse(res, 200, true, 'Programs fetched successfully', programs);
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};

// @desc    Get single program
// @route   GET /api/programs/:id
exports.getProgram = async (req, res) => {
    try {
        const program = await Program.findById(req.params.id).populate('universityId', 'name');
        if (program) {
            sendResponse(res, 200, true, 'Program fetched successfully', program);
        } else {
            sendResponse(res, 404, false, 'Program not found');
        }
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};

// @desc    Create a program
// @route   POST /api/programs
exports.createProgram = async (req, res) => {
    try {
        const program = await Program.create(req.body);
        sendResponse(res, 201, true, 'Program created successfully', program);
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};

// @desc    Update a program
// @route   PUT /api/programs/:id
exports.updateProgram = async (req, res) => {
    try {
        const program = await Program.findByIdAndUpdate(req.params.id, req.body, {
            new: true,
            runValidators: true
        });

        if (program) {
            sendResponse(res, 200, true, 'Program updated successfully', program);
        } else {
            sendResponse(res, 404, false, 'Program not found');
        }
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};
// @desc    Delete a program
// @route   DELETE /api/programs/:id
exports.deleteProgram = async (req, res) => {
    try {
        const program = await Program.findByIdAndDelete(req.params.id);
        if (program) {
            sendResponse(res, 200, true, 'Program deleted successfully');
        } else {
            sendResponse(res, 404, false, 'Program not found');
        }
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};
