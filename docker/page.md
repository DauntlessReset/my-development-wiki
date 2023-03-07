# Docker

This page will contain Docker documentation.

## Docker 101 Tutorial 

### Running a Container

```docker run -d -p 80:80 docker/<given-image>```

```-d``` - run the container in detached mode (in the background)

```-p 80:80``` - map port 80 of the host to port 80 of the container

```docker/<given-image>``` - the image to use

Tip: You can combine single character flags, e.g. ```-dp``` in lieu of ```-d -p```

### Building a Container Image 

1. Create a file named ```Dockerfile``` in the same folder as ```package.json```:

```FROM node:18-alpine
WORKDIR /app
COPY . . 
RUN yarn install --production
CMD ["node", "src/index.js"]```

2. Open the terminal and navigate to the directory with the ```Dockerfile```:

```docker build -t getting started .```

The ```-t-``` flag tags the image. It is just a human-readable name for the generated image. 

The ```.``` at the end of the command tells Docker to look for the ```Dockerfile``` in the current directory. 

### Starting an App Container

1. Start your container using the ```docker run``` command and specify the name of the image we created:

```docker run -dp 3000:3000 getting-started```