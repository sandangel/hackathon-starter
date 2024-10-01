# Backend
FROM node:20-slim as backend

WORKDIR /starter

COPY package*.json ./

RUN npm install pm2 -g && npm install --omit=dev

COPY . .

ENV NODE_ENV=production

EXPOSE 8080

CMD ["pm2-runtime","app.js"]

# Frontend
# Right now it's the same with the backend API
# TODO: split server side rendering into separate service
FROM node:20-slim as frontend

WORKDIR /starter

COPY package*.json ./

RUN npm install pm2 -g && npm install --omit=dev

COPY . .

ENV NODE_ENV=production

EXPOSE 8080

CMD ["pm2-runtime","app.js"]
