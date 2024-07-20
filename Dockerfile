FROM node:21-alpine

WORKDIR /usr/src/app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup && chown -R appuser:appgroup /usr/src/app

COPY package*.json ./

RUN npm install

USER appuser

COPY src/app.js ./src/app.js

EXPOSE 3000

CMD [ "npm", "start" ]