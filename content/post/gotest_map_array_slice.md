+++
author = "qwding"
categories = ["golang","map","slice","array","testing","benchmark"]
date = "2016-06-27T14:28:44+08:00"
description = "golang testing about iterating map,slice,array."
featured = ""
featuredpath = ""
linktitle = ""
title = "go map,slice,array 遍历性能测试 "

+++

# #就是随便试试

听说goalng的map和slice的遍历性能差的不是一点半点，于是没事写个benchmark来玩玩
代码
```
package testings

import(
	"testing"
	"strconv"
)

var length = 1000
var maps map[string]string
var slices []string
var arrays [1000]string

func init(){
	maps = make(map[string]string,length)
	slices = make([]string,length)
	for i:=0;i<length;i++{
		maps[strconv.Itoa(i)] = "abc"
		slices[i] = "abc"
		arrays[i] = "abc"
	}

}


func BenchmarkIterateMap(b *testing.B){
	for i:=0;i<b.N;i++{
		for _,_ = range maps{
		}
	}
}

func BenchmarkIterateSlices(b *testing.B){
	for i:=0;i<b.N;i++{
		for _,_ = range slices{
		}
	}
}

func BenchmarkIterateArrays(b *testing.B){
	for i:=0;i<b.N;i++{
		for _,_ = range arrays{
		}
	}
}

func BenchmarkIterateMapF(b *testing.B){
	for i:=0;i<b.N;i++{
		for _,k := range maps{
			_ = k
		}
	}
}

func BenchmarkIterateSlicesF(b *testing.B){
	for i:=0;i<b.N;i++{
		for _,k := range slices{
			_ = k
		}
	}
}

func BenchmarkIterateArraysF(b *testing.B){
	for i:=0;i<b.N;i++{
		for _,k := range arrays{
			_ = k
		}
	}
}

func BenchmarkIterateSlicesFor(b *testing.B){
	for i:=0;i<b.N;i++{
		for j:=0;j<length;j++{
			_ = slices[j]
		}
	}
}

func BenchmarkIterateArraysFor(b *testing.B){
	for i:=0;i<b.N;i++{
		for j:=0;j<length;j++{
			_= arrays[j]
		}
	}
}
```

### #测试结果

```
➜  testings git:(master) ✗ go test -bench=. iterate_map_vs_slice_vs_array_test.go
testing: warning: no tests to run
PASS
BenchmarkIterateMap-4      	  100000	     20544 ns/op
BenchmarkIterateSlices-4   	 5000000	       368 ns/op
BenchmarkIterateArrays-4   	 5000000	       371 ns/op
BenchmarkIterateMapF-4     	  100000	     21685 ns/op
BenchmarkIterateSlicesF-4  	 2000000	       812 ns/op
BenchmarkIterateArraysF-4  	 1000000	      1036 ns/op
BenchmarkIterateSlicesFor-4	 1000000	      1199 ns/op
BenchmarkIterateArraysFor-4	 1000000	      1024 ns/op
ok  	command-line-arguments	14.858s
```

### #看数据
* 先看前面三个方法，只是遍历，没有应用数据，大小都是1000，map 居然是slice和array的57倍之多。
* 接下来三个方法是应用到了数据，map性能损耗基本没有增多多少，但是slice和array却增多一倍多（还不了解为什么）
* 后面两个表明 array的按index取和range取性能不变，但是slice是有差距的。

### #数据不是固定的
将slice和map的大小分布调成10，100，1000，10000，得出的性能比，map/slice是不固定的，也没有发现什么规律(测试不够充分)，但是一般都在将近30倍以上。但是可以得出遍历性能确实差很多。

### #slice 不同情况性能差距也比较大

### #遗留问题 
* slice 为什么只遍历和取到数据还有一倍多的性能损耗
* slice 的index取数和range取数性能也有差距


