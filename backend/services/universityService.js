// Importing the UniversityRepository to handle database interactions
const universityRepository = require('../repositories/universityRepository');

// Class representing the service for University-related business logic
class UniversityService {
    // Method to create a new university (Admin function)
    async createUniversity(universityData) {
        // Calling the repository to create the university
        return await universityRepository.createUniversity(universityData);
    }

    // Method to get all universities
    async getAllUniversities() {
        // Calling the repository to get all universities
        return await universityRepository.getAllUniversities();
    }

    // Method to get a single university by ID
    async getUniversityById(id) {
        // Calling the repository to find the university by ID
        const university = await universityRepository.getUniversityById(id);

        // If not found, throwing an error
        if (!university) {
            throw new Error('University not found');
        }

        // Returning the university object
        return university;
    }

    // Method to search universities
    async searchUniversities(keyword) {
        // If no keyword is provided, return all universities
        if (!keyword) {
            return await universityRepository.getAllUniversities();
        }

        // Calling the repository to search by keyword
        return await universityRepository.searchUniversities(keyword);
    }
}

// Exporting an instance of the UniversityService class
module.exports = new UniversityService();
