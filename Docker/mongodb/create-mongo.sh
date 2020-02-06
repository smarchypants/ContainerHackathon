#/bin/bash

# TCP port: 27017 by default

docker run -p 27017:27017 --name some-mongo -d mongo:latest

