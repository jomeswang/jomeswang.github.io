---
title: vue 的跨域访问
top: false
comments: true
categories:
  - vue
tags:
  - vue
  - vue-jsonp
abbrlink: 860a051a
date: 2020-02-18 17:13:01
---

## 一：前言

最近在做一个项目的时候需要去请求资源，因此使用axios来get请求，但一直报跨域错误。

<!-- more -->

`Access to XMLHttpRequest at 'https://api.bing.com/qsonhs.aspx?type=cb&q=1' (redirected from 'http://api.bing.com/qsonhs.aspx?type=cb&q=1') from origin 'http://localhost:8080' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.`

发现axios是不支持跨域访问的，于是我找找找，终于找到了两种方法解决这个跨域问题。

运用vue-jsonp或vue-resources来发起jsonp请求。进行跨域访问。这一篇先介绍vue-jsonp的使用。

## 二：解决方案

### 2.1vue-jsonp的安装和引入

详情可看[官网](https://github.com/LancerComet/vue-jsonp#readme)

使用npm的用 `npm install vue-jsonp -save`

使用yarn 的可用 `yarn add vue-jsonp`

之后再vue-cli的入口文件  `main.js` 引入

```
import VueJsonp from 'vue-jsonp'
Vue.use(VueJsonp)
```

### 2.2 vue-jsonp的使用

在主页面中可以用  `Vue.jsonp(url,dataObj,timeout)`

在vue组件中可以用  `this.$jsonp(url, dataObj, timeout)` 

其中

+ url 指的是目标url

+ dataObj 指的是 要传递的数据参数对象 

+ timeout 请求多长时间之后认为请求失败

  

#### URL.

```
'/url?{callbackQuery}={callbackName}&...'
 
// Default:
'/url?callback=jsonp_RANDOM_STRING&...'
```

#### Assign callback query name.

（注意这一点）回调函数的回调查询名称默认是**“callback”**如果访问资源的名字不是callback的话要改成相对应的名字

举个例子 `[http://suggestion.baidu.com/su?wd=%E5%89%8D%E7%AB%AF&p=3&cb=window.bdsug.sug](http://suggestion.baidu.com/su?wd=前端&p=3&cb=window.bdsug.sug)` 这是百度提示词的访问url，它的查询名为cb，那么我们就要加上下面的那一句话。

```
this.$jsonp('/url', {
  callbackQuery: 'cb'  // Default: callback
})
 
// Then URL will be: '/url?cb=jsonp_aws84739ssu8e3'
```

#### Assign callback function name.

```
this.$jsonp('/url', {
  callbackName: 'jsonpFunc'
})
 
// Then URL will be: '/url?callback=jsonpFunc'
```

#### Example.

```
 // If you want to setup the global timeout, just:
Vue.use(VueJsonp, 5000)
// Now all requests will be expired after 5000ms.
 
// Use it in Vue Component.
const SomeComponent = Vue.extend({
  methods: {
    getData () {
      this.$jsonp('http://www.some-site.com/data', { name: 'MyName', age: 20 })
      .then(json => {
        // Success.
      }).catch(err => {
        // Failed.
      })
    }
  }
})
 
// Static Function.
// Request url will be 'http://www.some-site.com/data?name=MyName&age=20&cb=jsonpFunc'
Vue.jsonp('http://www.some-site.com/data', {
  name: 'MyName', age: 20, callbackQuery: 'cb', callbackName: 'jsonpFunc'
}).then(json => {
  // Success.
}).catch(err => {
  // Failed.
})
```

#### 总而言之使用就是

​	(注意回调函数的方式)

```
//访问地址'url?q=123'
this.$jsonp('url',{q: 123 })
	.then( ( response ) => { console.log(response) })
	.catch( (error) => { console.log(error)} )
```

