#!/usr/bin/env python

import string
import random
import pymysql
import time

#conn = MySQLdb.connect(host='192.168.56.51',port=3306,user='root',passwd='abc123',db='test')
conn = pymysql.connect(host='localhost',port=3306,user='root',passwd='abc123',db='test',charset='utf8')

"""
create table zs_user(uid int not null auto_increment,name varchar(32),add_time datetime,primary key(uid));

"""

def insert(para):
    i = 11
    while True:
        r_name = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(random.randint(10,30)))
        print(r_name)

        cursor = conn.cursor()
        cursor.execute("INSERT INTO zs_user(name,add_time) VALUES('%s',now())" % str(r_name))
        i = i + 1
        conn.commit()
        time.sleep(0.1)
        print(1)

insert(conn)
