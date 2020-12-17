---
title: 软件培训 -- 入门VUE
top: false
comments: true
categories:
  - vue
tags:
  - vue
abbrlink: bb0e9d2f
date: 2020-11-20 17:27:27
---

> ## 软件培训 -- VUE

<!--more-->

## 一：Vue 的安装与使用

### 1.1  script 引入

下载 vue.js 文件然后 script 引入

```html
<script src="./vue.js"></script>
```

可以使用 CDN 来引入

```php+HTML
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
```



### 1.2 使用   vue-cli 来开发

```
yarn global add vue
vue create test
cd test
yarn serve
```



## 二： 指令的学习

### 2.1	 v-text  和 插值表达式的学习

#### 2.1.1	  插值表达式

数据绑定最常见的形式就是使用“Mustache”语法 (双大括号) 的文本插值：

```vue
<body>
  <div id="app">
    <div class="first">
      {{message}}
    </div>
    <p></p>
    <div class="second" v-text="message" >
    </div>
  </div>
</body>
<script>
var app = new Vue({
  el: "#app",
  data:{
    message: "Hello Vue!!"
  }
})
</script>
```

Mustache 标签将会被替代为对应数据对象上 `msg` property 的值。无论何时，绑定的数据对象上 `msg` property 发生了改变，插值处的内容都会更新。

同时可以 在插值表达式中 使用 JavaScript 表达式

```js
{{ number + 1 }}

{{ ok ? 'YES' : 'NO' }}

{{ message.split('').reverse().join('') }}
```



#### 2.2.2	 v-text 指令

```vue
<span v-text="message"></span>
<!-- 和下面的一样 -->
<span>{{message}}</span>
```



### 2.2	 v-bind 的使用

Mustache 语法不能作用在 HTML attribute 上，遇到这种情况应该使用 [`v-bind` 指令](https://cn.vuejs.org/v2/api/#v-bind)：

动态地绑定一个或多个 attribute，或一个组件 prop 到表达式。

```vue
<body>
  <div id="app">
    <img src="https://blog.szuea.com/wp-content/uploads/2020/10/%E8%BD%AF%E4%BB%B6%E8%B7%AF%E7%BA%BF-1024x243.png">
    <p>
      这里是为img的stc 动态绑定一个 图片URL 可以动态更新
    </p>
    <!-- 绑定一个 attribute -->
    <img v-bind:src="imageSrc">

    <!-- 缩写 -->
    <img :src="imageSrc">
  </div>
</body>
<script>
  var vm = new Vue({
    el: '#app',
    data: {
      imageSrc: "https://blog.szuea.com/wp-content/uploads/2020/10/%E8%BD%AF%E4%BB%B6%E8%B7%AF%E7%BA%BF-1024x243.png"
    }
  })
</script>
```



### 2.3	 v-modal 的使用

你可以用 `v-model` 指令在表单 `<input>`、`<textarea>` 及 `<select>` 元素上创建双向数据绑定。它会根据控件类型自动选取正确的方法来更新元素。尽管有些神奇，但 `v-model` 本质上不过是语法糖。它负责监听用户的输入事件以更新数据，并对一些极端场景进行一些特殊处理。

```html
<div id="app">
<input v-model="message" placeholder="edit me">
<p>Message is: {{ message }}</p>
</div>
<script>
var vm = new Vue({
  el: '#app',
  data: {
   	message: ""
  }
})
</script>
```



### 2.4	 v-if 的学习 （条件渲染）

`v-if` 指令用于条件性地渲染一块内容。这块内容只会在指令的表达式返回 truthy 值的时候被渲染。

```html
<div id="app">
    <p v-if="seen">现在你看到我了</p>
     <!-- 也可以用 v-else 添加一个“else 块”： -->
    <div v-else-if="seen"> 这里是v-else-if </div>
    <div v-else>这里是v-else </div>
  </div>

<script>
  var vm = new Vue({
    el: '#app',
    data: {
      seen: true
    }
  })
</script>
```



### 2.5	 v-show 的使用

```html
// 另一个用于根据条件展示元素的选项是 v-show 指令。用法大致一样：

<h1 v-show="ok">Hello!</h1>
// 不同的是带有 v-show 的元素始终会被渲染并保留在 DOM 中。v-show 只是简单地切换元素的 CSS property display。
```



### 2.6	 v-for 的使用（列表渲染）

我们可以用 v-for 指令基于一个数组来渲染一个列表。v-for 指令需要使用 item in items 形式的特殊语法，其中 items 是源数据数组，而 item 则是被迭代的数组元素的别名。

`为了给 Vue 一个提示，以便它能跟踪每个节点的身份，从而重用和重新排序现有元素，你需要为每项提供一个唯一 key attribute：` （Very Important）

```html
<div id="app" >
<h2>
      这里是v-for 啦
    </h2>
    <div class="list">
      <ul>
        <li v-for="item in list" :key="item.name" >
          {{ item.name }} --- {{item.number}}
        </li>
      </ul>
    </div>

    <h2>
      这里是v-for 的 index 啦
    </h2>
    <div class="list2">
      <ul>
        <li v-for="(item, index) in list" :key="item.name" >
         {{index}} ---  {{ item.name }} --- {{item.number}}
        </li>
      </ul>
    </div>
</div>

<script>
  var vm = new Vue({
    el: '#app',
    data: {
      list: [
        {name: "SZUEA1", numebr: 'dianxing1'},
        {name: "SZUEA2", numebr: 'dianxing2'},
        {name: "SZUEA3", numebr: 'dianxing3'},
        {name: "SZUEA4", numebr: 'dianxing4'},
      ]
    }
  })
</script>
```



### 2.7    v-on的使用 (事件处理)

可以用 `v-on` 指令监听 DOM 事件，并在触发时运行一些 JavaScript 代码。

绑定事件监听器。事件类型由参数指定。表达式可以是一个方法的名字或一个内联语句，如果没有修饰符也可以省略。

```html
<body>
  <div id="app">
    <button v-on:click="counter += 1">Add 1</button>
    <button v-on:click="addOneCounter">Add 1</button>
    <input clear type="text" placeholder="请输入点击增加的值" v-model.number="counterValue">
    <button v-on:click="addCounter(counterValue)">Add Input Value</button>
    <!--  v-on 的缩写方式 -->
    <button @click="addCounter(counterValue)">Add 1</button>
    <p>The button above has been clicked {{ counter }} times.</p>
  </div>
</body>
<script>
  var vm = new Vue({
    el: "#app",
    data: {
      counter: 0,
      counterValue: ""
    },
    methods: {
      addCounter(value){
        this.counter += value
      },
      addOneCounter(){
        this.counter += 1
      }
    },
  })
</script>
```

 JS原生事件参考： https://developer.mozilla.org/zh-CN/docs/Web/Events

### 2.8	动态绑定 Class 

```html
//  我们可以传给 v-bind:class 一个对象，以动态地切换 class：

<div
  class="static"
  v-bind:class="{ active: isActive, 'text-danger': hasError }"
></div>

和如下 data：

data: {
  isActive: true,
  hasError: false
}
结果渲染为：

<div class="static active"></div>
```



## 三： 计算属性与 侦听器

如果有一个需求是 根据用户输入的值来实时更新 界面上的展示值，这时就引入 计算属性和 侦听器。

`计算属性是基于它们的响应式依赖进行缓存的`

`侦听属性。侦听某一个数据，假如这一个数据改变那么就会执行相应的操作`

### 3.1	计算属性

```js
<div id="example">
  <p>Original message: "{{ message }}"</p>
  <p>Computed reversed message: "{{ reversedMessage }}"</p>
</div>
var vm = new Vue({
  el: '#example',
  data: {
    message: 'Hello'
  },
  computed: {
    // 计算属性的 getter
    reversedMessage: function () {
      // `this` 指向 vm 实例
      return this.message.split('').reverse().join('')
    }
  }
})

 // 计算属性默认只有读取操作， 需要人工设置 写入操作
// ...
computed: {
  fullName: {
    // 读取
    get: function () {
      return this.firstName + ' ' + this.lastName
    },
    // 设置
    set: function (newValue) {
      var names = newValue.split(' ')
      this.firstName = names[0]
      this.lastName = names[names.length - 1]
    }
  }
}
// ...
```



### 3.2	侦听属性（一般用在侦听数据改变然后查询数据）

```html
<body>
  <div id="app">
    <input  type="text" v-model="message" >
    <p>Original message: "{{ message }}"</p>
    <!-- <p>Computed reversed message: "{{ reversedMessage }}"</p> -->
  </div>
</body>
<script>
  var vm = new Vue({
    el: "#app",
    data: {
      message: ""
    },
    methods:{
    },
    //  计算属性
    computed: {
      reversedMessage(){
        return this.message.split("").reverse().join("")
      }
    },
    //侦听器
    watch:{
      message(newValue, oldValue){
        console.log(oldValue, newValue)
        // 这里是使用的 是 ES6 的 // 模版字符串
        alert(`旧值是${oldValue}, 新值是${newValue}`)
      }
    }
  })
</script>
```



## 四： 过滤器（v3版本弃用）

Vue.js 允许你自定义过滤器，可被用于一些常见的文本格式化。过滤器可以用在两个地方：**双花括号插值和 `v-bind` 表达式** (后者从 2.1.0+ 开始支持)。过滤器应该被添加在 JavaScript 表达式的尾部，由“管道”符号指示：

```html
<!-- 在双花括号中 -->
{{ message | capitalize }}

<!-- 在 `v-bind` 中 -->
<div v-bind:id="rawId | formatId"></div>
```

你可以在一个组件的选项中定义本地的过滤器：

```js
filters: {
// 第一个字母 大写  其他变小写
  capitalize: function (value) {
    if (!value) return ''
    value = value.toString()
    return value.charAt(0).toUpperCase() + value.slice(1)
  }
}
```

这一个功能可以用 函数 替换掉

```js
<!-- 在双花括号中 -->
{{  capitalize(message) }}

methods: {
  capitalize: function (value) {
    if (!value) return ''
    value = value.toString()
    return value.charAt(0).toUpperCase() + value.slice(1)
  }
}
```



## 五： 生命周期

![](https://upload-images.jianshu.io/upload_images/13119812-5890a846b6efa045.png)

```js
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
</head>
<body>
<div id="app">
    <input  v-model="message"/>
    <p>{{message}}</p>
    <button @click="clickfun">按钮</button>
</div>
</body>
<script>
    var myVue = new Vue({
        el: '#app',
        data: function () {
            return {
                message: 'XXXX'
            };
        },
        beforeCreate: function () {
            console.group('beforeCreate 创建前状态===============》');
            var state = {
                'el': this.$el,
                'data': this.$data,
                'message': this.message
            }
            console.log(state);
        },
        created: function () {
            console.group('created 创建完毕状态===============》');
            var state = {
                'el': this.$el,
                'data': this.$data,
                'message': this.message
            }
            console.log(state);
        },
        beforeMount: function () {
            console.group('beforeMount 挂载前状态===============》');
            var state = {
                'el': this.$el,
                'data': this.$data,
                'message': this.message
            }
            console.log(this.$el);
            console.log(state);
        },
        mounted: function () {
            console.group('mounted 挂载结束状态===============》');
            var state = {
                'el': this.$el,
                'data': this.$data,
                'message': this.message
            }
            console.log(this.$el);
            console.log(state);
        },
        beforeUpdate: function () {
            console.group('beforeUpdate 更新前状态===============》');
            var state = {
                'el': this.$el,
                'data': this.$data,
                'message': this.message
            }
            console.log(this.$el);
            console.log(state);
            console.log('beforeUpdate == ' + document.getElementsByTagName('p')[0].innerHTML);
        },
        updated: function () {
            console.group('updated 更新完成状态===============》');
            var state = {
                'el': this.$el,
                'data': this.$data,
                'message': this.message
            }
            console.log(this.$el);
            console.log(state);
            console.log('updated == ' + document.getElementsByTagName('p')[0].innerHTML);
        },
        beforeDestroy: function () {
            console.group('beforeDestroy 销毁前状态===============》');
            var state = {
                'el': this.$el,
                'data': this.$data,
                'message': this.message
            }
            console.log(this.$el);
            console.log(state);
        },
        destroyed: function () {
            console.group('destroyed 销毁完成状态===============》');
            var state = {
                'el': this.$el,
                'data': this.$data,
                'message': this.message
            }
            console.log(this.$el);
            console.log(state);
        },
        methods: {
            clickfun() {
                myVue.$destroy()
            }
        
        }
        
        
    });
</script>
</html>
```

通过上述测试我们可以知道，

| 生命周期     | 是否获取dom节点 | 是否可以获取data | 是否获取methods |
| ------------ | --------------- | ---------------- | --------------- |
| beforeCreate | 否              | 否               | 否              |
| created      | 否              | 是               | 是              |
| beforeMount  | 否              | 是               | 是              |
| mounted      | 是              | 是               | 是              |

以我的个人理解，**vue生命周期**实际上和**浏览器渲染过程**是挂钩的，

在beforecreate阶段，对浏览器来说，整个渲染流程尚未开始或者说准备开始，对vue来说，实例尚未被初始化，data observer和 event/watcher也还未被调用，在此阶段，对data、methods或文档节点的调用现在无法得到正确的数据。

在created阶段，对浏览器来说，渲染整个HTML文档时,dom节点、css规则树与js文件被解析后，但是没有进入被浏览器render过程，上述资源是尚未挂载在页面上，也就是在vue生命周期中对应的created
阶段，实例已经被初始化，但是还没有挂载至**$el**上，所以我们无法获取到对应的节点，但是此时我们是可以获取到vue中data与methods中的数据的

在beforeMount阶段，实际上与created阶段类似，节点尚未挂载，但是依旧可以获取到data与methods中的数据。

在mounted阶段，对浏览器来说，已经完成了dom与css规则树的render，并完成对render tree进行了布局，而浏览器收到这一指令，调用渲染器的paint（）在屏幕上显示，而对于vue来说，在mounted阶段，vue的**template成功挂载在$el中**，此时一个完整的页面已经能够显示在浏览器中，所以在这个阶段，即可以调用节点了（关于这一点，在笔者测试中，在mounted方法中打断点然后run，依旧能够在浏览器中看到整体的页面）。



## 六： 相关材料

### 6.1	Vue2 的开发文档

https://cn.vuejs.org/v2/guide/



### 6.2 Vue的原理剖析

https://wenku.baidu.com/view/ef0160ea7cd184254b3535ff.html?fr=search-1





## 七： 作业

### 7.1	写一个计算器

![](http://photo.jomeswang.top/20201120153355.png)

1. 最低要求  写出如图所示 计算器
2. 拔高一：记录 计算信息 并可以回滚
3. 拔高二： 有括号的运算 
4. 拔高三： 有三角函数的运算
5. 参考Windows 计算器

![](http://photo.jomeswang.top/20201120153403.png)