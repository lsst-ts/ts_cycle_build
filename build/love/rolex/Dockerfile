FROM alpine/git AS cloner

WORKDIR /tmp

RUN git clone https://github.com/tribeiro/rolex.git

FROM node:lts as builder

COPY --from=cloner /tmp/rolex /usr/src/rolex

WORKDIR  /usr/src/rolex

RUN npm install astro
RUN npm run build

FROM node:lts AS runtime

COPY --from=builder /usr/src/rolex/dist /usr/src/rolex/dist

WORKDIR  /usr/src/rolex

ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321

CMD node ./dist/server/entry.mjs
