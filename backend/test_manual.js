const express = require('express');
const app = require('./app');
const mongoose = require('mongoose');
const env = require('./config/env');
const http = require('http');

const runTest = async () => {
    try {
        console.log('Connecting to MongoDB...');
        await mongoose.connect(env.MONGODB_URI);
        console.log('Connected to MongoDB');

        const server = app.listen(5001, async () => {
            console.log('Test Server running on 5001');

            const data = JSON.stringify({
                email: 'admin@example.com',
                password: 'password123'
            });

            const options = {
                hostname: 'localhost',
                port: 5001,
                path: '/api/auth/login',
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Content-Length': data.length
                }
            };

            console.log('Sending Login Request...');
            const req = http.request(options, res => {
                console.log(`StatusCode: ${res.statusCode}`);
                let body = '';
                res.on('data', d => body += d);
                res.on('end', () => {
                    console.log('Response:', body);
                    server.close();
                    mongoose.disconnect();
                    process.exit(0);
                });
            });

            req.on('error', error => {
                console.error('Request Error:', error);
                process.exit(1);
            });

            req.write(data);
            req.end();
        });
    } catch (err) {
        console.error('Setup Error:', err);
        process.exit(1);
    }
};

runTest();
