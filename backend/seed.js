const mongoose = require('mongoose');
const dotenv = require('dotenv');
const env = require('./config/env');

const User = require('./models/User');
const University = require('./models/University');
const Program = require('./models/Program');
const Scholarship = require('./models/Scholarship');

dotenv.config();

const connectDB = async () => {
    try {
        const conn = await mongoose.connect(env.MONGODB_URI);
        console.log(`MongoDB Connected: ${conn.connection.host}`);
    } catch (error) {
        console.error(`Error: ${error.message}`);
        process.exit(1);
    }
};

const importData = async () => {
    try {
        await connectDB();

        // Clear existing data
        await User.deleteMany();
        await University.deleteMany();
        await Program.deleteMany();
        await Scholarship.deleteMany();

        console.log('Data Destroyed...');

        // Create Users
        // Note: The User model has a pre-save hook that hashes the password.
        const users = await User.create([
            {
                name: 'Admin User',
                email: 'admin@example.com',
                password: 'password123',
                role: 'admin'
            },
            {
                name: 'Test User',
                email: 'user@example.com',
                password: 'password123',
                role: 'user'
            }
        ]);

        console.log('Users Imported!');

        // Create Universities
        const universities = await University.create([
            {
                name: 'SIMAD University',
                location: 'Mogadishu, Somalia',
                tuitionRange: '$500 - $1200',
                faculties: ['Computing', 'Business Administration', 'Social Sciences', 'Economics', 'Law', 'Engineering'],
                contactInfo: 'info@simad.edu.so',
                admissionInfo: 'Entrance exam required. Intake in September and March.',
                feesInfo: 'Registration: $50. Credit hour: $15 - $25.',
                requirementsInfo: 'High school certificate with minimum C+ grade.',
                imageUrl: 'https://images.unsplash.com/photo-1541339907198-e021fc2d2e7c?q=80&w=1000' // Beautiful university building
            },
            {
                name: 'Jamhuriya University',
                location: 'Mogadishu, Somalia',
                tuitionRange: '$600 - $1500',
                faculties: ['Medicine', 'Engineering', 'Computer Science', 'Nursing', 'Public Health'],
                contactInfo: 'info@just.edu.so',
                admissionInfo: 'Qualifying exams for Medical and Engineering faculties.',
                feesInfo: 'Payment in installments. Scholarships available for top students.',
                requirementsInfo: 'Completed secondary education with validated certificate.',
                imageUrl: 'https://images.unsplash.com/photo-1592280771190-3e2e4d571952?q=80&w=1000' // Building style
            },
            {
                name: 'Mogadishu University',
                location: 'Hodan, Mogadishu',
                tuitionRange: '$400 - $1000',
                faculties: ['Law', 'Arts', 'Political Science', 'Sharia', 'Education', 'Health Sciences'],
                contactInfo: 'info@mu.edu.so',
                admissionInfo: 'Open during academic season.',
                feesInfo: 'Competitive rates with financial aid options.',
                requirementsInfo: 'High school transcript and national exam results.',
                imageUrl: 'https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=1000' // Campus building
            },
            {
                name: 'Banadir University',
                location: 'Mogadishu, Somalia',
                tuitionRange: '$700 - $1400',
                faculties: ['Medicine', 'Health Science', 'Education', 'Social Works'],
                contactInfo: 'info@banadir.edu.so',
                admissionInfo: 'Special focus on health sciences.',
                feesInfo: 'Tuition varies by clinical stages.',
                requirementsInfo: 'Minimum B average for Medicine.',
                imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=1000' // School/Colleage style
            },
            {
                name: 'Somali University',
                location: 'Mogadishu, Somalia',
                tuitionRange: '$450 - $900',
                faculties: ['Agriculture', 'Veterinary', 'Humanities', 'Education'],
                contactInfo: 'info@su.edu.so',
                admissionInfo: 'Direct admission based on high school grades.',
                feesInfo: 'One of the most affordable public-private mix options.',
                requirementsInfo: 'High school diploma.',
                imageUrl: 'https://images.unsplash.com/photo-1523050853051-f405a90d50bc?q=80&w=1000'
            },
            {
                name: 'Jazeera University',
                location: 'Mogadishu, Somalia',
                tuitionRange: '$550 - $1100',
                faculties: ['Public Health', 'Radiology', 'Nursing', 'Medicine'],
                contactInfo: 'admin@jazeera.edu.so',
                admissionInfo: 'Entrance test and interview.',
                feesInfo: 'Monthly payment plans.',
                requirementsInfo: 'Certificate of secondary education.',
                imageUrl: 'https://images.unsplash.com/photo-1523580494863-6f3031224c94?q=80&w=1000'
            },
            {
                name: 'SIU (Somali International University)',
                location: 'Mogadishu, Somalia',
                tuitionRange: '$800 - $1800',
                faculties: ['Strategic Management', 'Global Studies', 'ICT', 'Business'],
                contactInfo: 'info@siu.edu.so',
                admissionInfo: 'Focus on international students and expats.',
                feesInfo: 'International standard pricing.',
                requirementsInfo: 'English proficiency test may be required.',
                imageUrl: 'https://images.unsplash.com/photo-1607237138185-efd9571f1680?q=80&w=1000'
            }
        ]);

        console.log('Universities Imported!');

        // Create Programs Mockup
        await Program.create([
            {
                universityId: universities[0]._id,
                name: 'BSc Computer Science',
                duration: '4 Years',
                requirements: 'Grade B+ in Math'
            },
            {
                universityId: universities[1]._id,
                name: 'Civil Engineering',
                duration: '5 Years',
                requirements: 'Grade A in Physics'
            }
        ]);

        console.log('Programs Imported!');

        console.log('Data Imported Successfully!');
        process.exit();
    } catch (error) {
        console.error(`Error: ${error}`);
        process.exit(1);
    }
};

importData();

