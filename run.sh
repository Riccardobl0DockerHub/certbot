#!/bin/sh

cert_name="`echo $DOMAINS | tail -n1 | cut -d',' -f1`"

certbot delete --cert-name $cert_name

certbot certonly    --expand   --keep  --text --server https://acme-v01.api.letsencrypt.org/directory --agree-tos --email  $EMAIL --standalone\
     --preferred-challenges http-01 -d $DOMAINS

cat /etc/letsencrypt/live/$cert_name/fullchain.pem > /certs/fullchain.pem
cat /etc/letsencrypt/live/$cert_name/privkey.pem > /certs/privkey.pem
