// Importing the User model to interact with the users collection
const User = require('../models/userModel');

// Class representing the repository for User-related database operations
class UserRepository {
    // Method to create a new user in the database
    async createUser(userData) {
        // Creating a new instance of the User model with the provided data
        const user = await User.create(userData);
        // Returning the created user document
        return user;
    }

    // Method to find a user by their email address
    async findUserByEmail(email) {
        // Querying the database for a user with the matching email
        const user = await User.findOne({ email });
        // Returning the found user document (or null if not found)
        return user;
    }

    // Method to find a user by their unique ID
    async findUserById(id) {
        // Querying the database for a user with the matching ID
        const user = await User.findById(id);
        // Returning the found user document
        return user;
    }

    // Method to update a user's profile information
    async updateUser(id, updateData) {
        // Finding a user by ID and updating their data
        // { new: true } returns the updated document instead of the original one
        const user = await User.findByIdAndUpdate(id, updateData, { new: true });
        // Returning the updated user document
        return user;
    }
}

// Exporting an instance of the UserRepository class for use in services
module.exports = new UserRepository();
