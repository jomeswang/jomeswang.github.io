---
title: vue 使用的vue-resources 发起jsonp请求
top: false
comments: true
categories:
  - vue
tags:
  - vue
  - vue-resources
  - jsonp
abbrlink: d6888797
date: 2020-02-18 18:30:12
---

 **1. yarn add vue-resource** 

<!-- more -->

 **2. main.js引入vue-resource** 

```
import VueResource from 'vue-resource'
Vue.use(VueResource)
```

**3.使用**

```
 //引入vue-resource之后, 相当于在vue实例(this)身上新增了一些方法或对象(如:$http)
   this.$http.jsonp('https://sp0.baidu.com/5a1Fazu8AA54nxGko9WTAnF6hhy/su', 
   //jsonp参数一: 跨域请求接口;
   {
    //jsonp交互走的是get形式(不是post), 传递参数用params
    params:{  
     wd:'a'
    },
    //接口的callback名字, vue默认名字为"callback"
    jsonp:'cb' 
   },)
   //jsonp参数二: 传到的params和callback类型
   .then(function(res){ 
    alert(res.data.s);
   },function(res){
    alert(res.status);
   });
  }

 
 //固定形式: jsonp('',{params{},jsonp:'cb'}).then(function(){'成功'},function(){'失败'});
```

