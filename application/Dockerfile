FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y git npm nodejs nodejs-legacy

RUN adduser --system app --home /app
USER app

WORKDIR /app
RUN git clone https://github.com/anecula/application.git  lamunca-management

WORKDIR /app/lamunca-management
RUN npm install

EXPOSE 3000
CMD npm start
