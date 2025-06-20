FROM nexus.bcbst.com:8096/node:20

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm i

COPY . .

EXPOSE 3000

CMD ["npm","run","start:production"]
