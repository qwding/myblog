+++
author = "qwding"
categories = ["vim", "golang"]
date = "2018-02-12T10:28:28+08:00"
description = "write golang in vim"
featured = ""
featuredpath = ""
linktitle = ""
title = "用vim写golang踩坑"

+++


### vim 写golang碰到的爽点

自从转到了vim写golang, 越用越觉得舒服，几个爽点IDE媲美不了

* 返回上次动作地方，无论是跳文件还是跳操作行，都可以直接返回上次操作的地方，极舒服
* 根本不需要鼠标，不用写代码还感觉食指高度使用的难受了
* 可以装逼了

### 不爽

* 每摄入一门语言配环境是最折腾的，就像我的python环境还没配好，还用pycharm写呢
* 写golang时候居然有的不能跳转pkg
* 自动补全时候居然每次会卡1~2秒左右，不能忍啊！

### 不能跳转到pkg

开始以为是ctags的问题，但是发现有些pkg我并没有生成tags文件，但是还是能跳转过去，感觉ctags并不是我跳转的方式

仔细阅读vim-go，发现是gocode配合YCM跳转的，那就去读gocode文档，发现不得了的事情

gocode居然跳转是需要pkg生成相应的 .a 文件，深坑!

由于公司依赖很多都是Cgo写的，mac本地根本不可能编译一些pkg，自然就没有 .a 文件，而且查看issue说这个是一直诟病的问题

解决答案就是：我还解决不了！还好，就几个pkg，可以忍忍

### 自动补全卡1~2秒

之前以为是YCM的锅，后来发现写python 自动补全流畅的一逼，这锅YCM不接

那肯定出再了golang插件

运行一些神奇的命令调试
```
:profile start profile.log
:profile func *
:profile file *
" At this point do slow actions
:profile pause
:noautocmd qall!

```

结果如下
```
FUNCTIONS SORTED ON TOTAL TIME
1264 count  total (s)   self (s)  function
1265    21   4.449469   0.009312  <SNR>81_OnTextChangedInsertMode()
1266    18   4.412641   0.122766  <SNR>81_InvokeCompletion()
1267     4   4.283708   0.001012  gocomplete#Complete()
1268     2   4.282696   0.000581  <SNR>82_gocodeAutocomplete()
1269     2   4.280647   0.000218  <SNR>82_gocodeCommand()
1270     2   4.280429   0.001030  <SNR>82_system()
1271    93   0.024871             <SNR>81_Pyeval()
```

```
21   0.006486   0.000541   if &completefunc == "youcompleteme#CompleteFunc" && ( g:ycm_auto_trigger || s:force_semantic ) && !s:InsideCommentOrStringAndShouldStop()      && !s:OnBlankLine()
 117                                 " Immediately call previous completion to avoid flickers.
 118    18   0.000968   0.000183     call s:Complete()
 119    18   4.412819   0.000178     call s:InvokeCompletion()
 120    18              0.000045   endif
 ```

 主要是上面这句花了大部分时间，但是我并不能看懂这到底在干嘛

 但是注意里面有很多auto的操作，突然联想到了gocode文档有些autobuild，会构建很久没有构建的pkg，而我本地有很多编译不了的pkg，是不是这个导致每次都编译，每次都不成功，然后每次都卡很久？

 然后把autobuild的操作置为false，神奇出现了，自动补全消耗的1秒消失了，极其快了


### 总结

 对vim和自动补全的不熟悉，很多问题不知道如何下手，通过多次尝试解决这两个问题，慢慢对他熟悉起来，越用越舒服
