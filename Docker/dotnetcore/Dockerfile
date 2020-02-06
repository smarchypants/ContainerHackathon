FROM node:latest

ENV NODE_ENV=production
ENV PORT=5000

COPY . /var/www
WORKDIR /var/www

VOLUME ["/var/www]"]

RUN npm install

EXPOSE  $PORT

ENTRYPOINT ["npm", "start"]