# Use the official Node.js image from the Docker Hub
FROM node:14

# Create and change to the app directory
WORKDIR /usr/src/app

# Copy the application code to the container
COPY . .

# Install dependencies
RUN npm install

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["node", "app.js"]

