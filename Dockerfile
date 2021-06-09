FROM node:alpine as builder

WORKDIR /app

COPY package.json .
COPY yarn.lock .
RUN apk install automake 
RUN yarn install
COPY . .
RUN ["yarn", "run", "build" ]
RUN ["yarn", "run", "serve" ]

