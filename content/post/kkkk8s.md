+++
author = "qwding"
categories = ["k8s"]
date = "2018-11-15T10:28:28+08:00"
description = "k8s"
featured = ""
featuredpath = ""
linktitle = ""
title = "k8s点点理解"

+++



### 前缘

15年在某云公司，搞k8s，很基础，各种调api，公司6号员工，本想一直坚持干下去，可惜我这小暴脾气，后来走了。

那时k8s还没有1.0，使用各种不稳定，各种杂七杂八问题


### 现在

突然间给我分到现在组，要弄k8s，在看他的时候，还是以前的样子

### 点点理解

1. k8s 自己搞了个大网
2. 所有信息放到了etcd
3. 其他组件访问etcd，做该做的事

我感觉这三点概括了k8s整体工作流程，至于其他组件干了什么，google现在一大堆了
