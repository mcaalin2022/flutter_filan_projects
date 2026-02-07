const jwt = require('jsonwebtoken');
const env = require('../config/env');

// Importing handling the async errors (optional wrapper, but we'll use try/catch)
const asyncHandler = require('express-async-handler'); // If we were using it, but standard try/catch is fine here.

// Importing the User model to fetch user details associated with the token
const User = require('../models/User');

// Middleware function to protect properties routes
const protect = async (req, res, next) => {
    // Initializing a variable to hold the token
    let token;

    // Checking if the authorization header exists and starts with 'Bearer'
    if (
        req.headers.authorization &&
        req.headers.authorization.startsWith('Bearer')
    ) {
        // Starting a try-catch block to handle token verification errors
        try {
            // extracting the token from the header (removing 'Bearer ')
            token = req.headers.authorization.split(' ')[1];

            // Verifying the token using the secret key
            const decoded = jwt.verify(token, env.JWT_SECRET);

            // Fetching the user associated with the decoded ID, excluding the password field
            req.user = await User.findById(decoded.id).select('-password');

            // Proceeding to the next middleware or route handler
            next();
        } catch (error) {
            // Logging the error
            console.error(error);
            // Sending a 401 Unauthorized status if the token is invalid
            res.status(401).json({ message: 'Not authorized, token failed' });
        }
    }

    // If no token was found in the header
    if (!token) {
        // Sending a 401 Unauthorized status
        res.status(401).json({ message: 'Not authorized, no token' });
    }
};

// Exporting the protect middleware
module.exports = { protect };
