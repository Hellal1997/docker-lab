# Use the official Node.js image as the base image
FROM node:14 as build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application files to the working directory
COPY . .

# Build the React application
RUN npm run build

# Use the official Nginx image to serve the built application
FROM nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Command to run the Nginx server
CMD ["nginx", "-g", "daemon off;"]
