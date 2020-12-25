---
title: Java SpringBoot基础入门
top: false
comments: true
categories:
  - java
tags:
  - java
  - spring boot
abbrlink: aec98d42
date: 2020-12-18 13:34:13
---

> 又是学新东西的时间啦！！！！  我好好好难顶！！！

<!--more-->

## 一： 介绍

![](http://photo.jomeswang.top/20201218140613.png)



 Spring Boot使编码变简单

Spring Boot使配置变简单

Spring Boot使监控变简单

Spring Boot使部署变简单

![](http://photo.jomeswang.top/20201219214623.png)

## 二：框架解析

![](http://photo.jomeswang.top/20201218144535.png)

### 2.1 RestFul 框架的设置

#### 2.1.1	RestFul 的含义

http://www.ruanyifeng.com/blog/2018/10/restful-api-best-practices.html

#### 2.1.2  Javaspring的 路由配置

```
在路由类上加上 
@RestController
注解

在 实现函数中加上一个实现路由函数
@GetMapping(value = "/")
    public String hello(){
        return "Hello world";
    }
```



### 2.2  与数据库的交互

#### 2.2.1      使用  JPA 和 Mysql 建立一个数据库的连接

安装JPA 插件和 Mysql 驱动

继而在 application.yml 中配置文件

![](http://photo.jomeswang.top/20201219215442.png)



#### 2.2.2	继而在domain 中定义一个 User 类， 在这一个类中 定义数据库中表有的字段。

![](http://photo.jomeswang.top/20201219220725.png)



#### 2.2.3 在 repository 层中定义 数据库操作方法

![](http://photo.jomeswang.top/20201219222425.png)



#### 2.2.3	继而在service 层中写 数据操作

![](http://photo.jomeswang.top/20201219220838.png)

![](http://photo.jomeswang.top/20201219222256.png)



仓库地址： https://github.com/jomeswang/SpringBootLearning

