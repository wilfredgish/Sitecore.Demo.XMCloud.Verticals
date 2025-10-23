# Use an official Node.js runtime as a parent image
FROM nexus.bcbst.com:8096/node:20

# Set the working directory in the container
WORKDIR /app

# Install Chromium and required system libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates wget gnupg \
    fonts-liberation \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libxcomposite1 libxdamage1 \
    libxrandr2 libgbm1 libasound2 libxss1 libx11-6 libx11-xcb1 libxshmfence1 \
    libpangocairo-1.0-0 libgtk-3-0 \
    chromium \
  && rm -rf /var/lib/apt/lists/*

# Clean previous node_modules if any
RUN rm -rf node_modules

# Copy dependency files and install
COPY package*.json ./

RUN npm cache clean --force

RUN npm set strict-ssl false

RUN npm set proxy http://webproxy.bcbst.com:80


RUN npm install



ENV http_proxy=http://webproxy.bcbst.com:80

ENV https_proxy=https://webproxy.bcbst.com:443
# Copy the rest of your application code
COPY . .

ENV NODE_EXTRA_CA_CERTS=/etc/ssl/pki/bcbst_rootca.crt


# Add nodejs group and nextjs user
RUN addgroup --system --gid 1001 nodejs \
    && adduser --system --uid 1001 --ingroup nodejs nextjs

# # Ensure the /app directory and its subdirectories have the correct permissions
# RUN mkdir -p scripts/temp  \
#     && chown -R nextjs:nodejs / \
#     && chmod -R 755 scripts/temp .next/cache

    # Switch to the nextjs user
# USER nextjs



RUN mkdir -p scripts/temp \    
 && chown -R 1001:0 scripts/temp  \ 
 && chmod -R 775 scripts

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
