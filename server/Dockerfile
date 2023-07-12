FROM alpine:3.17

ENV NODE_VERSION 20.4.0

COPY package.json package.json

RUN apk add --update nodejs npm

RUN apk add --update npm

COPY . .

CMD ["node","index.js"]

EXPOSE 3001