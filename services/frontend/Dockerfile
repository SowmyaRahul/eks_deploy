# Use the official Node.js image from the Docker Hub
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json (or yarn.lock) files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code into the container
COPY . .

# Expose the port that the React development server runs on
EXPOSE 3000

# Define the command to start the React development server
CMD ["npm", "start"]
