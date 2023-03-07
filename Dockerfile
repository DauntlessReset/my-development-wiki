FROM node:latest
LABEL description="A Dockerfile to build Docsify"
WORKDIR /docs 
RUN npm install -g docsify-cli@latest
EXPOSE 3000/tcp
ENTRYPOINT docsify serve
