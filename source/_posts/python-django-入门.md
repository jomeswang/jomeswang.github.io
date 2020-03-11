---
title: python django 入门
top: false
comments: true
categories:
  - python_django
tags:
  - python
  - django
abbrlink: 4d06c6c3
date: 2020-03-08 23:25:21
---

## 一：前言

使用Django框架进行web开发，方便管理后端与数据库。先介绍一下web框架的MVC和Django的 MVT 框架。

<!-- more -->

## 二：基本介绍

#### 软件框架

问题1:什么是软件框架？

举个简单的例子，对于一个公司来说，公司中有各个职能部门，每个部门各司其职，通过部门之间的配合来完成工作，这些部门就形成了一个公司的组织架构。从某种意义上来说，公司就是一种框架。那么对应到软件设计上来说，软件框架是由其中的各个模块组成的，每个模块负责特定的功能，模块与模块之间相互协作来完成软件开发。

一个公司，它是针对某一市场而成立的，而软件框架的设计，也是针对某一类软件问题而设计的，其目的主要是提高软件开发效率。

#### MVC简介

MVC的全拼为Model-View-Controller，最早由TrygveReenskaug在1978年提出，是施乐帕罗奥多研究中心(Xerox PARC)在20世纪80年代为程序语言Smalltalk发明的一种软件设计模式，是为了将传统的输入（input）、处理（processing）、输出（output）任务运用到图形化用户交互模型中而设计的。随着标准输入输出设备的出现，开发人员只需要将精力集中在业务逻辑的分析与实现上。后来被推荐为Oracle旗下Sun公司Java EE平台的设计模式，并且受到越来越多的使用ColdFusion和PHP的开发者的欢迎。现在虽然不再使用原来的分工方式，但是这种**分工的思想**被沿用下来，广泛应用于软件工程中，是一种典型并且应用广泛的软件架构模式。后来，MVC的思想被应用在了Ｗeb开发方面，被称为Ｗeb MVC框架。

MVC框架的核心思想是：**解耦**，让不同的代码块之间降低耦合，增强代码的可扩展性和可移植性，实现向后兼容。

当前主流的开发语言如Java、PHP、Python中都有MVC框架。

#### Ｗeb MVC各部分的功能

M全拼为Model，主要封装对数据库层的访问，对数据库中的数据进行增、删、改、查操作。

V全拼为View，用于封装结果，生成页面展示的html内容。

C全拼为Controller，用于接收请求，处理业务逻辑，与Model和View交互，返回结果。

[![3zjAPA.png](https://s2.ax1x.com/2020/03/08/3zjAPA.png)](https://imgchr.com/i/3zjAPA)

#### Django简介

Django，发音为[`dʒæŋɡəʊ]，是用python语言写的开源web开发框架，并遵循MVC设计。劳伦斯出版集团为了开发以新闻内容为主的网站，而开发出来了这个框架，于2005年7月在BSD许可证下发布。这个名称来源于比利时的爵士音乐家DjangoReinhardt，他是一个吉普赛人，主要以演奏吉它为主，还演奏过小提琴等。由于Django在近年来的迅速发展，应用越来越广泛，被著名IT开发杂志SDTimes评选为2013SDTimes100，位列"API、库和框架"分类第6位，被认为是该领域的佼佼者。Django的主要目的是简便、快速的开发数据库驱动的网站。它强调代码复用，多个组件可以很方便的以"插件"形式服务于整个框架，Django有许多功能强大的第三方插件，你甚至可以很方便的开发出自己的工具包。这使得Django具有很强的可扩展性。它还强调快速开发和DRY(DoNotRepeatYourself)原则。

> 点击查看[django官方网站](https://www.djangoproject.com/)
> 点击查看[django源码](https://github.com/django/django)
> 点击查看[1.8.2官方中文文档](http://python.usyiyi.cn/django/index.html)

Django框架遵循MVC设计，并且有一个专有名词：MVT

#### MVT各部分的功能

M全拼为Model，与MVC中的M功能相同，负责和数据库交互，进行数据处理。

V全拼为View，与MVC中的C功能相同，接收请求，进行业务处理，返回应答。

T全拼为Template，与MVC中的V功能相同，负责封装构造要返回的html。

- 差异就在于黑线黑箭头标识出来的部分

[![3zjF5d.png](https://s2.ax1x.com/2020/03/08/3zjF5d.png)](https://imgchr.com/i/3zjF5d)

