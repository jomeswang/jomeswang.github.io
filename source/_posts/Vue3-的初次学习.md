---
title: Vue3 的初次学习
top: false
comments: true
categories:
  - Vue3
tags:
  - Vue3
abbrlink: 3120d751
date: 2020-10-18 13:20:22
---

> Vue3 出来了，真是一个激动人心的时刻，可是我又要学习了，开心（bushi

<!--more-->

## 一： 项目创建

### 1.1 CDN 方法

对于制作原型或学习，你可以这样使用最新版本

```html
<script src="https://unpkg.com/vue@next"></script>
```

对于生产环境，我们推荐链接到一个明确的版本号和构建文件，以避免新版本造成的不可预期的破坏：

### 1.2 命令行工具 (CLI)

Vue 提供了一个[官方的 CLI](https://github.com/vuejs/vue-cli)，为单页面应用 (SPA) 快速搭建繁杂的脚手架。它为现代前端工作流提供了 batteries-included 的构建设置。只需要几分钟的时间就可以运行起来并带有热重载、保存时 lint 校验，以及生产环境可用的构建版本。更多详情可查阅 [Vue CLI 的文档](https://cli.vuejs.org/)。

TIP

CLI 工具假定用户对 Node.js 和相关构建工具有一定程度的了解。如果你是新手，我们强烈建议先在不用构建工具的情况下通读[指南](https://vue3js.cn/docs/zh/guide/)，在熟悉 Vue 本身之后再使用 CLI。

对于 Vue 3，你应该使用 `npm` 上可用的 Vue CLI v4.5 作为 `@vue/cli@next`。要升级，你应该需要全局重新安装最新版本的 `@vue/cli`：

```bash
yarn global add @vue/cli@next
# OR
npm install -g @vue/cli@next
```

Then in the Vue projects，run

```bash
vue upgrade --next
```

### 1.3  Vite

[Vite](https://github.com/vitejs/vite) 是一个 web 开发构建工具，由于其原生 ES 模块导入方法，它允许快速提供代码。

通过在终端中运行以下命令，可以使用 Vite 快速设置 Vue 项目。

使用 NPM：

```bash
$ npm init vite-app <project-name>
$ cd <project-name>
$ npm install
$ npm run dev
```

或者 yarn：

```bash
$ yarn create vite-app <project-name>
$ cd <project-name>
$ yarn
$ yarn dev
```



## 二： 一些与VUE2的区别

### 2.1 、template不再需要根元素

显然在vue3中template不再一定需要一个父元素才能编译通过了。

### 2.2、setup函数初识

#### 2.2.1、关于setup

 setup函数其实是一个生命周期钩子，它对应的其实就是Vue2中的 beforeCreate 和 create 
在vue3中我们通过这个函数来定义vue2中的 data,methods,watch,computed 属性（数据定义与处理相关）

#### 2.2.2、setup使用

 setup函数必须有返回值，必须返回一个对象，对象里包含所有在template模板中需要使用到的属性（包含data,methods等）

 setup函数有一个props参数，用于接收props，也就是定义在组件上的属性（同vue2),但是接收的props必须先在props属性中定义，否则是不会被接收到的

下面是一个setup的使用示例：

```
<template>
  <h1>{{ msg }}</h1>
  <button @click="count++">count is: {{ count }}</button>
</template>
<script>
import { ref } from "vue";
export default {
  name: "HelloWorld",
  props: {
    msg: String,
  },
  setup(props) {
    console.log(props); // Proxy{msg:...}
    const count = ref(0);
    return {
      count,
    };
  },
};
</script> 

// 我们在这里通过ref函数定义了一个变量count,ref函数是一个把普通变量变成Proxy响应式变量的函数。
```

### 2.3、使用 ref & reactive 使得数据经过变成Proxy响应式数据

#### 2.3.1、ref函数

使用示例：

```
setup(props) {
    // 使用示例
    const count = ref(0);
    return {
      count,
    };
  },
  // 用ref定义的变量，如果需要取到其变量值，需要使用.value属性

比如：
setup(props) {
    // 使用示例
    const count = ref(0);
    const changeCount = ()=>{
        count.value++;
    }
    return {
      count,
    };
  },
 我们用changeCount替代上述setup示例模板的count++
 
 <template>
  <h1>{{ msg }}</h1>
  <button @click="changeCount">count is: {{ count }}</button>
</template>
```


有着相似的作用   ref的另一个用法：  调用原生DOM

```
<template>
  <div ref="divBox">ref的调用用法</div>
</template>
<script>
import { onMounted, reactive, ref } from "vue";
export default {
  name: "HelloWorld",
  props: {
    msg: String,
  },
  setup(props) {
    let divBox = ref(null);
    onMounted(()=>{
      console.log(divBox.value) //<div ref="divBox">ref的调用用法</div>
    })
    return {
      divBox
    };
  },
};
</script>
这里的onMounted与vue2中的mounted是一样的，是vue3的生命周期新用法
```

#### 2.3.2、reactive函数

 reactive函数和ref作用非常接近，但是它的参数是一个对象，我们可以在对象中定义其方法，而通过这个形式，就不需要再对其进行进行.value调用了

 使用示例如下：

```
<template>
  <h1>{{ msg }}</h1>
  <button @click="data.changeCount">count is: {{ data.count }}</button>
</template>
<script>
import { reactive, ref } from "vue";
export default {
  name: "HelloWorld",
  props: {
    msg: String,
  },
  setup(props) {
    // 定义一个data对象 
    const data = reactive({
      count: 0,
      changeCount: () => {
        data.count++;
      },
    });
    return {
      data,
    };
  },
};
</script>
```


 使用reactive生成的对象也是响应式的，而且调用的时候内部不再需要通过value拿到并且更改属性，但是由于外部封装了一层对象，所以在模板中使用的时候必须要使用data.xxx进行相关的调用。

 PS：由于reactive返回的对象本质上已经是一个Proxy对象，所以通过…扩展符号展开的属性，是无法进行响应式的，也就是

```
return{
	...data
}
```


并不能如同预期结果般起效

并不能如同预期结果般起效

如果实在需要使用拓展符号，需要使用toRefs这个API

```
<template>
  <button @click="changeCount">count is: {{ count }}</button>
</template>
<script>
import {  reactive,toRefs } from "vue";
export default {
  name: "HelloWorld",
  setup(props) {
    const data = reactive({
      count: 0,
      changeCount: () => {
        data.count++;
      },
    });
    const refData = toRefs(data);
    return {
      ...refData,
    };
  },
};
</script>
```

### 2.4 、Vue3的生命周期

vue2的所有生命周期写法与vue3兼容

而在vue3中，生命周期添加了on前缀，需要导入并写在setup()函数中

```
<template>
  <h1>{{ msg }}</h1>
</template>
<script>
import { onMounted } from "vue";
export default {
  name: "HelloWorld",
  props: {
    msg: String,
  },
  mounted() {
    console.log("mounted outside setup <vue2>");
  },
  setup(props) {
    onMounted(() => {
		console.log("onMounted in setup <vue3>")
    });
    return {
	};
  },
};
</script>

```

![](http://photo.jomeswang.top/20201018134135.png)