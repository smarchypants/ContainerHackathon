#/bin/bash

# Docker Hackathon demo script
#
#  1) Grab from my public git-hub
#  git clone https://github.com/smarchypants/ContainerHackathon.git
#
#  Meant to be used for a play around and not for production ;)

# Demo 1 - Working with the docker daemon / console
# 
#

# Run the most basic linux container (daemon)
docker run --name alpine -d alpine
docker run --name centos -d centos
docker run --name rabbitmq -d rabbitmq

# Run a ubuntu container in interactive mode
docker run --name ubuntu -it ubuntu

    #  Manually run the following commands in interactive mode for fun (show need for DockerFile)
    # 
    #  apt-get update && apt-get -y upgrade
    #  apt-get install -y apache2
    #  apachectl start
    #
    #   Exec Control P, Control Q to exit interactive mode (does not work from VS Code interactive shell)

# Show docker container is running
docker ps

# Look at the runtime configuration of the container
docker inspect ubuntu

# Retrieve the internal IP address of a docker container
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubuntu

# Run the following to return to interactive mode
docker exec -it ubuntu /bin/bash
 #   Exec Control P, Control Q to exit interactive mode (does not work from VS Code interactive shell)

# Stop the container
docker stop ubuntu 

# Now let's play around with a basic Apache web server, and create an elite HTML pate
docker run --name centos-httpd -p 8080:80 -d centos/httpd 
docker exec -it centos-httpd /bin/bash
#   echo "<html><title>My test page</title><body><p>I am elite</p></body></html>" > /var/www/html/index.html
 #  Exec Control P, Control Q to exit interactive mode (does not work from VS Code interactive shell)

# Take a file, gzip & compress it using the smallest linux image (Alpine) possible. Cross platform! yay
#   Assumption: run from the same folder that contains ContactLenses.pdf file 

docker run -v $(pwd):/home/test -w /home/test  alpine tar czvf test.tar.gz ContactLenses.pdf

# Remove the container  (skip over, to show removing of *ALL* containers - useful for dev, not so great for prod)
#  docker rm -f alpine

# List all containers (running or not)
docker ps -a

# Remove all docker containers (forced, running or not, they will die!)
docker rm -f $(docker ps -a -q)

# List all of the docker images on the system (review sizes, etc)
docker image ls

# Remove all docker images (forced)
# docker rmi -f $(docker image ls -q)

# Demo 2 - building docker image files
# 
#

# Login to the docker hub
docker login

# Login to my Azure Container registry (Don't hack me please)
docker login enerdscr.azurecr.io

    # Username: enerdscr
    # Password:  TVB+LEY9W8RmwkuilajlGh=1gmp+WYzo

# cd /Users/smarch/Documents/GitHub/Docker/NodeJs

# Build and tag an image based on a docker file in the local directory (note the Azure container repo)
docker build -t enerdscr.azurecr.io/node-demo .  # Create image using this directory's Dockerfile

# Push the build image to my Azure container registry
docker push enerdscr.azurecr.io/node-demo

# Pull the same image (not really useful it's already local - more for folks in the class to try)
docker pull enerdscr.azurecr.io/node-demo

# Run a new sample container based on my killer docker image from Azure 
docker run --name nodeTest -p 3000:3000 enerdscr.azurecr.io/node-demo

# What happens if we remove the image and re-run?
docker rmi -f $(docker image ls enerdscr.azurecr.io/node-demo -q)

# Rerun a new sample container based on my killer docker image from Azure 
docker run --name nodeTest -p 3000:3000 enerdscr.azurecr.io/node-demo

# Look at all of the images on your system
docker image ls

# Remove all docker images (forced)
docker rmi -f $(docker image ls -q)

# Look at all of the volumes hanging around on your computer
docker volume ls
# Remove all docker volumes (forced)
docker volume rm -f $(docker volume ls -q)

# Commands to manually create a docker network and link containers (if not using docker-compose)
docker network create --driver bride cdxp_dev_network
docker run -d --net=cdxp_dev_network --name mongodb mongo
docker run -d --net=cdxp_dev_network --name nodeapp -p 3000:3000 node