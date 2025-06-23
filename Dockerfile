FROM node:22-alpine

WORKDIR /

# Clean previous node_modules if any
RUN rm -rf node_modules

# Copy dependency files and install
COPY package*.json ./

RUN npm cache clean --force

RUN npm install

RUN addgroup --system --gid 1001 nodejs

RUN adduser --system --uid 1001 nextjs

COPY . . --chown=nextjs:nodejs

EXPOSE 3000

CMD ["npm", "run", "start:production"]
