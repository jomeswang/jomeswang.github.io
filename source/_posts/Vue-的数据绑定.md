---
title: Vue 的数据绑定
top: false
comments: false
abbrlink: 95a0012e
date: 2020-11-20 17:24:57
categories:
tags:
---

> vue的数据双向绑定是通过数据劫持和发布-订阅者功能来实现的

<!--more-->

实现步骤：

1.实现一个监听者Oberver来劫持并监听所有的属性，一旦有属性发生变化就通知订阅者

2.实现一个订阅者watcher来接受属性变化的通知并执行相应的方法，从而更新视图

3.实现一个解析器compile，可以扫描和解析每个节点的相关指令，并根据初始化模板数据以及初始化相对应的订阅者



2、vue是通过Object.defineProperty()来实现数据劫持的。

实现mvvm主要包含两个方面，数据变化更新视图，视图变化更新数据。 

关键点在于 data 如何更新view

因为 view 更新 data 其实可以通过事件监听即可，比如 input 标签监听 'input' 事件就可以实现了。

而数据更新视图的重点是如何知道数据变了，只要知道数据变了，那么接下去的事都好处理。如何知道数据变了，就是通过Object.defineProperty( )对属性设置一个set函数，当数据改变了就会来触发这个函数，所以我们只要将一些需要更新的方法放在这里面就可以实现data更新view了。



当 data 有变化的时候，通过ES5 中的 Object.defineProperty() 方法中的 set 方法劫持属性值的设置操作和 get 方法劫持属性值的获取操作，实现数据变化视图 view 跟着变化；

而视图 view 变化数据跟着变化则是通过底层的 input 事件来进行 data 的响应更改

Object.defineProperty(参数1，参数2，参数3)   返回值为该对象obj

参数1为该对象（obj），参数2为要定义或修改的对象的属性名，参数3为属性描述符，属性描述符是一个对象，主要有两种形式：数据描述符和存取描述符。这两种对象只能选择一种使用，不能混合使用。而get和set属于存取描述符对象的属性。

这个方法会直接在一个对象上定义一个新属性或者修改对象上的现有属性，并返回该对象

下面代码使用vue中的方法实现的数据劫持：

```js
<div>
  <input type="text" placeholder="请输入内容" />
  <h1></h1>
</div>
<script>
  var inputEle = document.querySelector('input')
  var h1Ele = document.querySelector('h1')
 
  // 设置默认值
  var obj = {
    msg: '默认值'
  }
  inputEle.value = obj.msg
  h1Ele.innerHTML = obj.msg
    //  实现视图变化数据跟着变化
  inputEle.oninput = function() {
    obj.msg = inputEle.value
  }
    // 直接在一个对象上定义一个新属性，或者修改一个对象的现有属性，并返回此对象。
  // 实现数据变化视图跟着变化
  let temp = obj.msg
  Object.defineProperty(obj, 'msg', {
    get() {
      // get方法会劫持msg这个属性的获取操作
      return temp
    },
    set(value) {
      // set方法会劫持msg这个属性的设置操作
      temp = value
      h1Ele.innerHTML = temp
      inputEle.value = temp
    },
    enumerable: true,
    configurable: true
  })
</script>
```

 

vue (defineProperty)实现拦截
进行数据劫持
++Object.defineProperty++ 拦截
1、首先会在一个函数内通过 typeof 去判断传进来的是不是一个对象，如果是的话先通过object.keys转一下然后去遍历，拿到 key

```js
<script>
    function observer (data) {
    // 判断如果没有传值，或者传的值不是一个对象，就直接return
        if(!data || typeof data !== 'object') {
            return;
        }
        Object.keys(data).forEach(item => {
            observerProperty (data, item, data[item])
        })
    }
function observerProperty (target, key, value) {
   observer (value)
    Object.defineProperty(target, key, {
        get () {
            return value;
        }
        set (val) {
            value = val
        }
    }
}
// 这样就会对obj进行一个劫持，一旦改变obj内的属性，就返回相对应的数据，比如对obj的name进行了改变，observer()函数可能会返回一句obj的name已经改变为...
// observer (obj)
let obj = {
    id:1,
    name:zhngsan,
    age: 20
}
</script>
```