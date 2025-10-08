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

# Copy built frontend from previous stage
COPY --from=frontend-builder /app/dist ./dist

# Create a production server that serves both API and static files
RUN cat > start-server.js << 'EOF'
const express = require('express');
const path = require('path');
const cors = require('cors');

// Set up express app
const app = express();
app.use(cors());
app.use(express.json());

// Import API routes from your server file
require('./server/index.js');

// Serve static files from Vite build
app.use(express.static(path.join(__dirname, 'dist')));

// Serve index.html for all non-API routes (client-side routing)
app.get('*', (req, res) => {
  if (!req.path.startsWith('/api')) {
    res.sendFile(path.join(__dirname, 'dist', 'index.html'));
  }
});

// Start server on PORT env variable
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`SkillGraph server running on port ${PORT}`);
});
EOF

# Expose port
EXPOSE 3001

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]

# Run the backend server directly (it already serves the frontend in production)
CMD ["node", "server/index.js"]