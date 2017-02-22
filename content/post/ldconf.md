+++
author = "qwding"
categories = ["linux"]
date = "2017-02-22T18:11:04+08:00"
description = ""
featured = ""
featuredpath = ""
linktitle = ""
title = "ldconfig"

+++

### 事情起因

最近接了个C++项目，结果编译完放到服务器上会报动态库版本不对，之后又是一个系统库不对，我粗暴的将CentOS 7(之前不知道系统是7...不然打死也不这么干啊) 的/lib64/libc.so.6 直接拷贝到了CentOS 6.5系统上，灾难发生了....

所有命令用不了，傻逼了... 恰好那个服务器正跑着一个pv 几百万的项目，顿时压力山大

绝大部分命令都用不了，ls 命令都用不了了，本想将软链换回去，ln 不好使，怎么办！

后来查阅到命令ldconfig，专门管理动态库的，发现这个命令可以运行诶（哭笑脸）。

在查阅其参数，发现只有一个-l貌似可以用到，可是大部分博客都是这么写的： -l  Manually link individual libraries. 并没有看到列子（哭笑脸）

抱着死马当活马医的心态试用如下

```
ldconfig -l /lib64/libc.so.6 /lib64/libc-2.12.so
```

居然好使了，福大命大！
后来检查发现，貌似这个命令只是临时更改软链，想永久改还是需要修改文件的。


### ldconfig

主要还是管理linux的动态链接库的，安装动态链接库以后，需要将库目录放到 /etc/ld.so.conf 里面，再执行ldconfig，这时候会将库的信息放到  /etc/ld.so.cache（高速缓存机制）。 系统在使用库时候先去 /etc/ld.so.cache 目录下找，找到了再去 /etc/ld.so.conf 目录下找。所以如果  /etc/ld.so.cache 没有，那就找不到。到这里也就明白了，新加库，就要执行ldconfig，但是更新的话就不需要了

### linux博大精深

不搞不知道，最近新接的别人的项目，发现写C的还是对底层能更是了解很多啊！linux很多东西用C写起来更能发挥效果啊。




