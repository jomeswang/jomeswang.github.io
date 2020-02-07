---
title: Vue 之 axios 篇
top: false
comments: false
categories:
  - vue
tags:
  - vue
  - axios
abbrlink: 9a5bfef8
date: 2020-02-07 12:17:10
---

### 一：前言

​    利用axios在vue中获取网络上的数据来进行交互。

<!-- more -->

## 二：步骤

### 	2.1下载导入

```
npm install --save axios vue-axios
```

### 2.2 文件导入

​	在`main.js`中引入

```
import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(VueAxios,axios)
```

## 三：使用方法

3.1语法

```
this.axios.get('url')
			//其中如果get中要查询参数可('url?key=xxx')或者('url?key='+this.xxx)
		.then( (response) => {} )   
			//then为指成功之后的回调，response为成功之后的数据
		.catch( (error) => {} )
			// catch 指请求出错的处理
```

