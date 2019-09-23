#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author:Administrator
# datetime:2019/7/14 0014 17:21
# software: PyCharm

from kafka import KafkaConsumer
from kafka import TopicPartition
import json

consumer = KafkaConsumer("maxwell",bootstrap_servers = ["127.0.0.1:9092"])
for each in consumer:
    mjson = each.value
    print(mjson)
   # njson = mjson.replace('}}','}}\n')
   # print(njson)
    fp = open('./djson.json','a+')
    try:
        for s in mjson:
            fp.write(s)
    except Exception as e:
        print(e)
        fp.close()
