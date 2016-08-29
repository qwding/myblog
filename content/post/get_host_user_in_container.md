+++
author = "qwding"
categories = []
date = "2016-08-29T15:08:37+08:00"
description = "Get host user in docker container "
featured = ""
featuredpath = ""
linktitle = ""
title = "Docker容器里获取宿主机用户"

+++

# 尝试方法

1. 映射宿主机文件到容器，试过几个文件，但是都效果并不好
2. 启动容器前执行命令将用户写入文件，再启动容器
```
echo `echo $USER` > tmp.file && docker run -it alpine /bin/sh
``` 
但是遇到问题，就是我在容器的里的程序删除文件会遇到文件忙，没有深究原因
3. 突然想到了我们启动容器的时候经常用 -v `pwd`:/folder。这样应该是执行了shell命令，那么能不能在冒号右侧执行呢。于是测试了一下发现可行。

将命令改为
```
docker run -it -e HOSTUSER=`echo $USER` apline /bin/sh

//测试
$/ echo $HOSTUSER 
结果正确
```
### 举一反三
既然可以这么获得用户名，那么其实也可以获得其他宿主机信息了，系统信息，能用shell获得的命令，都可以在启动容器时候传入环境变量


