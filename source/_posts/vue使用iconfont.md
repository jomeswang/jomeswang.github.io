---
title: vue使用iconfont
top: false
comments: false
categories:
  - 前端
tags:
  - vue
  - iconfont
abbrlink: ec166c64
date: 2020-02-17 13:49:16
---

## 一：前言

最近在写导航面板（vue-cli）中需要使用到Icon，于是采取了使用阿里的iconfont写这篇文章来记录一下

<!-- more -->

## 二：步骤

### 2.1 挑选需要的icon添加到购物车中

官网： https://www.iconfont.cn/ 

挑选完后在购物车处点击添加到项目。

如果选择多色，就选择`Symbol`模式，如果是单色模式就选择Unicode或Font class 模式。在这里只介绍Symlol的使用，另外两种可类似可得。[官网使用方法](https://www.iconfont.cn/help/detail?spm=a313x.7781069.1998910419.d8cf4382a&helptype=code)  

### 2.2在文件中引入

首先下载好文件，将其放入`createtoolbox\src\assets\icon`再在main.js中引入

```
import '@/assets/icon/iconfont.js'
```

再在App.vue 中引入样式

```
<style type="text/css">
    .icon {
       width: 1em; height: 1em;
       vertical-align: -0.15em;
       fill: currentColor;
       overflow: hidden;
    }
</style>
```

使用

```
<svg class="icon" aria-hidden="true">
    <use xlink:href="#icon-xxx"></use>
</svg>
```

### 2.3模块化Icon

在使用过程中觉得这样使用有点麻烦于是使用了将Icon模块化的想法

于是在components下创建了一个Icon.vue其中写入

```
<template>
  <svg class="icon" aria-hidden="true">
    <use :xlink:href="'#'+iconName"></use>
  </svg>
</template>

<script>
export default {
  props: {
    iconName: {
      type: String,
      required: true
    }
  },

}
</script>

<style>
.icon {
  width: 1em;
  height: 1em;
  vertical-align: -0.15em;
  fill: currentColor;
  overflow: hidden;
}
</style>
```

之后再在main.js 中注册全局组件

```
import Icon from '@/components/Icon'
Vue.component('Icon',Icon)
```

然后就可以在任意的地方使用了

```
<Icon iconName="icon-cl-tb"/>
```

参考文章： https://juejin.im/post/59bb864b5188257e7a427c09#heading-5 

