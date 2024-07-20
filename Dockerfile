# syntax=docker/dockerfile:1
ARG NODE_VERSION=21

FROM node:${NODE_VERSION}-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

USER node

COPY src/app.js ./src/app.js

EXPOSE 3000

CMD [ "npm", "start" ]