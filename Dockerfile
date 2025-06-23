FROM node:22-alpine

WORKDIR /app

# Clean previous node_modules if any
RUN rm -rf node_modules

# Copy dependency files and install
COPY package*.json ./

RUN npm cache clean --force

RUN npm install

RUN addgroup --system --gid 1001 nodejs

RUN adduser --system --uid 1001 nextjs

RUN mkdir -p /app/scripts/temp && \

chown -R nextjs:nodejs /app

COPY . . 

RUN mkdir -p /app/scripts/temp chmod -R nextjs:nodejs /app/scripts/temp


RUN  ls -la

EXPOSE 3000

CMD ["npm", "run", "start:production"]
