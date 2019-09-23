#!/bin/bash

code=`curl -I -m 10 -o /dev/null -s -w %{http_code} http://127.0.0.1:8883/nginx_status`
if [ $code == '200' ]
    then
        a='1'
    else
        a='0'
fi

if [ "`ps aux | grep 'nginx:' | grep -v grep`" ] && [ $a -eq 1 ]
    then
        echo "{\"data\":[{\"{#NGINX}\":\"nginx\"}]}"
    else
        echo "{\"data\":[{}]}"
fi