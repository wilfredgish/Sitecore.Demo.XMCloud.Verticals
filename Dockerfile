# Use an official Node.js runtime as a parent image
FROM node:22-alpine

# Set the working directory in the container
WORKDIR /app

# Clean previous node_modules if any
RUN rm -rf node_modules

# Copy dependency files and install
COPY package*.json ./

RUN npm cache clean --force

RUN npm install

# Copy the rest of your application code
COPY . .

# Add nodejs group and nextjs user
RUN addgroup --system --gid 1001 nodejs \
    && adduser --system --uid 1001 --ingroup nodejs nextjs

# Ensure the /app directory and its subdirectories have the correct permissions
RUN mkdir -p /app/scripts/temp  \
    && chown -R nextjs:nodejs /app \
    && chmod -R 755 /app/scripts/temp /app/.next/cache

    # Switch to the nextjs user
USER nextjs

RUN mkdir -p .next/cache \    
 && chown -R 1001:0 .next\
 && chmod -R 775 .next

USER 1001
# List files and directories for debugging
RUN ls -la

# Expose the application port
EXPOSE 3000



# Run the application
CMD ["npm", "run", "start:production"]
