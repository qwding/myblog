+++
author = "qwding"
categories = ["mongo","docker","dockerfile"]
date = "2016-10-20T10:37:02+08:00"
description = "mongo backup"
featured = ""
featuredpath = ""
linktitle = ""
title = "mongo 备份"

+++

# mongo 备份

秉承方便简单，易搭建原则，还是用docker来实现,[镜像地址（https://hub.docker.com/r/carlding/mongobackup/）](https://hub.docker.com/r/carlding/mongobackup/)

docker hub找到一个镜像，istepanov/mongodump可以实现本地monogo的备份，查阅其内部脚本，并没有开放传入远程数据库的接口，于是在此基础上改进


Dockerfile
```
FROM istepanov/mongodump

​MAINTAINER qwding 
ADD backup.sh backup.sh
ADD start.sh start.sh

```

backup.sh

```
#!/bin/bash
set -e
echo "Job started: $(date)"
DATE=$(date +%Y%m%d_%H%M%S)
FILE="/backup/backup-$DATE.tar.gz"
echo "mongodump -h $MONGO_PORT_27017_TCP_ADDR -p $MONGO_PORT_27017_TCP_PORT -u $MONGO_USER -p $MONGO_PASSWORD -d $MONGO_DB"
mongodump -h $MONGO_PORT_27017_TCP_ADDR -u $MONGO_USER -p $MONGO_PASSWORD -d $MONGO_DB
tar -zcvf $FILE dump/
rm -rf dump/
echo "Job finished: $(date)"
```

start.sh
```
#!/bin/bash
set -e
CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}
if [[ "$1" == 'no-cron' ]]; then
    exec /backup.sh
else
    LOGFIFO='/var/log/cron.fifo'
    if [[ ! -e "$LOGFIFO" ]]; then
        mkfifo "$LOGFIFO"
    fi
    CRON_ENV="MONGO_PORT_27017_TCP_ADDR='$MONGO_PORT_27017_TCP_ADDR'"
    CRON_ENV="$CRON_ENV\nMONGO_USER='$MONGO_USER'"
    CRON_ENV="$CRON_ENV\nMONGO_PASSWORD='$MONGO_PASSWORD'"
    CRON_ENV="$CRON_ENV\nMONGO_DB='$MONGO_DB'"
    echo -e "$CRON_ENV\n$CRON_SCHEDULE /backup.sh > $LOGFIFO 2>&1" | crontab -
    crontab -l
    cron
    tail -f "$LOGFIFO"
fi
```


构建：
```
docker build -t carlding/mongobackup . 
```

运行：
```
docker run -d -v /root/mongo:/backup -e 'CRON_SCHEDULE=0 0 * * *' -e MONGO_PORT_27017_TCP_ADDR=remote.addr:27017 -e MONGO_USER=carlding -e MONGO_PASSWORD=carlding -e MONGO_DB=mongo  carlding/mongobackup 

```

如上为每天零点执行一次mongo备份，并且将备份文件以时间为名字保存在了 /root/mongo目录下

立即备份：
```
docker run -d -v /root/mongo:/backup  -e MONGO_PORT_27017_TCP_ADDR=remote.addr:27017 -e MONGO_USER=carlding -e MONGO_PASSWORD=carlding -e MONGO_DB=mongo  carlding/mongobackup 

```