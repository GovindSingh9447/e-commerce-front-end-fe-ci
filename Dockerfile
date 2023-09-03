FROM node:16.20 AS node-build
WORKDIR /app
COPY . .
RUN cp .env.example .env
RUN yarn
RUN yarn build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=node-build /app/build/ .
COPY default.conf /etc/nginx/conf.d/
ENTRYPOINT ["nginx", "-g", "daemon off;"]