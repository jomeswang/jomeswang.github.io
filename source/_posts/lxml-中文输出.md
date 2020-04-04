---
title: lxml 中文输出
top: false
comments: false
categories:
  - lxml
tags:
  - lxml
abbrlink: 3d441074
date: 2020-04-04 22:09:32
---

lxml 中文输出

<!-- more -->

```
# encoding=utf8
import requests
from lxml import etree

# url 是古诗文网的
url = 'https://so.gushiwen.org/guwen/Default.aspx?p=1&type=%e6%ad%a3%e5%8f%b2%e7%b1%bb'
html = requests.get(url)
print('该响应状态码:', html.status_code)
et = etree.HTML(html.content)
# tostring   转换为字符串输出，并设计编码
t = etree.tostring(et, encoding = "utf-8", pretty_print = True, method = "html")
print(t.decode('utf-8'))
```

