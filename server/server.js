// Import required modules
const client = require('prom-client');
const express = require('express');
const fs = require('fs');
const path = require('path');
const axios = require('axios');

// Log to loki
const logger = require("./logger");

// Set the listening port from environment variable or default to 8090
const PORT = process.env.PORT || 8090;

// Create Prometheus metrics
const pingCounter = new client.Counter({
   name: 'ping_request_count',
   help: 'No of request handled by Ping handler',
});

const requestsCounter = new client.Counter({
   name: 'overall_request_count',
   help: 'No of request handled by the server',
});

const errorCounter = new client.Counter({
   name: "error_request_count",
   help: "No of request errors handled by the server",
   labelNames: ["http_status_code"],
});

// Create Express app
const app = express();

// Middleware to increment counter on every request
app.use((req, res, next) => {
   // Log to loki
   logger.debug("Server hit. ");

   // Setup prometheus metrics
   requestsCounter.inc();
   next();
});

// Route to handle ping requests
app.get('/health', (req, res) => {
   res.type("text/plain").send("healthy").status(200);
});

// Route to handle ping requests
app.get('/ping', (req, res) => {
   // Prometheus metrics
   pingCounter.inc();

   // Log to loki
   logger.info("Ping endpoint hit. ");

   res.type("text/plain").send("pong");
});

// Route to handle metrics requests
app.get('/metrics', async (req, res) => {
   try {
      res.set('Content-Type', client.register.contentType);
      res.end(await client.register.metrics());
      // Log to loki
      logger.info("metrics endpoint hit. ");
   } catch (err) {
      // Increase prometheus error counter
      errorCounter.inc({ http_status_code: "500" });

      // Log error to Loki
      logger.error("Failed record", { error: `Error fetching metrics: ${err.message}` });

      res.status(500).send("Error fetching metrics");
   }
});

// Route to handle 404 errors
app.use((req, res) => {
   errorCounter.inc({ http_status_code: '404' });
   const filePath = path.join(__dirname, '404.html');
   fs.readFile(filePath, 'utf8', (err, data) => {
      if (err) {
         res.status(404).type('text/plain').send('Not found');
      } else {
         res.status(404).type('text/html').send(data);
      }
   });
});

// Start the server
app.listen(PORT, () => {
   console.log(`Server running at http://localhost:${PORT}/`);
});

