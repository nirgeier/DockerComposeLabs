const winston = require("winston");
const { createLogger, transports } = require("winston");
const LokiTransport = require("winston-loki");

const logger = createLogger({
  transports: [
    new LokiTransport({
      host: "http://loki:3100", // Use service name in Docker, or "localhost" if outside
      labels: { app: "nodejs-app" }, // Add custom labels
      json: true,
      format: winston.format.json(),
      replaceTimestamp: true,
      onConnectionError: (err) => console.error(err),
    }),
    // Optional: Also log to console
    new transports.Console({
      format: winston.format.simple(),
    }),
  ],
});

module.exports = logger;