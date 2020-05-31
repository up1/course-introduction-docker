# stage 1 :: Build and compile
FROM node:14.3.0-stretch as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG configuration=production
RUN npm run build -- --outputPath=./dist/out --configuration $configuration


# Stage 2, use the compiled app, ready for production with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/out/ /usr/share/nginx/html
