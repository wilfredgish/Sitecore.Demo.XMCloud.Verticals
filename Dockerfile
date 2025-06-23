FROM node:20-alpine

WORKDIR /

COPY package.json package-lock.json ./

RUN npm install

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY . . --chown=nextjs:nodejs

EXPOSE 3000

CMD ["npm", "run", "start:production"]
