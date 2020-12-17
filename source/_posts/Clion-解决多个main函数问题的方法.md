---
title: Clion 解决多个main函数问题的方法
top: false
comments: true
categories:
  - C++
tags:
  - C++
abbrlink: 5a256d9b
date: 2020-09-21 22:35:38
---

> 开始可以愉快的刷题喽

<!--more-->

使用CLion 刷题解决多个main函数问题的终极方法
在写 C++ 的题目的时候经常会遇到这样的问题，写了多个 cpp 文件，在 clion 中编译报错不能同时存在多 main 函数。

方法3:在CMake文件中编写自动生成程序
在Cmake文件中编写程序，自动生成编译后的文件名！

基础版：
```
# 遍历项目根目录下所有的 .cpp 文件
file (GLOB files *.cpp)
foreach (file ${files})
string(REGEX REPLACE ".+/(.+)\\..*" "\\1" exe ${file})
add_executable (${exe} ${file})
message (\ \ \ \ --\ src/${exe}.cpp\ will\ be\ compiled\ to\ bin/${exe})
endforeach ()
```

上边儿这段代码，只会遍历根目录下的cpp文件，不会遍历根目录下的二级目录。



进阶版：
```
# 遍历项目根目录及二级目录下所有的 .cpp 文件
file (GLOB files *.cpp */*cpp)
foreach (file ${files})
string(REGEX REPLACE ".+/(.+)\\..*" "\\1" exe ${file})
add_executable (${exe} ${file})
message (\ \ \ \ --\ src/${exe}.cpp\ will\ be\ compiled\ to\ bin/${exe})
endforeach ()
```

进阶版就是手动添加访问二级目录的规则，同样要访问三级目录就是再添加一个*/*/*.cpp



最优版：
官方文档提供一个解决方法GLOB_RECURSE，它会自动遍历工程文件根目录下的所有文件目录。

```
# 遍历项目根目录下所有的 .cpp 文件

file (GLOB_RECURSE files *.cpp)
foreach (file ${files})
string(REGEX REPLACE ".+/(.+)\\..*" "\\1" exe ${file})
add_executable (${exe} ${file})
message (\ \ \ \ --\ src/${exe}.cpp\ will\ be\ compiled\ to\ bin/${exe})
endforeach ()
```

优点：方便省时

缺点：这种方法要求所有cpp文件命名不重复，不能含有中文，不能含有‘/’等字符！因为它就是直接Copy你的源码文件名的。