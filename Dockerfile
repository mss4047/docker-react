# build phase

FROM node:alpine AS builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

# build folder will be created in /app/build
RUN npm run build 

# run phase

FROM nginx
# this is syntax, copy build folder from previous step and store in nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
# default command of nginx starts up nginx, so we don't need to specify a startup command





