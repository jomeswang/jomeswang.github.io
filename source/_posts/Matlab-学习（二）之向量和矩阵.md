---
title: Matlab 学习(二)之向量和矩阵
top: false
comments: true
abbrlink: d856937a
date: 2020-04-19 19:06:34
categories:
- Matlab
tags:
- Matlab
- Matlab学习特辑
---

## 一：创建矩阵和向量

> 可以将向量当成一维数组，将矩阵看成多维数组

<!--more-->

### 1.1 直接输入

+  矩阵用方括号 “[ ]” 括起
+  矩阵同一行中的元素之间用 空格 或 逗号 分隔
+  矩阵行与行之间用 分号 分开
+  直接输入法中，分号可以用 回车 代替

![](http://photo.jomeswang.top/20200419214928.png)

### 1.2 使用特殊矩阵函数来构建

![](http://photo.jomeswang.top/20200419215304.png)

### 1.3 使用冒号运算符创建

`a : b : c`

产生一个由等差序列组成的向量：

+ a 是首项，b 是公差，c 确定最后一项；
+ 若 b = 1，则 b 和其前面的冒号可以省略（若省略步长默认值为1）

![](http://photo.jomeswang.top/20200419220012.png)

### 1.4 使用  linspace 函数构建向量

用法：linspace(x1,x2,N)

功能：linspace是Matlab中的均分计算指令，用于产生x1,x2之间的N点行线性的矢量。其中x1、x2、N分别为起始值、终止值、元素个数。若默认N，默认点数为100。

![](http://photo.jomeswang.top/20200419220445.png)

## 二：矩阵运算

### 2.1 提取矩阵部分元素

![](http://photo.jomeswang.top/20200419220830.png)

![](http://photo.jomeswang.top/20200419220915.png)

![](http://photo.jomeswang.top/20200419221033.png)

### 2.2矩阵的基本运算

`运算符` 

![](http://photo.jomeswang.top/20200419222203.png)

> 数组运算是指数组对应元素之间的运算,也称点运算。
>
> 矩阵的乘法、乘方和除法有特殊的数学含义，并不是数组对应元素的运算，所以数组乘法、乘方和除法的运算符前特别加了一个点。

1. #### 矩阵乘积

![](http://photo.jomeswang.top/20200419222751.png)

2. #### 矩阵除法

   ![](http://photo.jomeswang.top/20200419223725.png)

3. #### 矩阵的转置

   ![](http://photo.jomeswang.top/20200419224358.png)

    　　[共轭转置](https://www.baidu.com/s?wd=共轭转置&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao):矩阵有实数矩阵和复数矩阵.[转置矩阵](https://www.baidu.com/s?wd=转置矩阵&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao)仅仅是将矩阵的行与列对换,而[共轭转置](https://www.baidu.com/s?wd=共轭转置&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao)矩阵在将行与列对换后还要讲每个元zd素共轭一下.共轭你应该知道,就是将形如a+bi的数变成a-bi,实数的共轭是它本身.所以,实数矩阵版的[共轭转置](https://www.baidu.com/s?wd=共轭转置&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao)矩阵就是[转置矩阵](https://www.baidu.com/s?wd=转置矩阵&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao),复数矩阵的共轭转置矩阵就是上面所说的行列互换后每个元素权取共轭。 

4. #### 矩阵的旋转

   +  fliplr(A)   左右旋转
   +  flipud(A)   上下旋转
   +  rot90(A)   逆时针旋转 90 度；
   + rot90(A,k) 逆时针旋转 k×90 度

   ![](http://photo.jomeswang.top/20200419224750.png)

5. #### 查看矩阵的大小

   +  size(A)         返回矩阵 A 的行数和列数
   +  size(A,1)  返回矩阵 A 的行数
   +  size(A,2)  返回矩阵 A 的列
   +  length(x)  返回向量 X 的长度
   +  length(A)  等价于 max(size(A))

 ![](http://photo.jomeswang.top/20200419225333.png)

6. #### 矩阵的比较运算

   > , >=, <, <=, ==,~=, find(), all(), any()

+ find(A>8)   ％大于或等于8元素的下标  
+  all(A>8)   ％某列元素全大于或等于8时，相应元素为1，否则为0。
+ any(A>8)   ％某列元素中含有大于或等于8时，相应元素为1，否则为0。

![](http://photo.jomeswang.top/20200419225814.png)

7. #### 矩阵的逻辑运算

   ![](http://photo.jomeswang.top/20200419230017.png)

#### 8.特殊函数

![](http://photo.jomeswang.top/20200419233727.png)

![](http://photo.jomeswang.top/20200419233815.png)