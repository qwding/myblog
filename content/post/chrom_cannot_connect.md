+++
author = "qwding"
categories = ["chrome","vpn"]
date = "2016-11-14T12:14:39+08:00"
description = "chrome cannot connect web server"
draft = true
featured = ""
featuredpath = ""
linktitle = ""
title = "chrome 不能访问本地web server"

+++

### 起因

搭建了一个nsp 来测试，发现很恶心的是，用curl可以访问到，但是浏览器却访问不到,报问题：
```
The localhost page isn’t working
localhost didn’t send any data.
ERR_EMPTY_RESPONSE
``

我应该想到了。其实是开了代理。之前也遇到过，但是很快发现了，只不过这次注意力放在了开始装的虚拟机上，以为是虚拟机联网问题

谨以此文来提醒自己

还有个奇怪的问题是，用safari居然可以访问到，我代理是全局的额...好奇怪，最近没时间管，先放着