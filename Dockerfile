FROM node:14-slim as builder

WORKDIR /app

COPY package.json .
COPY yarn.lock .
RUN yarn install
COPY . .
RUN ["yarn", "run", "build" ]

FROM nginx:alpine
EXPOSE 80
COPY --from=builder /app/public /usr/share/nginx/html