
const University = require('../models/University');
const Program = require('../models/Program');
const { sendResponse } = require('../utils/responseHelper');

// @desc    Search universities and programs
// @route   GET /api/search
exports.search = async (req, res) => {
    try {
        const keyword = req.query.q;
        if (!keyword) {
            return sendResponse(res, 400, false, 'Please provide a search term');
        }

        const regex = new RegExp(keyword, 'i');

        const universities = await University.find({
            $or: [{ name: regex }, { location: regex }]
        });

        const programs = await Program.find({
            name: regex
        }).populate('universityId', 'name');

        sendResponse(res, 200, true, 'Search results', {
            universities,
            programs
        });
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};
