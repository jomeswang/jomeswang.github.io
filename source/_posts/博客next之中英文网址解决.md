---
title: 博客next之中英文网址解决
top: false
comments: true
categories:
  - 建站
tags:
  - hexo
  - next
abbrlink: d10b0ea
date: 2020-01-16 12:58:50
---

### 前言

> hexo的默认永久链接是在_config.yml里的配置permalink: :year/:month/:day/:title/。这种默认配置有个很不能接受的缺点，文件名为中文，会导致url链接里面出现中文。这次我来介绍一个比较方便好用的解决方案`hexo-abbrlink`插件。

<!-- more -->

```
npm install hexo-abbrlink --save
```

站点配置文件(_config.yml)里:

```css
permalink: post/:abbrlink.html
abbrlink:
  alg: crc32  # 算法：crc16(default) and crc32
  rep: hex    # 进制：dec(default) and hex
```

使用`hexo g` 会自动在你的文章中加上`abbrlink: fbf5310d`