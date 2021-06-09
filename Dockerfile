# --------------> The build image
FROM node:alpine  AS build
WORKDIR /usr/src/app
COPY package*.json /usr/src/app/
RUN apk add --update --no-cache build-base autoconf automake libtool pkgconf nasm 
RUN npm ci --only=production
RUN apk del build-base autoconf automake libtool pkgconf nasm
# --------------> The production image
FROM node:alpine 
WORKDIR /usr/src/app
ENV NODE_ENV production
USER node
COPY --chown=node:node --from=build /usr/src/app/node_modules /usr/src/app/node_modules
COPY --chown=node:node . /usr/src/app
CMD ["npm", "run" ,"deploy"]
EXPOSE 9000
