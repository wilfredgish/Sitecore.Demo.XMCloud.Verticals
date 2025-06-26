# Use an official Node.js runtime as a parent image
FROM node:22

# Set the working directory in the container
WORKDIR /app

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

ENV NODE_EXTRA_CA_CERTS=bcbstrootca.pem

ENV NODE_TLS_REJECT_UNAUTHORIZED=0

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
