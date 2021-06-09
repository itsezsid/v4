FROM node:alpine 

WORKDIR /app

COPY package.json .
COPY yarn.lock .
RUN apk add --update autoconf 
RUN apk add --update automake 
RUN yarn install
COPY . .
RUN ["yarn", "run", "build" ]
RUN ["yarn", "run", "serve" ]
EXPOSE 9000
