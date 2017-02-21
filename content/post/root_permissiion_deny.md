+++
author = "qwding"
categories = ["linux","permission"]
date = "2017-02-21T15:05:28+08:00"
description = "permission denied when use user root."
featured = ""
featuredpath = ""
linktitle = ""
title = "使用root用户时候出现权限不够"

+++

### 非常费解的问题

写了一个logrotate的脚本，用crontab定时跑，非常费解的问题出现了，我单独跑logrotate怎么跑都没问题，但是放到crontab里就会出现权限不够的问题。其中就有使用curl权限不够，百思不得其姐！

有没有搞错，我是root用户啊，还出现权限不够的问题。

试过了将curl权限提到最高，赋给s权限，均失败。

google查阅curl permission denied  / crontab permission denied  /  logrotate permission denied  均无果。 吐血。。。

### 过程

查阅系统日志（centos）

```
 cat /var/log/messages |grep curl

 Feb 21 14:52:01 client kernel: type=1400 audit(1487659921.234:2409): avc:  denied  { name_connect } for  pid=26860 comm="curl" dest=2727 scontext=system_u:system_r:logrotate_t:s0-s0:c0.c1023 tcontext=system_u:object_r:unreserved_port_t:s0 tclass=tcp_socket

```

什么鬼，看不懂，仔细查阅一下，查到SELinux。


我去，这不是之前搞mysql常遇到的问题么

修改 /etc/selinux/config 

```
SELINUX=disabled   # 设置为disabled
```

测试crontab好使了!


### SELinux 

这个是什么美国国家安全局，增加安全控制的东西

这个设置了enforcing时候，你的root用户其实也没毛多大用了，也是受限制的。

总之就是不让你动你运行程序以外的文件

### 纠错过程

很曲折，一直以为是crontab运行时候用户的问题，或者文件的权限问题，在root下还是报错，所以一直卡在那里。 最后能找到问题也是花费好多时间...... 好烦


