FROM node:14.3.0-stretch
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
CMD ["node", "index.js"]