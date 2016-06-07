+++
date = "2016-06-01T19:19:58+08:00"
description = "在实例方法内修改实例地址"
highlight = true
index = true
categories = ["golang","pointer"]
title = "golang: change instance address in his method"

+++

### 前提回顾

对于结构体中的指针应用，大部分可能知道的是如下两代码的区别

`func (a *AA) funcA()`

`func (a AA) funcB()`

区别在于，我们在funcA内修改a的值，是可以成功的，但是在funcB修改a的值是失败的。

因为funcA中的a是指针传递，funcB中的a是值传递。这个大家都知道。

### 今天话题

先上代码
```
package main

import (
	"fmt"
)

type AA struct {
	xyz string
	opq string
}

func (this *AA) Change() {
	b := &AA{xyz: "xyz1", opq: "opq1"}
	this = b
	fmt.Println("in this:", this, "addr:", &this)
}

func main() {
	a := &AA{xyz: "xyz0", opq: "opq0"}
	fmt.Println("before a:", a, "addr:", &a)

	a.Change()

	fmt.Println("after a:", a, "addr:", &a)
}

```

那么问题来了，请回答一下程序执行过程的三个输出是什么。

### 一开始的想法

开始简单认为Change方法是指针传递，那么在里面修改了实例的地址，应该是可以实现的，所以 

`output1 != output2 == output3`

### 肯定和预想不一样

结果图片如下

![ ](/img/chang_addr.png)

结果： `output1  == output3 != output2`


### 为什么？

面向对象的编程，在编译的时候，会将类的方法进行一下转换，类似如下：

A.f() 会转换成 Object.f(A)

而转换后的函数方法，也分值传递和指针传递。而这时候是值传递，导致你无论怎么修改A的地址，在函数外面都不会改变。

### 再清晰一点

可以思考一下堆栈的分配。

![ ](/img/chang_addr_pic1.png)

手拙，用excel画了个堆栈图

在执行Chang()时，会生成变量this，这个变量this里存的就是传进来值的地址，main函数里的a变量里存的也是这个地址。
所以修改值得时候，两边是互通的。

但是，我们Chang()函数是修改的this的值，也就是将 `0xffffff04(this) -> 0xffffff00 (a_value) ` 改成了 `0xffffff04(this) -> 0xffffff10(b_value)`  可是在main函数里面a的值还是没有变。所以output3，还是a指向的地址里的值。





