FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y git npm nodejs nodejs-legacy



WORKDIR /opt
RUN   git clone https://github.com/timeoff-management/application.git timeoff-management
COPY  application/views/partials/footer.hbs  /opt/timeoff-management/views/partials/footer.hbs
COPY  application/views/partials/header.hbs  /opt/timeoff-management/views/partials/header.hbs
COPY  application/views/index.hbs  /opt/timeoff-management/views/index.hbs

WORKDIR /opt/timeoff-management
RUN npm install



EXPOSE 3000
CMD npm start
