FROM node:14

WORKDIR /usr/src/app

COPY package*.json ./
COPY copy-assets.js ./

RUN npm install --production=false

COPY tsconfig.json ./
COPY src ./src

RUN npm run build

COPY src/public ./src/public

ENV PORT 3000

EXPOSE 3000

CMD [ "npm", "start" ]
