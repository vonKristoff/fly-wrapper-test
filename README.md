# DockerHost

A Dockerfile test to wrap and deploy SvelteKit apps.

1. `pnpm i -D @sveltejs/adapter-node`
2. switch adapter in `svelte.config.js`
3. create #Dockerfile
4. use `CMD ["node", "build/index.js"]` to run the App
5. App runs by default on `3000` so ensure this is exposed as you need
6. Do not forget to make use of a #DockerIgnore file

## #Dockerfile
```
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json .
# npm install
RUN npm ci
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
```
## #DockerIgnore
The `.dockerignore` file contents:
```
Dockerfile
.dockerignore
.git
.gitignore
.gitattributes
README.md
.npmrc
.prettierrc
.eslintrc.cjs
.graphqlrc
.editorconfig
.svelte-kit
.vscode
node_modules
build
package
**/.env
```
