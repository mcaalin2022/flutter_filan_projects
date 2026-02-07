
const User = require('../models/User');
const jwt = require('jsonwebtoken');
const { sendResponse } = require('../utils/responseHelper');
const env = require('../config/env');

const generateToken = (id) => {
    return jwt.sign({ id }, env.JWT_SECRET, {
        expiresIn: '30d',
    });
};

exports.register = async (req, res) => {
    try {
        console.log('Registration attempt:', req.body);
        const { name, password, role } = req.body;
        const email = req.body.email.toLowerCase(); // Normalize email

        console.log('Checking if user exists for:', email);
        const userExists = await User.findOne({ email });
        // ... (rest of the code remains similar but using normalized email)
        if (userExists) {
            return sendResponse(res, 400, false, 'User already exists');
        }

        const user = await User.create({
            name,
            email,
            password,
            role
        });
        // ...
        if (user) {
            const token = generateToken(user._id);
            sendResponse(res, 201, true, 'User registered successfully', {
                _id: user._id,
                name: user.name,
                email: user.email,
                role: user.role,
                token: token,
            });
        } else {
            sendResponse(res, 400, false, 'Invalid user data');
        }
    } catch (error) {
        console.error('Registration Error:', error);
        sendResponse(res, 500, false, error.message);
    }
};

exports.login = async (req, res) => {
    try {
        const { password } = req.body;
        const email = req.body.email.toLowerCase(); // Normalize email

        const user = await User.findOne({ email });

        if (user && (await user.matchPassword(password))) {
            sendResponse(res, 200, true, 'Login successful', {
                _id: user._id,
                name: user.name,
                email: user.email,
                role: user.role,
                token: generateToken(user._id),
            });
        } else {
            sendResponse(res, 401, false, 'Invalid email or password');
        }
    } catch (error) {
        sendResponse(res, 500, false, error.message);
    }
};

exports.resetPassword = async (req, res) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return sendResponse(res, 400, false, 'Email and password are required');
        }

        const normalizedEmail = email.toLowerCase();
        console.log('Reset password attempt for:', normalizedEmail);

        const user = await User.findOne({ email: normalizedEmail });

        if (!user) {
            console.log('User not found during reset:', normalizedEmail);
            return sendResponse(res, 404, false, 'User not found');
        }

        console.log('User found, updating password for:', normalizedEmail);
        user.password = password;
        await user.save();
        console.log('Password updated successfully for:', normalizedEmail);

        sendResponse(res, 200, true, 'Password reset successfully');
    } catch (error) {
        console.error('Reset Password Error:', error);
        sendResponse(res, 500, false, error.message);
    }
};
