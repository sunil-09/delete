# Use the latest long-term support version of Node.js with Alpine Linux for a lightweight image
FROM node:lts-alpine
# Set the environment variable to production
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
# Install production dependencies quietly (suppress output) and move node_modules up one level
RUN npm install --production --silent && mv node_modules ../
COPY . .
EXPOSE 3000
# Change ownership of the application directory to the non-root user 'node'
RUN chown -R node /usr/src/app
USER node
CMD ["node", "app.js"]
