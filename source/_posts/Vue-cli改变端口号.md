---
title: Vue-cli改变端口号
top: false
comments: true
categories:
  - Vue-cli
tags:
  - vue
  - vue-cli
abbrlink: 669a8d4e
date: 2020-01-28 11:22:03
---

##  一：前言

​	发现有时`vue-cli`运行时端口会与其他应用的端口相冲突，因此改变默认端口

<!-- more -->

## 二：步骤

1. `package.json`文件下修改 --port 

```
"scripts": {
   "serve": "vue-cli-service serve --port 9001",
 }

```

2. `vue.config.js`文件下添加 （如果没有就在根目录下创建文件）

```
module.exports = {
  devServer: {
    port: 9001
  }
}
```

参考自[网上](https://blog.csdn.net/weixin_42259989/article/details/102368800)

如有侵权，请联系删除。