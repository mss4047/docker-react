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

EXPOSE 80
# port 80 gets mapped for port mapping
# this is normally to indicate to developers
# that port 80 should be exposed
# BUT AWS EBS is different, and reads this and automatically routes incoming
# traffic through port 80

COPY --from=builder /app/build /usr/share/nginx/html
# default command of nginx starts up nginx, so we don't need to specify a startup command





