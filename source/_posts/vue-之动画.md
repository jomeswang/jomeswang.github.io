---
title: vue 之动画
top: false
comments: true
categories:
  - vue
tags:
  - vue
  - animate
abbrlink: '33137921'
date: 2020-02-10 13:50:43
---

## 一：前言

鉴于之前看到有人的网页动画很好看，所以特去学习vue中的动画，借这篇文章将所学的vue动画做一个总结。其中包含animate.css的引入和使用。

<!-- more -->

## 二：进入/离开&列表过渡

### 2.1 单元素/组件的过渡

> Vue 提供了 `transition` 的封装组件，在下列情形中，可以给任何元素和组件添加进入/离开过渡
>
> - 条件渲染 (使用 `v-if`)
> - 条件展示 (使用 `v-show`)
> - 动态组件
> - 组件根节点

#### 2.1.1 过渡的类名

 在进入/离开的过渡中，会有 6 个 class 切换。 

[![15uss0.md.png](https://s2.ax1x.com/2020/02/10/15uss0.md.png)](https://imgchr.com/i/15uss0)

其中两个active类是 可以被用来定义进入过渡的过程时间，延迟和曲线函数。 

另外四个用来定于初末状态。

 对于这些在过渡中切换的类名来说，如果你使用一个没有名字的 ``，则 `v-` 是这些类名的默认前缀。如果你使用了 ``，那么 `v-enter` 会替换为 `my-transition-enter`。 

#### 2.1.2  自定义过渡的类名

我们可以通过以下 attribute 来自定义过渡类名：

- `enter-class`
- `enter-active-class`
- `enter-to-class` (2.1.8+)
- `leave-class`
- `leave-active-class`
- `leave-to-class` (2.1.8+)

他们的优先级高于普通的类名，这对于 Vue 的过渡系统和其他第三方 CSS 动画库，如 [Animate.css](https://daneden.github.io/animate.css/) 结合使用十分有用。（第三部分会讲到如何使用这个动画库）

#### 2.1.3 CSS过渡

```css
<div id="example-1">
  <button @click="show = !show">
    Toggle render
  </button>
  <transition name="slide-fade">
    <p v-if="show">hello</p>
  </transition>
</div>
      
new Vue({
  el: '#example-1',
  data: {
    show: true
  }
})

<style>
/* 可以设置不同的进入和离开动画 */
/* 设置持续时间和动画函数 */
.slide-fade-enter-active {
  transition: all .3s ease;
}
.slide-fade-leave-active {
  transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active for below version 2.1.8 */ {
  transform: translateX(10px);
  opacity: 0;
}
<style/>
```

#### 2.1.4 CSS动画

只改上方的style部分

```css
.bounce-enter-active {
  animation: bounce-in .5s;
}
.bounce-leave-active {
  animation: bounce-in .5s reverse;
}
@keyframes bounce-in {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(1.5);
  }
  100% {
    transform: scale(1);
  }
}
```

#### 2.1.5 显性的过渡持续时间

 在这种情况下你可以用 `` 组件上的 `duration` 属性定制一个显性的过渡持续时间 (以毫秒计)： 

```
<transition :duration="1000">...</transition>
```

你也可以定制进入和移出的持续时间：

```
<transition :duration="{ enter: 500, leave: 800 }">...</transition>
```

#### 2.1.6 JaveScript 钩子

 可以在属性中声明 JavaScript 钩子 

```
<transition
  v-on:before-enter="beforeEnter"
  v-on:enter="enter"
  v-on:after-enter="afterEnter"
  v-on:enter-cancelled="enterCancelled"

  v-on:before-leave="beforeLeave"
  v-on:leave="leave"
  v-on:after-leave="afterLeave"
  v-on:leave-cancelled="leaveCancelled"
>
  <!-- ... -->
</transition>
```

这些钩子函数可以结合 CSS `transitions/animations` 使用，也可以单独使用。

> 当只用 JavaScript 过渡的时候，**在 `enter` 和 `leave` 中必须使用 `done` 进行回调**。否则，它们将被同步调用，过渡会立即完成。
>
> 推荐对于仅使用 JavaScript 过渡的元素添加 `v-bind:css="false"`，Vue 会跳过 CSS 的检测。这也可以避免过渡过程中 CSS 的影响。

详细用法，请百度。。。（此节较难使用）

### 2.2 多个元素的过渡

 最常见的多标签过渡是一个列表和描述这个列表为空消息的元素： 

```
<transition>
  <table v-if="items.length > 0">
    <!-- ... -->
  </table>
  <p v-else>Sorry, no items found.</p>
</transition>
```

 可以这样使用，但是有一点需要注意： 

>  当有**相同标签名**的元素切换时，需要通过 `key` attribute 设置唯一的值来标记以让 Vue 区分它们，否则 Vue 为了效率只会替换相同标签内部的内容。即使在技术上没有必要，**给在 `` 组件中的多个元素设置 key 是一个更好的实践** 

#### 2.2.1过渡模式

 有两个元素过渡时，一个离开过渡的时候另一个开始进入过渡。这是 ` <transition> ` 的默认行为 - 进入和离开同时发生。 

同时生效的进入和离开的过渡不能满足所有要求，所以 Vue 提供了 **过渡模式**

- `in-out`：新元素先进行过渡，完成之后当前元素过渡离开。
- `out-in`：当前元素先进行过渡，完成之后新元素过渡进入。

```
<transition name="fade" mode="out-in">
  <!-- ... the buttons ... -->
</transition>
```

### 2.3多个组件的过渡

 多个组件的过渡简单很多 - 我们不需要使用 `key` attribute。相反，我们只需要使用[动态组件](https://cn.vuejs.org/v2/guide/components.html#动态组件)： 

```
<transition name="component-fade" mode="out-in">
  <component v-bind:is="view"></component>
</transition>
new Vue({
  el: '#transition-components-demo',
  data: {
    view: 'v-a'
  },
  components: {
    'v-a': {
      template: '<div>Component A</div>'
    },
    'v-b': {
      template: '<div>Component B</div>'
    }
  }
})
.component-fade-enter-active, .component-fade-leave-active {
  transition: opacity .3s ease;
}
.component-fade-enter, .component-fade-leave-to
/* .component-fade-leave-active for below version 2.1.8 */ {
  opacity: 0;
}
```

### 2.4 列表的过渡

目前为止，关于过渡我们已经讲到：

- 单个节点
- 同一时间渲染多个节点中的一个

那么怎么同时渲染整个列表，比如使用 `v-for` ？在这种场景中，使用 `` 组件。在我们深入例子之前，先了解关于这个组件的几个特点：

- 不同于 ``，它会以一个真实元素呈现：默认为一个 ``。你也可以通过 `tag` attribute 更换为其他元素。
- [过渡模式](https://cn.vuejs.org/v2/guide/transitions.html#过渡模式)不可用，因为我们不再相互切换特有的元素。
- 内部元素 **总是需要** 提供唯一的 `key` 属性值。
- CSS 过渡的类将会应用在内部的元素中，而不是这个组/容器本身。

#### 2.4.1[列表的进入/离开过渡](https://cn.vuejs.org/v2/guide/transitions.html#列表的进入-离开过渡)

 现在让我们由一个简单的例子深入，进入和离开的过渡使用之前一样的 CSS 类名。 

```
<div id="list-demo" class="demo">
  <button v-on:click="add">Add</button>
  <button v-on:click="remove">Remove</button>
  <transition-group name="list" tag="p">
    <span v-for="item in items" v-bind:key="item" class="list-item">
      {{ item }}
    </span>
  </transition-group>
</div>
new Vue({
  el: '#list-demo',
  data: {
    items: [1,2,3,4,5,6,7,8,9],
    nextNum: 10
  },
  methods: {
    randomIndex: function () {
      return Math.floor(Math.random() * this.items.length)
    },
    add: function () {
      this.items.splice(this.randomIndex(), 0, this.nextNum++)
    },
    remove: function () {
      this.items.splice(this.randomIndex(), 1)
    },
  }
})
.list-item {
  display: inline-block;
  margin-right: 10px;
}
.list-enter-active, .list-leave-active {
  transition: all 1s;
}
.list-enter, .list-leave-to
/* .list-leave-active for below version 2.1.8 */ {
  opacity: 0;
  transform: translateY(30px);
}
```

#### 2.4.2 列表的排序过渡

 `<transition-group>` 组件还有一个特殊之处。不仅可以进入和离开动画，还可以改变定位。要使用这个新功能只需了解新增的 **`v-move` attribute**，它会在元素的改变定位的过程中应用。像之前的类名一样，可以通过 `name` 属性来自定义前缀，也可以通过 `move-class` 属性手动设置。 

 `v-move` 对于设置过渡的切换时机和过渡曲线非常有用，你会看到如下的例子： 

```
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.14.1/lodash.min.js"></script>

<div id="flip-list-demo" class="demo">
  <button v-on:click="shuffle">Shuffle</button>
  <transition-group name="flip-list" tag="ul">
    <li v-for="item in items" v-bind:key="item">
      {{ item }}
    </li>
  </transition-group>
</div>
new Vue({
  el: '#flip-list-demo',
  data: {
    items: [1,2,3,4,5,6,7,8,9]
  },
  methods: {
    shuffle: function () {
      this.items = _.shuffle(this.items)
    }
  }
})
.flip-list-move {
  transition: transform 1s;
}
```

 这个看起来很神奇，内部的实现，Vue 使用了一个叫 [FLIP](https://aerotwist.com/blog/flip-your-animations/) 简单的动画队列
使用 transforms 将元素从之前的位置平滑过渡新的位置。 

## 3.使用Animate.css 来加载动画

### 3.1 安装

#### 3.1.1使用npm方法

```
npm install animate.css --save
```

#### 3.1.2使用yarn方法

```
yarn add animate.css
```

### 3.2 引入

#### 3.2.1 vue-cli中引入

在main.js中引入

```
import animate from 'animate.css' // npm install animate.css --save安装，在引入

Vue.use(animate)
```

#### 3.2.2在单页面中引入

```
<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
</head>
```

### 3.2使用

[动画演示](https://daneden.github.io/animate.css/)

使用前都要在类前加 `animated`

#### 3.2.1在vue-cli中使用

即应用自定义的过渡类名  注意： 使用前都要在类前加 `animated`

```
<transition enter-active-class="animated fadeIn" leave-active-class="animated bounceOutRight">
<h2 v-if="show">hahahahah!!!</h2>
</transition>
```

#### 3.2.2 设置延迟和速度

用所列的类名来控制，只需写入所需类名。

设置延迟

| Class Name | Delay Time |
| ---------- | ---------- |
| `delay-1s` | `1s`       |
| `delay-2s` | `2s`       |
| `delay-3s` | `3s`       |
| `delay-4s` | `4s`       |
| `delay-5s` | `5s`       |

>  ***Note**: The default delays are from 1 second to 5 seconds only. If you need custom delays, add it directly to your own CSS code.* 

设置速度

| Class Name | Speed Time |
| ---------- | ---------- |
| `slow`     | `2s`       |
| `slower`   | `3s`       |
| `fast`     | `800ms`    |
| `faster`   | `500ms`    |

>  ***Note**: The `animated` class has a default speed of `1s`. If you need custom duration, add it directly to your own CSS code.* 

