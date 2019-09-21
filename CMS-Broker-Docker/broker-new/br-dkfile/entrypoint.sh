#!/bin/sh

cat /etc/nginx/nginx.conf.template | \
  sed "s/@HTTP_HOST@/$HTTP_HOST/g"  | \
  sed "s/@HTTPS_HOST@/$HTTPS_HOST/g" | \
  sed "s/@HTTP_PORT@/$HTTP_PORT/g"  | \
  sed "s/@HTTPS_PORT@/$HTTPS_PORT/g" | \
  sed "s/@ELB_HTTP_URL@/$ELB_HTTP_URL/g" | \
  cat > /etc/nginx/nginx.conf
nginx -g "daemon off;"
