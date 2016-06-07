+++

date = "2016-06-07T19:19:58+08:00"
description = "在实例方法内修改实例地址"
categories = ["shell","docker","mysql","mongo"]
title = "shell execute mongo/mysql which start by docker."

+++

# #问题初衷

打算一键部署带权限验证的mongo。但是docker hub官方镜像创建mongo步骤为：
```
docker run --name mongodb -d -p 27017:27017 mongo:3.3 --auth
docker exec -it mongodb mongo admin
db.createUser({ user: 'root', pwd: 'root', roles: [ { role: "root", db: "admin" } ] });
```
打算将其做成脚本

# #用shell实现

经过查阅，发现shell的 <<EOF 可以实现，查阅资料 http://my.oschina.net/u/1032146/blog/146941

应该可以实现,于是写了脚本
```
#!/bin/bash
mongo admin << EOF
db.createUser({ user: 'root', pwd: 'root', roles: [ { role: "root", db: "admin" } ] });
exit;
EOF
```
在mongo 启动的容器内执行脚本，成功！

# #直接写脚本启动容器(error)
```
!/bin/bash
docker run --name mongodb -d -p 27017:27017 dhub.yunpro.cn/cloud/mongo:3.3 --auth
sleep 1
docker exec -it mongodb mongo admin << EOF
db.createUser({ user: 'root', pwd: 'root', roles: [ { role: "root", db: "admin" } ] });
exit;
EOF
```
sleep 1秒是保证mongo起来后才执行exec。

但是会报错 `cannot enable tty mode on non tty input`

为什么报错呢？容器内运行却没问题

一开始认为是不是docker exec 后面接命令执行 << EOF 识别不了？想了想不是这么回事

后来仔细思考了报错，只不过说不能启动一个伪终端，我又想到docker的 i 和 t 参数分别表示输入和伪终端，是不是根本就不需要伪终端啊，于是将 t 参数去掉

执行成功！

# #总结

对shell并不熟悉，也不太深入了解伪终端，但是像这种启动mongo的方法，也类似于启动mysql，执行mysql句子类似，还是应了解每个参数作用

# 附上改后脚本(ok)

```
#!/bin/bash
docker run --name mongodb -d -p 27017:27017 dhub.yunpro.cn/cloud/mongo:3.3 --auth
sleep 1

docker exec -i mongodb mongo admin << EOF
db.createUser({ user: 'root', pwd: 'root', roles: [ { role: "root", db: "admin" } ] });
exit;
EOF
```



