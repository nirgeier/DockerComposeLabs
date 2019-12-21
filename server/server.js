const
    // Set the server port which wiill be listenig to
    // Those 2 values are passed from the compose file
    SERVER_PORT = process.env.port,
    SERVER_NAME = process.env.name,

    // Other required libraries
    os = require('os'),
    fs = require('fs-extra'),
    FILE_NAME = `/shared_volume/shared.log`;

// Write to the shared folder
fs.ensureFile(FILE_NAME);

// Create the basic http server
require('http')
    .createServer((request, response) => {

        // Write the message to the shared file
        fs.appendFile(FILE_NAME, `Hello from ${SERVER_NAME}. ${request.url}${os.EOL}`);

        // Send reply to user
        response.end(`<h1>Hello from ${SERVER_NAME}.</h1>`);

    }).listen(SERVER_PORT, () => {
        // Notify users that the server is up and running
        console.log(`${SERVER_NAME} is up. 
            Please click or point your browser to:
            http://localhost:${SERVER_PORT}`);
    });