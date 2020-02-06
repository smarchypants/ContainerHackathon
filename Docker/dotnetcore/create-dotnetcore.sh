#/bin/bash

# Requires .NET Core installed, creates a sample MVC app in the current directory
dotnet new mvc

# Pull docker image
#docker pull microsoft/aspnetcore-build
docker pull mcr.microsoft.com/dotnet/core/aspnet
docker pull mcr.microsoft.com/dotnet/core/sdk:3.0


# Create a container and put in interactive mode - mapped to current directory where mvc app is
#docker run -it -p 8080:80 -v $(pwd):/app -w "/app" microsoft/aspnetcore-build /bin/bash
docker run -it -p 8080:80 -v $(pwd)/app:/app -w "/app" mcr.microsoft.com/dotnet/core/sdk:3.0 /bin/bash
