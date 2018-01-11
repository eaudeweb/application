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


npm start
