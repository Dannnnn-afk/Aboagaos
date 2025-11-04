const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Database connection
const db = require('./config/database');

// Test database connection
db.authenticate()
  .then(() => console.log('Database connected successfully'))
  .catch(err => console.log('Error: ' + err));

// Routes
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to Aboagaos API' });
});

// Import routes
const userRoutes = require('./routes/users');
app.use('/api/users', userRoutes);

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

module.exports = app;
