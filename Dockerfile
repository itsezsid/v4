FROM node:alpine 

WORKDIR /app

COPY package.json .
COPY yarn.lock .
RUN apk add --update --no-cache build-base autoconf automake libtool pkgconf nasm 
RUN yarn install
RUN apk del build-base autoconf automake libtool pkgconf nasm
COPY . .
RUN ["yarn", "run", "build" ]
CMD ["yarn", "run", "serve" ]
