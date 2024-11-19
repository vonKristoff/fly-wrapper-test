FROM node:22-alpine AS builder
ARG REPO
ENV REPO=${REPO}
RUN echo $REPO
WORKDIR /app
COPY package*.json .
RUN npm install
RUN git clone $REPO vault
COPY . .
RUN npm run build
RUN npm prune --production

FROM node:22-alpine
WORKDIR /app
COPY --from=builder /app/build build/
COPY --from=builder /app/node_modules node_modules/
COPY package.json .
EXPOSE 3000
ENV NODE_ENV=production
CMD [ "node", "build" ]
