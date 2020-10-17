FROM node:slim as builder
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:1.19
COPY --from=builder /usr/src/app/build/ /usr/share/nginx/html