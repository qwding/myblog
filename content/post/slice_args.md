+++

date = "2016-10-09T19:19:58+08:00"
description = "golang slice怎么个半指针传递"
categories = ["slice","golang"]
title = "How golang slice Semi - pointer."

+++


### 起因
刷leetcode的77题时候，使用了递归方法，并且使用数组时候如下
```
result := make([][]int, 0, length+1)
recursive([]int{}, 1, n, k, result)
```
第一次使用了cap声明slice，这样的好处是append时候在length后添加数据，并且保证长度够，append时候不会重新申请地址

但是跑的时候发现，recursive()后，在返回到此段代码，居然什么都没有！result值没变。

# 什么？ slice不是传说的指针传递么？

# 先看下官方数组结构样子

![](/img/slice.png)

当然，一直知道数组是半指针，就是将数组的地址的值传进去。在函数里是改变不了指针的值，但是可以操作指针指向的数据，详细的google有很多

我想象的是这样：函数收到的是数组的头地址(就是图最上面的指针）,length和cap等数据，这样可以完全接管数组的操作了

但是上述起因里出现的问题却不是这样，到底是什么原因呢？于是写了测试代码

```
func main() {
	result := make([]int, 0, 10)
	addr := &result
	fmt.Println("result:", result, "addr:", unsafe.Pointer(addr))

	for i := 0; i < 10; i++ {
		functions(result)
		result = append(result, i)
		//appendData(result,i)
	}
	fmt.Println("result:", result, "addr:", unsafe.Pointer(addr))

}

func functions(arr []int) {
	addr := &arr
	if len(arr) > 0 {
		fmt.Println("arr:", arr, "addr:", unsafe.Pointer(addr), "arr 0 addr:", &arr[0])
	} else {
		fmt.Println("arr:", arr, "addr:", unsafe.Pointer(addr))
	}
}

func appendData(arr []int,data int){
	arr = append(arr,data)
}

```

输出结果：
```
result: [] addr: 0xc420012200
arr: [] addr: 0xc420012260
arr: [0] addr: 0xc4200122a0 arr 0 addr: 0xc4200140f0
arr: [0 1] addr: 0xc4200122e0 arr 0 addr: 0xc4200140f0
arr: [0 1 2] addr: 0xc420012320 arr 0 addr: 0xc4200140f0
arr: [0 1 2 3] addr: 0xc420012360 arr 0 addr: 0xc4200140f0
arr: [0 1 2 3 4] addr: 0xc4200123a0 arr 0 addr: 0xc4200140f0
arr: [0 1 2 3 4 5] addr: 0xc4200123e0 arr 0 addr: 0xc4200140f0
arr: [0 1 2 3 4 5 6] addr: 0xc420012420 arr 0 addr: 0xc4200140f0
arr: [0 1 2 3 4 5 6 7] addr: 0xc420012460 arr 0 addr: 0xc4200140f0
arr: [0 1 2 3 4 5 6 7 8] addr: 0xc4200124a0 arr 0 addr: 0xc4200140f0
result: [0 1 2 3 4 5 6 7 8 9] addr: 0xc420012200
```

# 居然发现 unsafe.Pointer(addr)的值是一直变的！但是&arr[0]是不变的！

我擦，看了完全想错了，应该是函数里重新创建了一个数组(unsafe.Pointer(addr)一直变说明)，但是把源数组的数据地址拿过来,这个新创建的数组来指向他(&arr[0]不变说明)

# 又测试在function里添加和删除数据，即代码中注释掉的地方去掉，发现返回到main里时是不生效的，所以说明最初猜想是错的。

### 修改
 有意思的是当我们修改原有的数据时候，是可以成功的，这就是因为数组元素指向的是原数组的地址，所以修改是生效的


### 妄下结论

数组在函数传递过程中，在函数里可以更改数组的值，但是不能增和删
