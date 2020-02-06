FROM node:latest

ENV NODE_ENV=production
ENV PORT=3000

COPY    ./Node/ExpressSite   /var/www
WORKDIR /var/www

RUN npm install

EXPOSE $PORT

ENTRYPOINT  ["npm", "start"]

