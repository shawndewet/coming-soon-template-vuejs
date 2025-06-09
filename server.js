const express = require('express');
const path = require('path');

const app = express();
const port = process.env.PORT || 3000;

// Healthcheck endpoint
app.get('/up', (req, res) => {
  res.json({ message: 'Healthy' });
});

// Serve static files from the dist directory
app.use(express.static(path.join(__dirname, 'dist')));

// Fallback to index.html for SPA
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
