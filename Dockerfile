# Use official Node.js image as the build environment
FROM node:20-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Vue app for production
RUN npm run build

# Production image
FROM node:20-alpine AS prod
WORKDIR /app

# Copy built files from build stage
COPY --from=build /app/dist ./dist
COPY --from=build /app/server.js ./server.js
COPY --from=build /app/package*.json ./

# Install production dependencies
RUN npm install --omit=dev

# Expose port 3000
EXPOSE 3000

# Start the Node.js server
CMD ["node", "server.js"]
