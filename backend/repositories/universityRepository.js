// Importing the University model to interact with the universities collection
const University = require('../models/universityModel');

// Class representing the repository for University-related database operations
class UniversityRepository {
    // Method to create a new university in the database (admin usage mostly)
    async createUniversity(universityData) {
        // Creating a new instance of the University model
        const university = await University.create(universityData);
        // Returning the created university
        return university;
    }

    // Method to retrieve all universities from the database
    async getAllUniversities() {
        // finding all documents in the universities collection
        const universities = await University.find({});
        // Returning the list of universities
        return universities;
    }

    // Method to find a university by its ID
    async getUniversityById(id) {
        // Querying the database for a university with the matching ID
        const university = await University.findById(id);
        // Returning the found university
        return university;
    }

    // Method to search universities based on a keyword
    async searchUniversities(keyword) {
        // Creating a regex for case-insensitive matching
        const regex = new RegExp(keyword, 'i');
        // Querying the database for universities where the name or location matches the keyword
        const universities = await University.find({
            $or: [{ name: regex }, { location: regex }]
        });
        // Returning the list of matching universities
        return universities;
    }
}

// Exporting an instance of the UniversityRepository class
module.exports = new UniversityRepository();
