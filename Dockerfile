# build environment
FROM node:alpine as react-build
WORKDIR /app
COPY . ./
RUN npm i
RUN npm run build

# server environment
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/configfile.template
ENV PORT 9047
ENV HOST 0.0.0.0
RUN sh -c "envsubst '\$PORT'  < /etc/nginx/conf.d/configfile.template > /etc/nginx/conf.d/default.conf"
COPY --from=react-build /app/build /usr/share/nginx/html
EXPOSE 9070
CMD ["nginx", "-g", "daemon off;"]


# FROM node:12.18.3-alpine

# # Create app directory
# RUN mkdir -p /usr/src/app
# #Set the created directory
# WORKDIR /usr/src/app

# # Install app dependencies
# # A wildcard is used to ensure both package.json AND package-lock.json are copied
# # where available (npm@5+)
# COPY package*.json /usr/src/app/

# RUN npm install
# # If you are building your code for production
# # RUN npm install --only=production

# # Bundle app source
# COPY . /usr/src/app

# EXPOSE 9047

# # Change this to whatever is the executable, it could be either server.js or app.js
# CMD [ "node", "app.js" ]
