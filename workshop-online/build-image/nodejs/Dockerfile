FROM node:14.3.0-stretch
WORKDIR /app
COPY package.json .
RUN npm install
COPY index.js .
ENTRYPOINT ["node", "index.js"]
EXPOSE 3000
