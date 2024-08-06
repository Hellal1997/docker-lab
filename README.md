# docker-lab
1- Problem 1:
* Run a container nginx with name my-nginx and attach a and attach a volume 2 volumes to the container
* Volume for containing static html file
* Volume2 for containing nginx configuration
* Run a container nginx with name my-nginx and attach a and attach a volume 2 volumes to the container
* Volume for containing static html file
* Volume2 for containing nginx configuration
Run a new 2 containers with the following:
* Attach the 2 volumes that was attached to the previous container in two different ways (volume mount - bind mount)
: Acess the to fis to your out machine
---------------------------------------------------------------------------
Problem 2:
* Create a dockerfile for nginx image with different html content and different nginx conf that listen to port 8080 instead of port 80 on the container
* Create container from the new \image
mkdir -p ~/nginx_custom
cd ~/nginx_custom
mkdir -p html
echo "<html><body><h1>Hello from custom Nginx on port 8080!</h1></body></html>" > html/index.html
Create Nginx Configuration

//Create an Nginx configuration file that listens on port 8080:
mkdir -p nginx_conf
cat <<EOF > nginx_conf/default.conf
server {
    listen 8080;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
EOF
4. Create the Dockerfile

Create a Dockerfile that sets up the custom Nginx image
cat <<EOF > Dockerfile
FROM nginx:latest
COPY html /usr/share/nginx/html
COPY nginx_conf/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
EOF
Build the Docker Image

Build the Docker image with a custom name (e.g., nginx_custom):
docker build -t nginx_custom .

docker run -d -p 8080:8080 --name my_custom_nginx nginx_custom
--------------------------------------------------------------------------
Problem 3:
: Create a deckerile po containerize the reactapp
* Build the image and test it
* (Bonus) create a dockerfile for the same app in smaller size using multi staging

Build Stage: Uses the Node.js image to build the React app.
Runtime Stage: Uses the Nginx image to serve the built React app.

Basic Dockerfile :
# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React application
RUN npm run build

# Install a simple web server to serve the static files
RUN npm install -g serve

# Expose port 5000
EXPOSE 5000

# Serve the React application
CMD ["serve", "-s", "build", "-l", "5000"]

docker build -t my-react-app .
docker run -p 5000:5000 my-react-app

Multi-Stage Dockerfile (Optimized for Smaller Size)
# Stage 1: Build the React application
FROM node:18 AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React application
RUN npm run build

# Stage 2: Serve the React application using a lightweight web server
FROM nginx:alpine

# Copy the build artifacts from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to access the application
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

docker build -t my-react-app:multi-stage .

docker run -p 80:80 my-react-app:multi-stage

