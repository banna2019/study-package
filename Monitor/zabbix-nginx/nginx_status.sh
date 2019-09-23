#!/bin/bash
# DateTime: 2017-01-22
# AUTHOR：kbsonlong
# Description：zabbix监控nginx性能以及进程状态
# Note：此脚本需要配置在被监控端
# zabbix_agentd.conf: 添加自定义key，UserParameter=nginx.status[*],/data/PRG/zabbix/scripts/nginx_status.sh -F $1 -P $2 
 
HOST="127.0.0.1"
PORT="8883"
 
# 检测nginx进程是否存在
function ping {
    /sbin/pidof nginx | wc -l
}
# 检测nginx性能
function active {
    /usr/bin/curl "http://$HOST:$PORT/NginxStatus/" 2>/dev/null| grep 'Active' | awk '{print $NF}'
}
function reading {
    /usr/bin/curl "http://$HOST:$PORT/NginxStatus/" 2>/dev/null| grep 'Reading' | awk '{print $2}'
}
function writing {
    /usr/bin/curl "http://$HOST:$PORT/NginxStatus/" 2>/dev/null| grep 'Writing' | awk '{print $4}'
}
function waiting {
    /usr/bin/curl "http://$HOST:$PORT/NginxStatus/" 2>/dev/null| grep 'Waiting' | awk '{print $6}'
}
function accepts {
    /usr/bin/curl "http://$HOST:$PORT/NginxStatus/" 2>/dev/null| awk NR==3 | awk '{print $1}'
}
function handled {
    /usr/bin/curl "http://$HOST:$PORT/NginxStatus/" 2>/dev/null| awk NR==3 | awk '{print $2}'
}
function requests {
    /usr/bin/curl "http://$HOST:$PORT/NginxStatus/" 2>/dev/null| awk NR==3 | awk '{print $3}'
}
# 执行function
while getopts "H:P:F:" OPT; do
        case $OPT in
                "P")
                	PORT=$OPTARG
                	;;
                "F")
                	fun=$OPTARG
                	;;
                "H")
                	HOST=$OPTARG
                	;;
        esac
done

$fun