
# La Munca

Web application for managing employee absences.

[![Docker]( https://img.shields.io/travis/rust-lang/rust.svg?organization=eaudeweb&repository=lalucru.eaudeweb)](https://hub.docker.com/r/eaudeweb/lamunca/builds)


## Using the docker image
### Testing on local

1. Pull the docker image from Docker Hub: docker pull eaudeweb/lamunca

2. Create and run the container docker run eaudeweb/lamunca

3. Open your browser to http://localhost:3000


## Use in production

By default, the timeoff container will use a sqlite database and a no smtp server will be configured.

To configure a production database, set `NODE_ENV` environment variable to `production` and set corresponding MYSQL variables: `NODE_ENV=production`, see `docker-compose.yml.example`

You can configure the container using `docker-compose`:
1. Clone the repo:
`git clone https://github.com/eaudeweb/lamunca.git`

2. Change working directory:
`cd lamunca`

3. Edit desired files:
> most of the conf files are here lamunca/views/

4. After edit run docker-compose in the same directory where your docker-compose.yml file is located:
`docker-compose up -d`

5. Open your browser to http://localhost:3000

## Environment variables

You can set the following variables to configure the `lamunca_app` container:

 Variable name | Configuration | Default | Possible values | Remarks
---------------|---------------|---------|-----------------|---------
`NODE_ENV` | Set environment | `development` | `development`, `production`, `test` | You should always use `production`
`SENDER_MAIL` | Mails from | None | email address | Needed for enabling mail sending
`SMTP_HOST` | smtp server host | None | host | Needed for enabling mail sending
`SMTP_PORT` | smtp server port | None | port | Needed for enabling mail sending
`SMTP_USER` | smtp username | None | username/address | Needed for enabling mail sending
`SMTP_PASSWORD` | smtp password | None | password | Needed for enabling mail sending
`APP_URL` | Set application URL in sent mails | `https://lamunca.eaudeweb.ro` | URL | You should set this
`PROMOTION_URL` | Set url in footer mails | `https://lamunca.eaudeweb.ro` | URL | You can change this if you want footer mail link to redirect to your hosted application
`ALLOW_ACCOUNTS_CREATION` | Enable/Disable public companies account creation | `true` | `true` , `false` | You need to enable account creation at least on first run to create your company. You can disable it afterwards and restart the container

# Building the docker image

1. Clone the repo:
`git clone repo`

2. Change working directory:
`cd repo`

3. Build image:
`docker build -t lamunca:latest .`
