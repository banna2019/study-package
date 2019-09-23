#!/bin/bash


url='http://127.0.0.1:8883/nginx_status'

case $1 in
    Active)
    curl -s $url | grep connections | awk '{print $NF}'
    ;;
    Reading)
    curl -s $url |tail -1 | awk '{print $2}'
    ;;
    Writing)
    curl -s $url |tail -1 | awk '{print $4}'
    ;;
    Waiting)
    curl -s $url |tail -1 | awk '{print $6}'
    ;;
    ping)
    code=`curl -I -m 10 -o /dev/null -s -w %{http_code} $url`
    if [ $code == '200' ]
        then
            echo 1
        else
            echo 0
    fi
    ;;
    *)
    echo error input
    ;;
esac