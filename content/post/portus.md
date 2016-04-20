+++
date = "2016-04-20T11:48:19+08:00"
description = "contrast hugo with hexo"
highlight = true
tags = ["portus","registry"]
title = "portus的docker容器搭建"
index = true
+++

### 一般形式

在官方文档，或者百度谷歌，搜到的portus一般都是compose形式搭建，这样好处是操作无脑

但是一般情况下我们肯定是自己要更灵活一些的，肯定用docker容器形式更舒服一点。可是去dockerhub一搜，各种版本的镜像，查看dockerfile很多人都自己加了一些内容，对于不会ruby的人来说，并不知道那些操作都说干啥的。

### 自己研究研究

github master分支上有dockerfile，如下
```
FROM library/rails:4.2.2
MAINTAINER Flavio Castelli <fcastelli@suse.com>

ENV COMPOSE=1
EXPOSE 3000

WORKDIR /portus
COPY Gemfile* ./
RUN bundle install --retry=3

# Install phantomjs, this is required for testing and development purposes
# There are no official deb packages for it, hence we built it inside of the
# open build service.
RUN echo "deb http://download.opensuse.org/repositories/home:/flavio_castelli:/phantomjs/Debian_8.0/ ./" >> /etc/apt/sources.list
RUN wget http://download.opensuse.org/repositories/home:/flavio_castelli:/phantomjs/Debian_8.0/Release.key && \
  apt-key add Release.key && \
  rm Release.key
RUN apt-get update && \
    apt-get install -y --no-install-recommends phantomjs && \
    rm -rf /var/lib/apt/lists/*

ADD . .
```

于是直接用那个dockerfile直接build一个镜像。参考别人给出的一些docker run参数启动，并成功了。

```
docker run -d -e RAILS_ENV=production \
	-e RACK_ENV=production \
	-e PORTUS_SECRET_KEY_BASE=secret-goes-here \
	-e PORTUS_KEY_PATH=/certs/server-key.pem \
	-e PORTUS_PASSWORD=portuspw \
	-e PORTUS_CHECK_SSL_USAGE_ENABLED=false \
	-e PORTUS_MACHINE_FQDN_VALUE=192.168.56.101 \
	-e PORTUS_PRODUCTION_HOST=192.168.56.101 \
	-e PORTUS_PRODUCTION_USERNAME=portus \
	-e PORTUS_PRODUCTION_PASSWORD=portus \
	-e PORTUS_PRODUCTION_DATABASE=portus \
	-v /sslkeys:/certs \
	-v /root/terminal/Portus/:/portus \
	--restart=always \
	-p 5001:3000 portus:v1 puma -b tcp://0.0.0.0:3000 -w 3
```

解释一下这些参数

* PORTUS_SECRET_KEY_BASE 是rails 4.0以后出的一个web安全参数，一般要rake secret生成一个很长很长的随机串，发现随意写个串也无妨。
* PORTUS_KEY_PATH 猜测是对应registry给出那个crt的。
* PORTUS_PASSWORD 这个参数有意思。在你创建好portus后，需要创建一个用户叫 portus。密码就是这个密码。这个用户的目的是为了同步镜像用的。（之后说）
* PORTUS_CHECK_SSL_USAGE_ENABLED 因为我没有官方签发证书，所以用http，如果https，在registry的notifications时候会发不过去。
* PORTUS_MACHINE_FQDN_VALUE 就是你的portus要配置的域名。
* PORTUS_PRODUCTION_HOST，PORTUS_PRODUCTION_USERNAME，PORTUS_PRODUCTION_PASSWORD，PORTUS_PRODUCTION_DATABASE这几个就是数据库的地址，帐号，密码，数据库
* puma -b tcp://0.0.0.0:3000 -w 3 是执行的CMD，试了一下，这个镜像默认是什么都不执行的，所以启动可以添加这个命令，如果不想每次加可以在dockerfile里加上CMD.

### 简化一下

显然，如上启动方式跟了一大堆参数是很烦的，也不是你想的。当然那就把它们放到配置文件里。

主要有三个配置文件都放在了 Portus/config 文件夹下。分别为 config.yml, database.yml, secrets.yml

将几个env变量都可以配置到文件的production里。

值得注意的是，PORTUS_MACHINE_FQDN_VALUE这个变量在2.0.3版本里是放在了secrets.yml 里，但是如果你用的是portus的master分支，最新的代码是放在config.yml里的。一坑。

所以启动方式可以改成：

```
docker run -d \
	-e RAILS_ENV=production \
	-e RACK_ENV=production \
	-v /sslkeys:/certs \
	-v /root/terminal/Portus/:/portus \
	-p 5001:3000 \
	--restart=always \
	portus:v1 puma -b tcp://0.0.0.0:3000 -w 3
```

不同版本有的参数配置不太一样，参数调整好以后就可以出现登录页面了。就可以开始操作了。

### 镜像同步

两种方法： 一段时间同步一次。每次push操作更新一次。

* 一段时间同步一次

在我们登录以后，点击admin选项，会出现红色提示，user portus not exist。这时候你可以先创建portus用户，密码为secrets.yml里填写的密码。这个用户的作用就是同步时候用这个用户当做默认用户同步。

我们在容器里路径为 /Portus 运行 `RAILS_ENV=production CATALOG_CRON="60.seconds" bundle exec crono` 他就会每隔60秒，用用户portus请求一次registry的 /v2/_catalog这个api查阅所有镜像。我们查看portus 容器日志会收到这个用户发来的请求。

如果你发现同步失败，请检查是否给了portus admin权限，只有admin权限portus才可以访问所有镜像。

如果想让这个作为单独容器来同步，可以将命令写成个脚本放到portus镜像里 /crono.sh。然后启动容器时候把命令改成 ./crono.sh就行。

* 每次push请求一次

就是registry 里配置了 notifications，每次push会来向notifications配置的地址发请求。portus server收到请求后来更改数据库。



### 问题

1. 本地配置好以后，想试试域名访问有没有问题，结果改成域名以后一直401。

	后来突然想到，在登录第一次就配置了regitry server信息。应该是这个server名字改变了，所以拒绝了访问。

	修复方法： 直接到数据库的registry表将地址改成域名就行。
2. 2.0.3版本可以登录，但是还是401. 应该是rails的不同版本的bundle不一样吧，没找解决办法。还是直接改回了master版本。
