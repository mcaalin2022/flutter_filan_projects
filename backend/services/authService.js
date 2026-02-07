// Importing bcryptjs for password hashing and comparison
const bcrypt = require('bcryptjs');

// Importing jsonwebtoken for generating JWT tokens for authentication
const jwt = require('jsonwebtoken');

// Importing the UserRepository to interact with the database
const userRepository = require('../repositories/userRepository');

// Class representing the service for Authentication-related business logic
class AuthService {
    // Method to register a new user
    async register(userData) {
        // Checking if a user with the given email already exists
        const userExists = await userRepository.findUserByEmail(userData.email);

        // If the user exists, throwing an error
        if (userExists) {
            throw new Error('User already exists');
        }

        // Generating a salt for password hashing with 10 rounds
        const salt = await bcrypt.genSalt(10);

        // Hashing the user's password using the generated salt
        const hashedPassword = await bcrypt.hash(userData.password, salt);

        // Replacing the plain text password with the hashed password in user data
        const newUser = { ...userData, password: hashedPassword };

        // Creating the new user in the database via the repository
        return await userRepository.createUser(newUser);
    }

    // Method to authenticate a user (Login)
    async login(email, password) {
        // Finding the user by email
        const user = await userRepository.findUserByEmail(email);

        // If user is found and the password matches the hashed password
        if (user && (await bcrypt.compare(password, user.password))) {
            // Returning the user object along with a signed JWT token
            return {
                _id: user.id,
                name: user.name,
                email: user.email,
                // Generating the token
                token: this.generateToken(user._id),
            };
        } else {
            // If authentication fails, throwing an error
            throw new Error('Invalid credentials');
        }
    }

    // Helper method to generate a JWT token
    generateToken(id) {
        // Signing the token with the user's ID, using the secret from environment variables
        // The token is set to expire in 30 days
        return jwt.sign({ id }, process.env.JWT_SECRET || 'secret123', {
            expiresIn: '30d',
        });
    }
}

// Exporting an instance of the AuthService class
module.exports = new AuthService();
