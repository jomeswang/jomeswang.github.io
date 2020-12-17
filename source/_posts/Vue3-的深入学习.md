---
title: Vue3 的深入学习
top: false
comments: true
categories:
  - Vue3
tags:
  - Vue3
abbrlink: 83b6388e
date: 2020-10-18 13:45:11
---

> 继续学习，冲冲冲

<!--more-->

## 一： 项目搭建

以前我们搭建项目直接就vue-cli生成了,但是现在不同了，现在有两种方式：

### 1.1.尤大大推荐的vite

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/204851c7c93a4ab2930ae2fd228676df~tplv-k3u1fbpfcp-zoom-1.image)

优点：总结一个字，就是快！

- 不需要打包，冷启动服务器
- 即时热模块更换
- 按需编译,不会出现模块变多而热更新变慢的问题

缺点：安装插件的时候有时候会出现莫名其妙的报错...

> 提示：这里vue-router、vuex 都要自己安装，而且必须是4.0+，vite暂时自己玩玩就好，别用于公司项目，不然直接原地爆炸

```
$  npm init vite-app <project-name>
$  cd <project-name>
$  npm install
$  npm run dev
复制代码
```

### 2.1.传统的webpack

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d0fd35b2f48c47d197b3097680533712~tplv-k3u1fbpfcp-zoom-1.image)  

优缺点相信大家都知道，热更新是诟病，这里就不说了...

> 这里你要先看看你的vue-cli是不是最新版本

```
$  vue create <project-name>
$  vue add vue-next 
$  cd <project-name>
$  npm run serve
复制代码
```

## 二：结构变化

> 其实目录结构没什么变化，只要是一些方法改变了，默认给你安装了ts

### 2.1  	main.js

基本上没什么变化 ，只是`import vue from "vue"` 变成了 `createApp` ,2.x使用 `new Vue()` 来创建实例，3.0则使用 `createApp()` 来创建，这也导致很多插件和UI库用不了，比如 `element-ui`

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1e6e45a77b2a47ce9f204a8378562444~tplv-k3u1fbpfcp-zoom-1.image)

### 2.2	router.js

需要引入`createRouter` 来创建路由, `createWebHashHistory` 对应以前的 `hash`,

```
createWebHistory` 对应以前的 `histtory
```

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/60ce97ee1e9f4a48b4fa145bb87d9904~tplv-k3u1fbpfcp-zoom-1.image)  

### 2.3	vuex

创建方式变成了 以 `createStore` 来创建

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9b1f639f5cfc4653ad23d514433efdba~tplv-k3u1fbpfcp-zoom-1.image)

### 2.4	template模板

可以存在多个根节点

- ### Composition API

这是vue3.0变化最大的地方，2.x 数据存放在`data`，方法在`methods`，通过`this`去调用

但是，在3.0这些都没有了，所有的代码全部都在 `setup` 里面实现，而且不会再有`this`

你页面需要哪些方法，就要在当前页引入。

> 看到这里，你是不是有点头大？不过没关系，现在开始一步步梳理 如何在项目中使用这些方法，还有就是，3.0 由于没有了data,computed,methods分区，全部代码写在一起，所以对项目代码的组织能力有很大要求，所以公司内部要对代码结构有严格规定

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0b614331eefa47cb9bc6332322cd550a~tplv-k3u1fbpfcp-zoom-1.image)  

### 2.5 其他变化

1. vue源码体积的优化和监听机制的优化

2. 更好的支持typescript

3. 等等...

## 三： 生命周期

### 3.0	的生命周期也发生了点改变，这里借用一张从网上找的图

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d2c60b32d80443ca9d4173cdfdd20898~tplv-k3u1fbpfcp-zoom-1.image)

### 3.1	具体使用

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a64e3f68528a4a6d8885c31625b9b326~tplv-k3u1fbpfcp-zoom-1.image)  

## 四： 详细使用

### 4.1	setup

setup有两个参数 `props` 和 `context`

- `props` 顾名思义就是接受父组件传的值
- `context`：由于3.0里面没有 `this`，所有就有了一个 `context`上下文属性，你可以通过这个属性去获取进行 一些 vue2.x 用`this`实现的操作

![](http://photo.jomeswang.top/20201018135021.png)

### 4.2	数据赋值

不同于vue2.x，直接在return里面 `aa：123`，3.0里面赋值只能通过`ref` 和 `reactive` 去声明一个响应式的值

> 无论是`ref` 还是`reactive`声明的值，还有后面会说到的函数方法，都要`return`出来，不然`template`里面会拿不到这个值，而且reurn必须放在最后，return后面的创建值和函数不会执行

- **ref 用于声明基础数据类型**

创建一个响应式的基础类型，只能监听number、String、boolean等简单的类型，该属性一旦发生更改，都会被追踪到，js里面修改或者获取这个值的时候，要写成 `count.value`这种形式，但在`template`里面你可以直接写 `{{count}}`，不用去加.value

```
<template>
   <div>{{count}}</div>             // 1
</template>
import {ref} from "vue"

setup(){
   const count =ref(0)
   count.value++    //必须要加.value
   return{
       count        //一定要return 出去
   }
}
复制代码
```

- **isRef 检查值是否是 ref创建的类型**  

  import {ref,isRef} from "vue"

  setup(){ const count =ref(0) console.log(isRef(count)) }

- **reactive 用于声明响应式数据对象**

在vue2.x里面，如果我们想修改一个对象里面的某个属性的时候，经常会遇到值更新了但是视图没更新，只能用`$set` 来强制更新，在3.0里面，我们可以使用`reactive`来创建一个响应式对象

```
<template>
   <div>{{count.name}}</div>             // 857
</template>
import {reactive} from "vue"

setup(){
   const count =reactive({
      name:'369'
   })   count.name='857'
   return{
      count 
   }
}
复制代码
```

- **其实这两个的区别就是：**

  声明值的时候，有人喜欢这样写： let count=5; let name=8;

  有的人喜欢这样写： let obj={ name:8, value:10 }

  所以就出现了这两种声明值的方法

- **toRefs 把一个响应式对象转成成普通 ref**

这个属性我是这样理解的，当我们创建了一个`reactive`对象的时候，我们如果只想要其中的部 分属性，觉得在模板里面 `{{count.name}}`，`{{count.value}}` 太繁琐，我们可以使用这个属性，在`return` 里面 `...toRefs(count)`,解构对象,将里面的属性转换成`ref`，而不丢失响应式

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/047e8aff0a6b482f9b96814558cf884d~tplv-k3u1fbpfcp-zoom-1.image)  

### 4.3	readonly只读

将对象或者基础类型转换成只读的属性，如果修改这个值会发出警告

> 这里顺带说一下，不知道目前的vue3.0的版本问题还是啥情况，基本上不会有报错，哪怕是你引入模块路径错误，他也只会在console里面发出 warning警告，不会有报错

```
import {ref,readonly} from "vue"

export default{
   setup(){
      const count=ref(0)
      const copy=readonlu(count)
      copy.count++    //会发出warning警告
   }
}
复制代码
```

### 4.4	computed 计算

computed 和2.x差不多，基本上没变化，只是使用前要先引入，还是可以创建`get` 和 `set`  

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0d9e4d1764f742e48598a50440cfa5dc~tplv-k3u1fbpfcp-zoom-1.image)  

### 4.5	watchEffect 监听

这是vue3.0的新方法，接受一个函数，当依赖值发生改变时，立即执行这个函数，我是这样理解的，假如你通过`ref`或者`reactive`去创建多个响应式的值，当任何一个值发生改变的时候，就会立即执行这个**`watchEffect`**里面的函数

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1fa9e0f4cc864a09bd13d04f861f387b~tplv-k3u1fbpfcp-zoom-1.image)  

**这个方法一旦调用就会一直存在，直到组件** `**unmount**`**，有时候我们不想让他一直继续监听，**`**watchEffect**` **返回一个**`**stop handler**` **调用这个方法即可停止监听**

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b10b195f6bef43f387027c5431ef3f85~tplv-k3u1fbpfcp-zoom-1.image)  

### 4.6	watch

3.0的watch和2.0基本上一样，只是需要引入watch，最大的不同就是vue3.0 watch会在创建的时候执行一次，类似于2.x里面的 `immediate: true`，不过也有个新属性`lazy,`默认值为`false`,将这个值设置为true，第一次创建的时候就不会执行了

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/54b13dda2f014a51ad737faa0b1bbbf8~tplv-k3u1fbpfcp-zoom-1.image)  

### 4.7	router

3.0的`router`和`route`属性也有了很大的变化，在2.0里面我们用`this.$router` 路由跳转，`this.$route`获取当前页面路由信息，在3.0中有了点改动。

路由跳转：

```
import { useRouter} from "vue-router"; 

setup(){
  const router=useRouter()
  router.push('/path')
}
复制代码
```

获取当前页面路由信息：

```
import { useRoute} from "vue-router"; 

setup(){
  const route=useRoute()
  console.log(route)    //这里的route==2.x中的this.$route
}
复制代码
```

或者通过 `ctx` 获取当前路由信息，ctx就是当前组件的实例

```
import { getCurrentInstance } from 'vue'
setup(){
   const { ctx } = getCurrentInstance()
   console.log(ctx.$router.currentRoute.value)
}
复制代码
```

### 4.8	vuex

vuex使用方法也有了小小的改变

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b849fc3b37b94315a7d2584a541f37f1~tplv-k3u1fbpfcp-zoom-1.image)  

或者还是使用`ctx`上下文

```
import { getCurrentInstance } from "vue";

export default{
   setup(){
       const { ctx } = getCurrentInstance()
       const count = computed(() => ctx.$store.state.count)
       const update = () => {
           ctx.$store.commit('SET_COUNT', 75)
       }
   }
}
复制代码
```

### 4.9	ref节点

在vue2.x里面我们获取节点使用 this.$refs.xxx来获取这个节点，在3.0里面我们要用这样获取

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4b653e7f102e4162861ea69bc0250dca~tplv-k3u1fbpfcp-zoom-1.image)  

### 4.10	mixins

> 早在2016年年年中，Dan Abramov写了《Mixins被认为是有害的》一文，他在文中认为，在[React](http://caibaojian.com/react/)组件中使用mixins来重用逻辑是一种反模式，主张远离mixins。

现在vue里面好像没有了mixins这个属性，看网上的评论说minxins被 Composition API干掉了，关于这个的详细解释，可以看看这个 [Vue3 Composition API 是如何取代 Vue Mixins 的？](http://caibaojian.com/vue3-composition-api.html)

### 4.11	keep-alive

keep-alive和2.0差距不大，就是使用方式变了。

> 3.0 router-view 和route-link 标签不能用keep-alive 和 transtion标签包裹，不然会发出警告

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c81cdbd337b340a79399dbb47274d386~tplv-k3u1fbpfcp-zoom-1.image)  

### 未实现的功能

- **全局注册组件**
- **bus**
- ......


