+++
author = "qwding"
categories = ["job","golang"]
date = "2017-08-04T14:33:08+08:00"
description = "find_job"
featured = ""
featuredpath = ""
linktitle = ""
title = "Waiting a new job"

+++

# 公司快黄了，开始找工作

在7月末，8月初，本来也并不是找工作的黄金时期来找工作，也是因为公司快黄了，该走了。

等出去面试后感觉，并不是很少人在跳槽，有的公司的资历老点的人整天都在面试，工作都要加班到后半夜，感觉也是不容易。

# 聊聊HR的坑

天真的我，以为实话实说并没有什么问题。于是在第一周的时候，hr会问，你为什么从前两家离职，我说上一家创业公司内部矛盾比较多，上下层有点脱节。

可谓是说了老东家的坏话，这TMD，只能说：我是傻逼！

说老东家坏话简直是一大禁忌，在周末的某个忧虑的晚上，突然深深感受到自己的傻逼，于是在接下来的面试，我都是说公司搬家，上班太远等等为借口了，效果还不错，感觉和hr应该没有聊的什么太大问题。

# 技术短板

其实面试的每家公司，基本都可以面到最后一面，但是给offer的寥寥，为什么？！

总结了一下无非几点

1. 没有大公司经验，其实我并不认为去大公司怎么怎么好，相反可能了解的会更窄；但是这时候发现，却是必不可少的，很多公司更注重你之前的环境，大公司那种内涵吧，亦或许是 “这家伙已经过了大公司的面试，应该还是挺牛逼的”。
2. 没有高并发和分布式经验。高并发指的啥，有几个公司可以说自己的量集很大是高并发，并且碰到很难解决的问题呢。即使是像抢购手机这样的高并发量，其实了解背后，也都是很简单粗暴的方式解决，并没有说你通过牛逼的代码就可以解决。但是人家就是要看你有没有这个经验。
3. 数据库需求，有几个大厂，貌似对数据库要求比较高，像我这种可能没有真做过读写分离，数据库量级没有那么高，被问到一些mysql的尖酸问题，直接gg。
4. 钱要的有点过，人家并不着急要人，这才是根本原因....

# 这些年到底做了什么

看到上面几点，感觉这几年工作到底做了啥，是不是天天上班晃悠了

有点心酸，谁乐意晃悠到现在感觉找工作又很尴尬呢。找工作真的是一件很看运气的事，在现在公司我工做也是很认真，但是真正的工作内容可能并不适合我现在要找的方向，并不适合。

也许我在这里一直在擦屁股或者去擦屁股的路上（戴维营欢迎你 2333）。


# 说一说碰到的主要问题吧

### golang

1. gc实现，主要是三色标记过程
2. slice，map实现原理
3. golang的锁应用
4. chan的应用，sync.waitGroup，select 的timeout导致cpu激增。
5. var tmp interface{} = nil;  tmp == nil 返回值（答案是false)
6. 怎么优化gc停顿时间
7. pprof怎么调优
8. 阅读过哪些golang写的源码： k8s，docker，beego等

其实遇到golang的问题，我一般还是都可以应对自如的，基本没啥问题


### 几个值得学习的问题

1. 系统设计，比如说有个活动，设计一套系统：匹配对手，出石头剪子布，胜者可抽奖。设计这么套系统。
主要注意的点： 匹配对手，比赛出拳，抽奖，奖池。最主要考察的是，这是一个分布式高并发的系统。
2. 算法，这个不用多说了，多刷题吧，一般不会太难，把递归搞通了可以处理大部分面试的难度。
3. linux 命令，一般awk，ss -s，sed等等吧，但是sed我是真用的不多，碰到gg。


# 弄得好不如白话的好

即使不是你做的，你可以白话成你做的

即使不牛逼，也可以白话的很牛逼

即使问题并不难，但是也可以白话好解决问题过程


其实面试还是一个心理挑战，你把面试官忽悠明白，让他认为你行就可以，而能力是其次的，你做事情的能力不如你白话的能力。