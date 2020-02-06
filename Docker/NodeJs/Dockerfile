FROM node:latest

MAINTAINER Stephen March

ENV NODE_ENV=production
ENV PORT=3000

COPY    ./ExpressSite   /var/www
WORKDIR /var/www

RUN npm install

EXPOSE $PORT

ENTRYPOINT  ["npm", "start"]

