
const { sendResponse } = require('../utils/responseHelper');

const errorHandler = (err, req, res, next) => {
    console.error(err.stack);
    sendResponse(res, 500, false, err.message || 'Server Error');
};

module.exports = errorHandler;
