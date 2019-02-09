FROM node:10-alpine

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

COPY ./ ./
CMD node src/index.js
