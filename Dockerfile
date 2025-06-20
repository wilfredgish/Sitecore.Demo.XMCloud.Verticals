FROM node:20-alpine
WORKDIR /app

COPY package.json package-lock.json ./

RUN npm i

COPY . .

RUN mkdir -p .next/cache/eslint && chmod -R 755 .next/cache

EXPOSE 3000

CMD ["npm","run","start:production"]
