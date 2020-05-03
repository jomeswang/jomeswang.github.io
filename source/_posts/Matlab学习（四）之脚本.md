---
title: Matlab学习（四）之脚本
top: false
comments: true
categories:
  - Matlab
tags:
  - Matlab
  - Matlab学习特辑
abbrlink: 5c742b42
date: 2020-05-02 20:28:31
---

## 一： 前言

本章主要来介绍一下什么是脚本文件，如何编写脚本文件，以及Matlab的基本运算和控制结构

<!--more-->

## 二：主要内容

### 2.1 什么是脚本以及如何创建

> 利用 Matlab 的程序控制功能，将相关 Matlab 命令编成程序存储在一个文件中（M 文件），然后在命令窗口中运行该文件，Matlab 就会自动依次执行文件中的命令，直到全部命令执行完毕
>
> M 文件以 .m 为扩展名

创建文件：点击主页新建脚本文件，记得还要设置路径。

![](http://photo.jomeswang.top/20200502214123.png)

运行文件：可以直接点开运行，也可以先打开文件再在编辑器选项卡中点击运行。

![](http://photo.jomeswang.top/20200502214341.png)

### 2.2  基本运算

> 算术，关系，逻辑

1. 关系运算符

| **<**  | **小于** | **<=** | **小于等于** |
| ------ | -------- | ------ | ------------ |
| **>**  | **大于** | **>=** | **大于等于** |
| **==** | **等于** | **~=** | **不等于**   |

比较大小，如果结论是 真 则返回 1 ，否则返回 0

2. 逻辑运算

| **&**        | **与** (**Elementwise** **AND)** |
| ------------ | -------------------------------- |
| **\|**       | **或** (**Elementwise** **OR)**  |
| **~**        | **非**                           |
| **xor(x,y)** | **异或**                         |

| **&&**   | **与** (Short-circuit AND) |
| -------- | -------------------------- |
| **\|\|** | **或 (Short-circuitOR)**   |

逻辑运算函数：

![](http://photo.jomeswang.top/20200502215354.png)

![](http://photo.jomeswang.top/20200502215413.png)

3. 运算优先级

![](http://photo.jomeswang.top/20200502215626.png)

### 2.3 数据输入和输出

1. c = input('提示信息')

其中 提示信息 为字符串，
 该命令要求用户输入 A 的值 (可以是数或字符串)

> 输入字符串时必须带单引号
>  单引号的输出：两个连续的单引号

2. 数据的输出：

    disp(X)

>  输出变量 X 的值，X 可以是数值、矩阵或字符串
>  一次只能输出一个变量
>  复杂的输出必须用合并的方式实现

复合输出disp(['You have ',num2str(n), ' apples.'])

​	数据的格式化输出：fprintf

​	fprintf(fid,format,variables)

![](http://photo.jomeswang.top/20200502221243.png)

![](http://photo.jomeswang.top/20200502221322.png)

### 2.4 控制结构

1. 顺序结构

2. 选择结构（if switch）

   **If 语句**

   ![](http://photo.jomeswang.top/20200502222812.png)

   **switch 语句**

   ![](http://photo.jomeswang.top/20200502222914.png)

3. 循环结构

   **for 循环**

   ![](http://photo.jomeswang.top/20200502223418.png)

   例子：

   ![](http://photo.jomeswang.top/20200502223459.png)

   **while 循环**

   ![](http://photo.jomeswang.top/20200502223820.png)

### 2.5 其他控制语句

1.  break 和 continue

    break 语句用于终止循环的执行，即跳出最内层循环 
    continue 语句用于结束本次循环，进行下一次循环 
    break 和 continue 一般与 if 语句配合使用

2.  return

    return 语句用于退出正在运行的脚本或函数，通常用在函数文件中

