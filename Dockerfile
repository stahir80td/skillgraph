# Multi-stage build for SkillGraph application

# Stage 1: Build frontend
FROM node:18-alpine AS frontend-builder

WORKDIR /app

# Copy package files from root
COPY package.json package-lock.json ./

# Install all dependencies (including dev dependencies for build)
RUN npm ci

# Copy frontend source files
COPY src ./src
COPY index.html ./
COPY vite.config.js ./

# Build frontend for production
RUN npm run build

# Stage 2: Production image
FROM node:18-alpine

WORKDIR /app

# Install dumb-init for proper signal handling
RUN apk add --no-cache dumb-init

# Copy package files
COPY package.json package-lock.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy backend server file
COPY server/index.js ./server/index.js

# Copy built frontend from previous stage to public folder
COPY --from=frontend-builder /app/dist ./public

# Modify the server/index.js to serve static files in production
# We'll do this by setting an environment variable that the server can check
ENV NODE_ENV=production
ENV STATIC_PATH=/app/public

# Expose port
EXPOSE 3001

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]

# Run the backend server
CMD ["node", "server/index.js"]