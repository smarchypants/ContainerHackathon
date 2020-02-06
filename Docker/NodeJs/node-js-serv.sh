#/bin/bash

# Create a node JS app, based on a volume where this script was run from
#

git clone https://github.com/smarchypants/ContainerHackathon.git

docker run -p 8080:3000 -v $(pwd)/ExpressSite:/var/www -w "/var/www" node npm start
