---
title: vue 兄弟组件传值
top: false
comments: false
categories:
  - vue
tags:
  - vue
abbrlink: 90831fd6
date: 2020-08-11 18:06:11
---

在vue开发中总会遇到组件传值问题，今天总结一下兄弟组件之间的传值方法。

<!--more-->

1、子传父，父传子

2、vuex

3、eventBus

接下来介绍如何使用eventBus实现兄弟组件传值

首先我的需求是这样的，页面上由top，left，main，bottom四个组件构成。需要将top中的值传到left中。

![img](https://img2018.cnblogs.com/blog/1630583/201908/1630583-20190812154020531-1961842869.png)

第一步：创建一个js文件，eventBus.js，位置随便放，我是放在了src目录下

```
import Vue from 'vue'
export default new Vue()
```

第二步：在top组件中，引入刚才的js

```
import '@/eventBus.js' 
```

然后在methods里边定义一个函数

```
methods:{
    changesize(){
        eventBus.$emit('add',this.arg)
    }
}
```

我测试用的是button点击触发changesize函数，然后将arg传出去

第三步：在left组件中也先让引入eventBus.js，然后使用created生命周期函数

```
created(){
    eventBus.$on('add',(message)=>{
        //一些操作，message就是从top组件传过来的值
        console.log(message)
    })
},
```

