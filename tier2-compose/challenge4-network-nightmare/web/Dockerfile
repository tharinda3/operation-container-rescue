FROM nginx:1.19.6-alpine
RUN apk upgrade --no-cache
COPY index.html /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
