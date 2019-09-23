#!/bin/sh

BACKUP_BIN=/bin/mysqlbinlog
LOCAL_BACKUP_DIR=/data/backup
BACKUP_LOG=/data/logs/bakbinlog.log
REMOTE_HOST=banna-mysql.ccrj65bnfxba.ap-southeast-1.rds.amazonaws.com
REMOTE_PORT=3306
SERVER_ID=20003306
REMOTE_USER=root
REMOTE_PASS=27jq7bhfO81B6qqNZfx6jK0R

#time to wait before reconnecting after failure
SLEEP_SECONDS=10
DE=`date +%Y%m%d`

##create local_backup_dir if necessary
if [ ! -d ${LOCAL_BACKUP_DIR} ];then
    mkdir -pv ${LOCAL_BACKUP_DIR} && mkdir -pv /data/logs
else
	cd ${LOCAL_BACKUP_DIR}
fi

##运行while循环,连接断开后等待指定时间,重新连接
while :
FIRST_BINLOG=$(mysql --host=${REMOTE_HOST} --user=${REMOTE_USER} --password=${REMOTE_PASS} -e 'show binary logs' 2>/dev/null|grep -v "Log_name"|awk '{print $1}'|head -n 1)
do
  if [ `ls -A "${LOCAL_BACKUP_DIR}" |wc -l` -eq 0 ];then
     LAST_FILE=${FIRST_BINLOG} 
  else
     LAST_FILE=`ls -l ${LOCAL_BACKUP_DIR} |tail -n 1 |awk '{print $9}'`
  fi
  ${BACKUP_BIN} -R --host=${REMOTE_HOST} --user=${REMOTE_USER} --password=${REMOTE_PASS} --raw ${LAST_FILE} -r ${LOCAL_BACKUP_DIR}/  --stop-never --stop-never-slave-server-id=${SERVER_ID} 2>/dev/null 
  echo "`date +"%Y/%m/%d %H:%M:%S"` mysqlbinlog停止,返回代码：$?" | tee -a ${BACKUP_LOG}
  echo "${SLEEP_SECONDS}秒后再次连接并继续备份" | tee -a ${BACKUP_LOG}  
  sleep ${SLEEP_SECONDS}
done

