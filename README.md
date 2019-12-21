![](resources/logos.png)

---

# Docker-Compose Lab

- In this lab we will create and deploy our container with docker compose
- We will build and deploy 2 separate apps (nodejs servers) using a single compose file

---
## Table Of Context:

  :one: [Preparations](#preparations)
  
  :two: [Creating Dockerfile](#creating-dockerfile)
  
  :three: [Creating the compose file](#creating-the-compose-file)
  
  :four: [Build and run the compose](#build-and-run-the-compose)

---

## Preparations
- First review the server code located at the folders named server
- Both of the servers should be the same code with a single difference -   
    - The port which the server listen on.

``` js
// The server code - same beside port and output string
const
    // Set the server port which wiill be listenig to
    // Those 2 values are passed from the compose file
    SERVER_PORT = process.env.port,
    SERVER_NAME = process.env.name,

    // Other required libraries
    os = require('os'),
    fs = require('fs-extra'),
    FILE_NAME = `/shared_volume/shared.log`;

// Create the basic http server
require('http')
    .createServer((request, response) => {

        // Write to the shared folder
        fs.ensureFile(FILE_NAME);
        fs.appendFile(FILE_NAME, `Hello from ${SERVER_NAME}. ${request.url}${os.EOL}`);

        // Send reply to user
        response.end(`<h1>Hello from server1.</h1>`);

    }).listen(SERVER_PORT, () => {
        // Notify users that the server is up and running
        console.log(`Server is up. 
            Please click or point your browser to:
            http://localhost:${SERVER_PORT}`);
    });
```
- Next to the server there is the package.json file which is required for building the app

## Creating Dockerfile
- The next step is pack the app as Docker container.
- To do so we need a Dockerfile.
- Here is the Dockerfile for server1 (same)
```yaml
# Our server is based upon nodejs
FROM node

# Copy the local server code to our container
# Important !!! dont forget the [.] which means the local folder
COPY server.js .
COPY package.json .

# Install the npms
RUN npm i 

# Start the server once the ocntainer is running
CMD node ./server1.js
```

## Creating the compose file
```yaml
# We are using version 2
version: "2"

# Define the deployed services
services:

    # Server1
    server1:
        build: server

        # Server 1 will listen on port 3000
        ports:
        - "3000:3000"
    
    # The shared volume for both servers
    volumes:
    - "./shared_volume:/shared_volume"
    restart: always
    
    ###
    ### Here we pass the environment (runtime) values
    ###  
    environment:
      port: 3000
      name: 'Server1'
  
  # Same comments as for server1 but with port 5000
  server2:
    build: server
    ports:
    - "5000:5000"
    volumes:
    - "./shared_volume:/shared_volume"
    environment:
      port: 5000
      name: 'Server2'
  
```

## Build and run the compose

- Build the composed servers
    ```sh
    $ docker-compose build
    Building server1
    Step 1/5 : FROM node
    ---> 760e12e87878
    Step 2/5 : COPY server.js .
    ---> Using cache
    ---> d39e9dd85c99
    Step 3/5 : COPY package.json .
    ---> Using cache
    ---> 68f538521089
    Step 4/5 : RUN npm i
    ---> Using cache
    ---> 2b8f7da6a48b
    Step 5/5 : CMD node ./server.js
    ---> Using cache
    ---> c145d38b5c17
    Successfully built c145d38b5c17
    Successfully tagged docker-compose_server1:latest
    Building server2
    Step 1/5 : FROM node
    ---> 760e12e87878
    Step 2/5 : COPY server.js .
    ---> Using cache
    ---> d39e9dd85c99
    Step 3/5 : COPY package.json .
    ---> Using cache
    ---> 68f538521089
    Step 4/5 : RUN npm i
    ---> Using cache
    ---> 2b8f7da6a48b
    Step 5/5 : CMD node ./server.js
    ---> Using cache
    ---> c145d38b5c17
    Successfully built c145d38b5c17
    Successfully tagged docker-compose_server2:latest
    ```

- Run the compose and open your browser to see the messages
    ```sh
    $ docker-compose up
    Starting docker-compose_server2_1 ... done
    Starting docker-compose_server1_1 ... done
    Attaching to docker-compose_server2_1, docker-compose_server1_1
    server2_1  | Server2 is up.
    server2_1  |             Please click or point your browser to:
    server2_1  |             http://localhost:5000
    server1_1  | Server1 is up.
    server1_1  |             Please click or point your browser to:
    server1_1  |             http://localhost:3000
    ```