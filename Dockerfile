FROM node:14.15-alpine AS builder

LABEL maintainer="Andrey Gridin <andrey@bitquery.io>"

ENV REACT_APP_IDE_URL=/ide
ENV PUBLIC_URL=/ide
ENV IDE_URL=/ide

ENV GRAPHQL_LEGACY_URL=https://graphql.bitquery.io
ENV GRAPHQL_URL=https://streaming.bitquery.io/graphql


WORKDIR /app

COPY package.json package-lock.json* ./

RUN chown node:node -R /app

USER node

RUN npm install --production

COPY --chown=node:node . .

RUN npm run build

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
