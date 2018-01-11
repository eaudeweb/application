#!/bin/bash

if [[ -z $NODE_ENV ]]; then
	export NODE_ENV=production
fi

if [[ -n $SENDER_MAIL ]]; then
	SEND_MAILS=true
	if [[ -z $SMTP_HOST ]]; then
		echo "You need to configure the SMTP_HOST variable to enable mails sending"
		SEND_MAILS=false
	fi
	if [[ -z $SMTP_PORT ]]; then
		echo "You need to configure the SMTP_PORT variable to enable mails sending"
		SEND_MAILS=false
	fi
	if [[ -z $SMTP_USER ]]; then
		echo "You need to configure the SMTP_USER variable to enable mails sending"
		SEND_MAILS=false
	fi
	if [[ -z $SMTP_PASSWORD ]]; then
		echo "You need to configure the SMTP_PASSWORD variable to enable mails sending"
		SEND_MAILS=false
	fi
else
	SEND_MAILS=false
	SMTP_HOST="localhost"
	SMTP_PORT=25
	SMTP_USER=user
	SMTP_PASSWORD=password
fi

if [[ -e /opt/lamunca-management/config/crypto_secret ]]; then
	CRYPTO_SECRET=$(cat /opt/lamunca-management/config/crypto_secret)
else
	echo -n $(tr -dc A-Za-z0-9_\#\(\)\!: < /dev/urandom | head -c 40 | xargs) > /opt/lamunca-management/config/crypto_secret
	CRYPTO_SECRET=$(cat /opt/lamunca-management/config/crypto_secret)
fi

if [[ -z $APP_URL ]]; then
	APP_URL=https://lamunca.eaudeweb.ro
fi

if [[ -z $PROMOTION_URL ]]; then
	PROMOTION_URL=https://lamunca.eaudeweb.ro
fi

if [[ -z $ALLOW_ACCOUNTS_CREATION ]]; then
	ALLOW_ACCOUNTS_CREATION=true
fi

cat > /opt/lamunca-management/config/app.json << EOF
{
  "allow_create_new_accounts" : $ALLOW_ACCOUNTS_CREATION,
  "send_emails"              : $SEND_MAILS,
  "application_sender_email" : "$SENDER_MAIL",
  "email_transporter" : {
    "host" : "$SMTP_HOST",
    "port" : $SMTP_PORT,
    "auth" : {
      "user" : "$SMTP_USER",
      "pass" : "$SMTP_PASSWORD"
    }
  },
  "crypto_secret" : "$CRYPTO_SECRET",
  "application_domain" : "$APP_URL",
  "promotion_website_domain" : "$PROMOTION_URL"
}
EOF

cat > /opt/lamunca-management/config/db.json << EOF
{
  "development": {
    "dialect": "sqlite",
    "storage": "./db.development.sqlite"
  },
  "test": {
    "username": "root",
    "password": null,
    "database": "database_test",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
EOF

if [[ -n $MYSQL_HOST && -n $MYSQL_USER && -n $MYSQL_PASSWORD ]]; then
	if [[ -z $MYSQL_DATABASE ]]; then
		MYSQL_DATABASE="lamunca"
	fi
	cat >> /opt/lamunca-management/config/db.json << EOF
  "production": {
    "username": "$MYSQL_USER",
    "password": "$MYSQL_PASSWORD",
    "database": "$MYSQL_DATABASE",
    "host": "$MYSQL_HOST",
    "dialect": "mysql"
  }
}
EOF
else
	cat >> /opt/lamunca-management/config/db.json << EOF
  "production": {
    "dialect": "sqlite",
    "storage": "./db.production.sqlite"
  }
}
EOF
fi

cat > /opt/lamunca-management/config/localisation.json << EOF
{
  "countries" : {
    "RO" : {
      "name" : "Romania",
      "bank_holidays" : [
        {
          "name" : "New Year Day",
          "date" : "2018-01-01"
        },
        {
          "name" : "Unirea lui Cuza",
          "date" : "2018-01-24"
        },
        {
          "name" : "Easter",
          "date" : "2018-04-09"
        },
        {
          "name" : "Labour Day",
          "date" : "2018-04-01"
        },
        {
          "name" : "Rusaliile",
          "date" : "2018-05-28"
        },
        {
          "name" : "Child Day",
          "date" : "2018-06-01"
        },
        {
          "name" : "Assumption of Mary",
          "date" : "2018-08-15"
        },       
        {
          "name" : "Child Day",
          "date" : "2018-06-01"
        },
        {
          "name" : "Saint Andrew's Day",
          "date" : "2018-11-30"
        }, 
        {
          "name" : "Romania's National Day",
          "date" : "2018-12-01"
        },               
        {
          "name" : "Christmas Day",
          "date" : "2017-12-25"
        }
      ]
    },

    "IS" : {
      "name" : "Iceland"
    }

    }
  }

EOF

npm run-script db-update
npm start
