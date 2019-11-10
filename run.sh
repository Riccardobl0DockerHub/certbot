#!/bin/sh
set -x

if [ "$STAGING" != "" ];
then
    export URL="https://acme-staging.api.letsencrypt.org/directory"
fi

if [ "$URL" != "" ];
then
    export URL="--server  $URL"
fi

cert_name="`echo $DOMAINS | tail -n1 | cut -d',' -f1`"

certbot delete --cert-name $cert_name

certbot certonly    --expand   --keep  --text $URL --agree-tos --email  $EMAIL --standalone\
     --preferred-challenges http-01 -d $DOMAINS

sleep 2
rm /certs/fullchain.pem
rm /certs/privkey.pem
cat /etc/letsencrypt/live/$cert_name/fullchain.pem >  /certs/fullchain.pem
cat /etc/letsencrypt/live/$cert_name/privkey.pem > /certs/privkey.pem
