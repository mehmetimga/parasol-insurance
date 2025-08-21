# Multi-stage build for the application
FROM node:18-alpine AS frontend-build

# Build the frontend
WORKDIR /app/webui
COPY app/webui/package*.json ./
RUN npm ci --only=production

COPY app/webui/ ./
RUN npm run build

# Main application stage
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY app/package*.json ./
RUN npm ci --only=production

# Copy application code
COPY app/ ./

# Copy built frontend from previous stage
COPY --from=frontend-build /app/webui/dist ./webui/dist

# Create app user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S parasol -u 1001

# Change ownership of the app directory
RUN chown -R parasol:nodejs /app
USER parasol

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Start the application
CMD ["node", "server.mjs"]