FROM node

ADD ./package.json /webapp/package.json
WORKDIR /webapp
RUN npm install

ADD . /webapp

CMD npm start
