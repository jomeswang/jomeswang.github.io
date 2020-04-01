---
title: hexo博客本地搜索失效，一直转圈
comment: true
tags:
  - hexo
abbrlink: ca3d1d6d
date: 2020-03-29 14:45:02
---

### 关于 Hexo 的 Local Search 失效的问题

> 问题描述:

你会发现一开始你的Blog搜索功能还是正常的，搜索出结果一直在转圈圈等待，或者 搜索功能能搜索但是不能跳转过去，随着添加了几篇文章以后，搜索就不正常了，访问你的博客 `http://你的博客域名/search.xml` 的时候，提示有存在不可解析的字节的错误，大致如下：

<!-- more -->

```
This page contains the following errors:error on line 66 at column 35: Input is not proper UTF-8, indicate encoding !Bytes: 0x08 0xE8 0xAF 0x84Below is a rendering of the page up to the first error.
```

此时，是因为你的xml解析有问题，换成json来解析即可，编辑你的站点配置文件 `_config.yml`

找到搜索的地方 把 Search的xml解析改成json解析，具体改完后 如下：

```
search:  path: search.json  field: post  format: html  limit: 10000
```

完美解决搜索问题。