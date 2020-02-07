---
title: Vue 中 点击事件补充.native
top: false
comments: false
categories:
  - vue
tags:
  - vue
  - Element
abbrlink: e140343d
date: 2020-02-07 17:45:15
---

## 一：前言

​	发现vue中加载Element 之后 键盘事件无效果搜索之后发现有BUG特来修复

<!-- more -->

## 二：步骤

发现Element-input 中加入@keyup.enter中无效果

```
 <el-input style="width:500px;" placeholder="请输入查询城市" v-model="location" clearable @keyup.enter="goSearch" ></el-input>
```

之后在加入.native 的修饰符

```
<el-input style="width:500px;" placeholder="请输入查询城市" v-model="location" clearable @keyup.enter.native="goSearch" ></el-input>
```

​    官网的解释：

> ​			 你可能想在某个组件的根元素上监听一个原生事件。可以使用 `v-on` 的修饰符 .native 。 

​    通俗点讲：就是在父组件中给子组件绑定一个原生的事件，就将子组件变成了普通的HTML标签，不加'. native'事件是无法触 发的。 

 可以理解为该修饰符的作用就是把一个vue组件转化为一个普通的HTML标签，并且该修饰符对普通HTML标签是没有任何作用的。 