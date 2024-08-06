# Copy the rest of the application code
COPY . .

# Build the React application
RUN npm run build
RUN npm install --force

# Stage 2: Serve the React application using a lightweight web server
FROM nginx:alpine

# Copy the build artifacts from the build stage
#COPY --from=build /app/build /usr/share/nginx/index.html

# Expose port 80 to access the application
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]


