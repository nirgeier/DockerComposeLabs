# Our server is based upon nodejs
FROM node

# Pass the port to the server (if we are not building with compose)
# ENV port 3000
# ENV port 5000

# Copy the local server code to our container
# Important !!! dont forget the [.] which means the local folder
COPY server.js .
COPY package.json .

# Install the npms
RUN npm i 

# Start the server once the ocntainer is running
CMD node ./server.js