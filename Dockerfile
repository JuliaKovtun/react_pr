# Use an official Node.js image as a build stage
FROM node:14 AS builder

# Set the working directory
WORKDIR /react_pr

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Use a smaller base image for the final production image
FROM nginx:latest

# Copy the build artifacts from the builder stage to the nginx web root
COPY --from=builder /react_pr/build /usr/share/nginx/html

# Expose port 80 for the running application
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
