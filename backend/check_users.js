const mongoose = require('mongoose');
const User = require('./models/User');
const env = require('./config/env');

const checkUsers = async () => {
    try {
        console.log('--- DATABASE USER CHECK ---');
        console.log('Connecting to MongoDB...');
        await mongoose.connect(env.MONGODB_URI);

        const users = await User.find().select('-password');

        if (users.length === 0) {
            console.log('No users found in the database.');
        } else {
            console.log(`Found ${users.length} users:`);
            console.table(users.map(u => ({
                ID: u._id.toString(),
                Name: u.name,
                Email: u.email,
                Role: u.role,
                CreatedAt: u.createdAt
            })));
        }

    } catch (err) {
        console.error('Database Error:', err.message);
    } finally {
        await mongoose.disconnect();
        console.log('---------------------------');
        process.exit(0);
    }
};

checkUsers();
