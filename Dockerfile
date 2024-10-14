# Use the latest long-term support version of Node.js with Alpine Linux for a lightweight image
FROM node:lts-alpine AS build
# Set the environment variable for production
ENV NODE_ENV=production
# Create and set working directory
WORKDIR /usr/src/app
# Install dependencies only when needed (for caching optimization)
COPY package*.json ./
RUN npm install --production --silent
# Copy application code
COPY . .
# Expose the application port
EXPOSE 3000
# Use a non-root user to run the application
USER node
# Start the Node.js application
CMD ["node", "app.js"]
# Multi-stage build to reduce image size
FROM node:lts-alpine AS production
COPY --from=build /usr/src/app /usr/src/app
# Set the working directory and expose the port
WORKDIR /usr/src/app
EXPOSE 3000
USER node
CMD ["node", "app.js"]