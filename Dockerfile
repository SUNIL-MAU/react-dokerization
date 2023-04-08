# step 1
FROM node:alpine as build
WORKDIR /myapp
COPY package*.json /myapp/
RUN npm install
COPY . .
RUN npm run build

# step 2

FROM nginx:alpine
COPY --from=build /myapp/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]