FROM nginx:alpine

RUN apk update && apk upgrade --no-cache

COPY application/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
