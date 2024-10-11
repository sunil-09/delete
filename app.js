// app.js
const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const authController = require('./controllers/authController');

const app = express();
const port = 3000;

// Middleware to parse incoming requests
app.use(bodyParser.urlencoded({ extended: true }));

// Set EJS as the templating engine (for rendering HTML with dynamic content)
app.set('view engine', 'ejs');

// Serve static HTML files for registration and login
app.use(express.static(path.join(__dirname, 'views')));

// Routes for handling authentication
app.get('/register', (req, res) => {
  res.sendFile(path.join(__dirname, 'views', 'register.html'));
});

app.post('/register', authController.register);

app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'views', 'login.html'));
});

app.post('/login', authController.login);

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
