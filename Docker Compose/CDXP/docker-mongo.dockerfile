FROM mongo

ENV PORT=27017

EXPOSE $PORT

ENTRYPOINT [ "mongod", "-d" ]