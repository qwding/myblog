+++
author = "qwding"
categories = ["beego","golang","docker"]
date = "2016-10-19T10:28:28+08:00"
description = "Use different runmode of beego."
featured = ""
featuredpath = ""
linktitle = ""
title = "beego 如何不同环境用不同的runmode"

+++

### beego runmode修改

除了配置文件设置runmode，想切换环境时候需要手动改，太麻烦，而且容易忘

想通过如下两种方法尝试，均无效：

1. flag，但是beego本身并没有flag，简直行不通
2. 官方文档里个的方法是 beego.Runmode = "dev", 但其实这个方法很鸡肋，很蛋疼，因为读配置文件早在程序运行前执行了，而如果再程序里修改runmode，你在init里用的参数必然还是默认写的，用着基本蛋疼。

我在我本地beego 1.7的环境里又尝试了一下，发现已经没有这个方法了，可能作者也觉得确实蛋疼给删了吧。

### 环境变量改变

尝试将配置文件的runmode指定为环境变量，然后指定具体模式。发现居然成功了。不管怎么样，确实这个办法还是一个不错的解决方案了

### 加上docker更好用

因为本来用docker，这样直接在Dockerfile里设置ENV，部署线上的时候，直接用构建好的镜像启动就ok了，什么都不用改了。


<i> 懒人使人进步</i>
