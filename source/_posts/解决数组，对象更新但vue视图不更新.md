---
title: 解决数组，对象更新但vue视图不更新
top: false
comments: true
categories:
  - vue
tags:
  - vue
abbrlink: b55e4518
date: 2020-06-14 10:25:34
---

> 由于 JavaScript 的限制，Vue **不能检测**数组和对象的变化。尽管如此我们还是有一些办法来回避这些限制并保证它们的响应性。



<!--more-->

## 一：检测变化注意

### 1.1  对于对象

Vue 无法检测 property 的添加或移除。由于 Vue 会在初始化实例时对 property 执行 getter/setter 转化，所以 property 必须在 `data` 对象上存在才能让 Vue 将它转换为响应式的。

```
this.someObject.b = 2  // 这种直接添加对象属性的方法不能够被检测到
```

对于已经创建的实例，Vue 不允许动态添加根级别的响应式 property。但是，可以使用 `Vue.set(object, propertyName, value)` 方法向嵌套对象添加响应式 property。例如，对于：

```
Vue.set(vm.someObject, 'b', 2)

// 您还可以使用 vm.$set 实例方法，这也是全局 Vue.set 方法的别名：
this.$set(this.someObject,'b',2)   // 等价于 this.someObject.b = 2
```

有时你可能需要为已有对象赋值多个新 property，比如使用 `Object.assign()` 或 `_.extend()`。但是，这样添加到对象上的新 property 不会触发更新。在这种情况下，你应该用原对象与要混合进去的对象的 property 一起创建一个新的对象。

```
// 代替 `Object.assign(this.someObject, { a: 1, b: 2 })`
this.someObject = Object.assign({}, this.someObject, { a: 1, b: 2 })
```



### 1.2 对于数组

Vue 不能检测以下数组的变动：

1. 当你利用索引直接设置一个数组项时，例如：`vm.items[indexOfItem] = newValue`
2. 当你修改数组的长度时，例如：`vm.items.length = newLength`

举个例子：

```
var vm = new Vue({
  data: {
    items: ['a', 'b', 'c']
  }
})
vm.items[1] = 'x' // 不是响应性的
vm.items.length = 2 // 不是响应性的
```

为了解决第一类问题，以下两种方式都可以实现和 `vm.items[indexOfItem] = newValue` 相同的效果，同时也将在响应式系统内触发状态更新：

```
// Vue.set
Vue.set(vm.items, indexOfItem, newValue)
// Array.prototype.splice
vm.items.splice(indexOfItem, 1, newValue)
```

你也可以使用 [`vm.$set`](https://cn.vuejs.org/v2/api/#vm-set) 实例方法，该方法是全局方法 `Vue.set` 的一个别名：

```
vm.$set(vm.items, indexOfItem, newValue)  //在

this.$set(vm.items, indexOfItem, newValue)
```

为了解决第二类问题，你可以使用 `splice`：

```
vm.items.splice(newLength)
```

 `在组件中使用 this 代替  vm`   



## 二：总结

###  2.1 重新渲染视图

如果你没有发现哪里的数据更新了，但视图没有更新的话。请使用

```
this.$forceUpdate()    // 这个函数会强制刷新视图，重新渲染数据
```

### 2. 2   使用 set方法

```
this.$set(vm.items, indexOfItem, newValue)  // 数组

this.$set(object, propertyName, value)    // 对象
```

