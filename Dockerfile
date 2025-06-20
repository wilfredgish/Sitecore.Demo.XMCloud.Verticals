FROM node:20-alpine
WORKDIR /

COPY package.json package-lock.json ./

RUN npm i

COPY . . 

RUN chown -R 755 /.next 

EXPOSE 3000

CMD ["npm","run","start:production"]
