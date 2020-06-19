---
title: uni-app 入手体验
top: false
comments: true
categories:
  - 小程序
tags:
  - 小程序
abbrlink: 35c7bc4b
date: 2020-06-16 22:12:10
---

> `uni-app` 是一个使用 [Vue.js](https://vuejs.org/) 开发所有前端应用的框架，开发者编写一套代码，可发布到iOS、Android、H5、以及各种小程序（微信/支付宝/百度/头条/QQ/钉钉/淘宝）、快应用等多个平台。

<!--more-->

## 一： 开发准备

### 1.1   编译工具

HBuilderX: https://www.dcloud.io/hbuilderx.html

微信小程序开发工具： https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html

### 1.2  环境配置

1. 打开微信开发者工具>设置>安全设置>打开服务端口

![](http://photo.jomeswang.top/20200619150350.png)

2. HBuilderX>运行>小程序模拟器>运行设置>设置微信小程序开发工具路径

### 1.3   开发文档

uni-app 开发文档：

微信小程序开发文档：https://developers.weixin.qq.com/miniprogram/dev/framework/quickstart/

## 二：入门

### 2.1    创建项目初始uni-app 

打开HBuilderX 新建uni-app 项目

![](http://photo.jomeswang.top/20200619150728.png)

打开之后看到目录，现在我们来看看目录有什么呢？

![](http://photo.jomeswang.top/20200619150948.png)



### 2.2  表达式测试

![](http://photo.jomeswang.top/20200619153816.png)



### 2.3 属性绑定

![](http://photo.jomeswang.top/20200619154624.png)



### 2.4  方法调用

![](http://photo.jomeswang.top/20200619155111.png)



### 2.5   常用指令

![](http://photo.jomeswang.top/20200619160958.png)



### 2.6    常用生命周期

#### 2.6.1    应用生命周期

| 函数名            | 说明                                                         |
| :---------------- | :----------------------------------------------------------- |
| onLaunch          | 当`uni-app` 初始化完成时触发（全局只触发一次）传入一个option，里面可以获取场景值 |
| onShow            | 当 `uni-app` 启动，或从后台进入前台显示，传入一个option，里面可以获取场景值 |
| onHide            | 当 `uni-app` 从前台进入后台                                  |
| onUniNViewMessage | 对 `nvue` 页面发送的数据进行监听，可参考 [nvue 向 vue 通讯](https://uniapp.dcloud.net.cn/use-weex?id=nvue-向-vue-通讯) |

**注意**

- 应用生命周期仅可在`App.vue`中监听，在其它页面监听无效。
- onlaunch里进行页面跳转，如遇白屏报错，请参考https://ask.dcloud.net.cn/article/35942

例子：

```js
	onShow: function(option) {
			console.log('App Show');
			 console.log(option);
		},
```



#### 2.6.2 分页生命周期

![](http://photo.jomeswang.top/20200619162326.png)



#### 2.6.3 组件生命周期

![](http://photo.jomeswang.top/20200619162402.png)



### 2.7   路由跳转

![](http://photo.jomeswang.top/20200619162910.png)

例子：写在方法里

```
		/*
				非tabbar配置的页面我们使用 navigateTo
				跳转时保留老页面,一般用于需要返回
				 */
				 uni.navigateTo({
					url:"../one/one"
				})
				
				
				/* 跳转pages.json>tabbar>配置过的页面,使用 switchTab
				uni.switchTab({
					url:"../news/news"
				}) */
```



### 2.8 视图容器

![](http://photo.jomeswang.top/20200619213842.png)



### 2.9   节点操作

![](http://photo.jomeswang.top/20200619213931.png)



### 2.10  网络请求![](http://photo.jomeswang.top/20200619215225.png)

```
uni.request({
    url: 'https://www.example.com/request',
    success: (res) => {
        console.log(res.data);
    }
});
```

### 2.11  扩展组件

![](http://photo.jomeswang.top/20200619215321.png)



### 2.12 vuex 组件数据管理

uni- app 中已经有vuex 组件了。

![](http://photo.jomeswang.top/20200619220948.png)

在根目录下的main.js 中加入以下代码

```
import store from './store'
Vue.prototype.$store=store;
```



在根目录下创建一个store文件夹，放入一个index.js 文件，里面写vuex配置

```
import Vue from 'vue'
import Vuex from "vuex"
Vue.use(Vuex)
export default new Vuex.Store({
	// 全局属性变量
	state:{
		num:0,
		price:10,
		name:'苹果',
		testList:[]
	},
	// 全局同步方法, 调用方法,this.$store.commit("xxx")
	mutations:{
		add(state){
			state.num++;
		}
	},
	//Vuex属性计算,在视图里面当变量使用
	getters:{
		count(state){
			//这个函数的执行依赖一个可变的变量
			return state.num*state.price;
		}
	},
	//异步方法 调用方法,this.$store.dispatch("xxx") 
	actions:{
		testActions(context){
			// context里面包含了 state,mutations,getters,actions
			// console.log(context)
			// 执行一些异步参数,通用ajax
			setTimeout(()=>{
				context.state.testList=["猪猪侠","超人强","喜洋洋","老村长"]
			}, 2000);
		}
	}
	
})

```

