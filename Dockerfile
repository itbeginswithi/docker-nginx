# Stage 0, "build-stage", based on Node.js, to build and compile the frontend

FROM node:14.17 as build

WORKDIR /app


# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
ADD . .

#COPY . /app

RUN npm i

COPY ./ /app/

RUN npm run build

# Stage 1, "ased on Nginx, to have only the compiled app, ready for production with Nginx

FROM nginx:1.23.0

COPY --from=build /app/build/ /usr/share/nginx/html
#CMD [ "npm", "start" ]

# Copy the default nginx.conf provided by tiangolo/node-frontend
#COPY --from=build /nginx.conf /etc/nginx/conf.d/default.conf