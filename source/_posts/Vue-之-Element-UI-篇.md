---
title: Vue 之 Element UI 篇
top: false
comments: true
categories:
  - vue
tags:
  - vue
  - Element
abbrlink: 71f0b98a
date: 2020-02-07 15:02:22
---

## 一：前言

鉴于vue的组件不好看，引入Element的组件库来优化组件。

## 二：步骤

### 2.1 下载安装

#### 2.1.1 npm安装

```
npm i element-ui -S
```

#### 2.1.2CDN安装

```
<!-- 引入样式 -->
<link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
<!-- 引入组件库 -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
```

### 2.2组件引入

在入口文件  `main.js` 中引入 

```
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);
```

