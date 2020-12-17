---
title: Vue2 组件之间传值
top: false
comments: true
categories:
  - Vue
tags:
  - Vue
abbrlink: 66b1cc04
date: 2020-10-17 15:10:54
---

> 组件件的传值有点复杂，我在这里记录一下哈

<!--more--->

Vue2.0 传值方式：

在Vue的框架开发的项目过程中，经常会用到组件来管理不同的功能，有一些公共的组件会被提取出来。这时必然会产生一些疑问和需求？比如一个组件调用另一个组件作为自己的子组件，那么我们如何进行给子组件进行传值呢？如果是电商网站系统的开发，还会涉及到购物车的选项，这时候就会涉及到非父子组件传值的情况。当然你也可以用Vuex状态管理工具来实现，这部分我们后续会单独介绍。

引用官网的一句话：父子组件的关系可以总结为 prop 向下传递，事件向上传递。父组件通过 prop 给子组件下发数据，子组件通过事件给父组件发送消息，如下图所示：



接下来，我们通过实例来看可能会更明白一些：

1. 父组件向子组件进行传值props


父组件：

```HTML
<template>
  <div>
    父组件:
    <input type="text" v-model="name">
    <br>
    <br>
    <!-- 引入子组件 -->
    <child :inputName="name"></child>
  </div>
</template>
<script>
  import child from './child'
  export default {
    components: {
      child
    },
    data () {
      return {
        name: ''
      }
    }
  }
</script>
```

子组件：
```html
<template>
  <div>
    子组件:
    <span>{{inputName}}</span>
  </div>
</template>
<script>
  export default {
    // 接受父组件的值
    props: {
      inputName: String,
      required: true
    }
  }
</script>
```

2. 子组件向父组件传值$emit,父组件通过子组件的ref属性获取值


子组件：

```HTML
<template>
  <div>
    子组件:
    <span>{{childValue}}</span>
    <!-- 定义一个子组件传值的方法 -->
    <input type="button" value="点击触发" @click="childClick">
  </div>
</template>
<script>
  export default {
    data () {
      return {
        childValue: '我是子组件的数据'
      }
    },
    methods: {
      childClick () {
        // childByValue是在父组件on监听的方法
        // 第二个参数this.childValue是需要传的值
        this.$emit('childByValue', this.childValue)
      }
    }
  }
</script>
```

父组件：
```html
<template>
  <div>
    父组件:
    <span>{{name}}</span>
    <br>
    <br>
    <!-- 引入子组件 定义一个on的方法监听子组件的状态-->
    <child v-on:childByValue="childByValue"></child>
  </div>
</template>
<script>
  import child from './child'
  export default {
    components: {
      child
    },
    data () {
      return {
        name: ''
      }
    },
    methods: {
      childByValue: function (childValue) {
        // childValue就是子组件传过来的值
        this.name = childValue
      }
    }
  }
</script>
```

尽管有 prop 和事件，但是有时仍然需要在 JavaScript 中直接访问子组件。
为此可以使用 ref 为子组件指定一个引用 ID。例如：

```html
<div id="parent">
  <user-profile ref="profile"></user-profile>
</div>
```

```html
var parent = new Vue({ el: '#parent' })
// 访问子组件实例
var child = parent.$refs.profile
```

当 ref 和 v-for 一起使用时，获取到的引用会是一个数组，包含和循环数据源对
应的子组件。
$refs 只在组件渲染完成后才填充，并且它是非响应式的。它仅仅是一个直接
操作子组件的
应急方案——应当避免在模板或计算属性中使用 $refs。

具体使用方法：

父组件

```html
<template>
  <div id="app">
    {{ a }}
    <button @click="getchild">通过ref得到子组件的值</button>
    <!-- 使用组件 -->
    <three ref="mesage"/>
  </div>
</template>
<script>
import three from './components/three'

export default {
  components:{
    three,
  },
  data(){
    return {
      a:'我是父组件',
    }
  },
  methods:{
    getchild(){
	   // 通过this.$refs调用
      console.log(this.$refs.mesage.mes)
    }
  }
}
</script>
```




子组件： 

```html
<template>
    <div class="three">
        {{mes}}
    </div>
</template>
<script>
	export default {
	  data() {
	    return {
	        mes:'666'
	    };
	  }
	};
</script>
```




3. 事件总线 $emit　/ $on


非父子组件之间传值，需要定义个公共的公共实例文件bus.js，作为中间仓库来传值，不然路由组件之间达不到传值的效果。这种方法通过一个空的Vue实例作为中央事件总线（事件中心），用它来触发事件和监听事件,巧妙而轻量地实现了任何组件间的通信，包括父子、兄弟、跨级。当我们的项目比较大时，可以选择更好的状态管理解决方案vuex。

公共bus.js

```
//bus.js
import Vue from 'vue'
export default new Vue()
```

组件A：

```HTML
<template>
  <div>
    A组件:
    <span>{{elementValue}}</span>
    <input type="button" value="点击触发" @click="elementByValue">
  </div>
</template>
<script>
  // 引入公共的bug，来做为中间传达的工具
  import Bus from './bus.js'
  export default {
    data () {
      return {
        elementValue: 4
      }
    },
    methods: {
      elementByValue: function () {
        Bus.$emit('val', this.elementValue)
      }
    }
  }
</script>
```

组件B：
```html
<template>
  <div>
    B组件:
    <input type="button" value="点击触发" @click="getData">
    <span>{{name}}</span>
  </div>
</template>
<script>
  import Bus from './bus.js'
  export default {
    data () {
      return {
        name: 0
      }
    },
    mounted: function () {
      var vm = this
      // 用$on事件来接收参数
      Bus.$on('val', (data) => {
        console.log(data)
        vm.name = data
      })
    },
    methods: {
      getData: function () {
        this.name++
      }
    }
  }
</script>
```



4. 利用vuex


（1）简要介绍Vuex原理

Vuex实现了一个单向数据流，在全局拥有一个State存放数据，当组件要更改State中的数据时，必须通过Mutation进行，Mutation同时提供了订阅者模式供外部插件调用获取State数据的更新。而当所有异步操作(常见于调用后端接口异步获取更新数据)或批量的同步操作需要走Action，但Action也是无法直接修改State的，还是需要通过Mutation来修改State的数据。最后，根据State的变化，渲染到视图上。

（2）简要介绍各模块在流程中的功能：

Vue Components：Vue组件。HTML页面上，负责接收用户操作等交互行为，执行dispatch方法触发对应action进行回应。

dispatch：操作行为触发方法，是唯一能执行action的方法。

actions：操作行为处理模块,由组件中的 $store.dispatch('action 名称',data1)来触发。然后由commit()来触发mutation的调用 , 间接更新 state。负责处理Vue Components接收到的所有交互行为。包含同步/异步操作，支持多个同名方法，按照注册的顺序依次触发。向后台API请求的操作就在这个模块中进行，包括触发其他action以及提交mutation的操作。该模块提供了Promise的封装，以支持action的链式触发。

commit：状态改变提交操作方法。对mutation进行提交，是唯一能执行mutation的方法。

mutations：状态改变操作方法，由actions中的 commit('mutation 名称')来触发。是Vuex修改state的唯一推荐方法。该方法只能进行同步操作，且方法名只能全局唯一。操作之中会有一些hook暴露出来，以进行state的监控等。

state：页面状态管理容器对象。集中存储Vue components中data对象的零散数据，全局唯一，以进行统一的状态管理。页面显示所需的数据从该对象中进行读取，利用Vue的细粒度数据响应机制来进行高效的状态更新。

getters：state对象读取方法。图中没有单独列出该模块，应该被包含在了render中，Vue Components通过该方法读取全局state对象。

5.Vuex与localStorage
vuex 是 vue 的状态管理器，存储的数据是响应式的。但是并不会保存起来，刷新之后就回到了初始状态，具体做法应该在vuex里数据改变的时候把数据拷贝一份保存到localStorage里面，刷新之后，如果localStorage里有保存的数据，取出来再替换store里的state。

```html
 
let defaultCity = "北京"
try {   
// 用户关闭了本地存储功能，此时在外层加个try...catch
if(!defaultCity){
    defaultCity = JSON.parse(window.localStorage.getItem('defaultCity'))
  }
}catch(e){}
export default
 new Vuex.Store({
  state: {
    city: defaultCity
  },
  mutations: {
    changeCity(state, city) {
      state.city = city
    try{
        window.localStorage.setItem('defaultCity', JSON.stringify(state.city));   
        // 数据改变的时候把数据拷贝一份保存到localStorage里面
     } catch(e) {}
  }
}
})
```


这里需要注意的是：由于vuex里，我们保存的状态，都是数组，而localStorage只支持字符串，所以需要用JSON转换：

```html
JSON.stringify(state.subscribeList);   
// array -> string

JSON.parse(window.localStorage.getItem("subscribeList"));    
// string -> array 
```


6.  $attrs　/ $listeners
1.简介

多级组件嵌套需要传递数据时，通常使用的方法是通过vuex。但如果仅仅是传递数据，而不做中间处理，使用 vuex 处理，未免有点大材小用。为此Vue2.4 版本提供了另一种方法---- $attrs/ $listeners

$attrs：包含了父作用域中不被 prop 所识别 (且获取) 的特性绑定 (class 和 style 除外)。当一个组件没有声明任何 prop 时，这里会包含所有父作用域的绑定 (class 和 style 除外)，并且可以通过 v-bind="$attrs" 传入内部组件。通常配合 interitAttrs 选项一起使用。

$listeners：包含了父作用域中的 (不含 .native 修饰器的) v-on 事件监听器。它可以通过 v-on="$listeners" 传入内部组件接下来我们看个跨级通信的例子：

//index.vue
```html
<template>
    <div>
        <h2>浪里行舟</h2>
        <child-com1 :foo="foo" :boo="boo" :coo="coo" :doo="doo" title="前端工匠"></child-com1>
    </div>
</template>
<script>
import childCom1 from "./childCom1.vue"
export default {
    components: {childCom1},
    data (){
        return {
            foo："javascript",
            boo: "Html",
            coo: "Css",
            doo: "Vue"
        }
    }
}
</script>
```

`//childCom1.vue`

```html
<template>
    <div>
        <p>foo:{{foo}}</p>
        <p>childCom1的$attrs:{{$attrs}}</p>
        <child-com2 v-bind="$attrs"></child-com2>
    </div>
</template>
<script>
import childCom2 from "./childCom2.vue";
export default {
    components:{ childCom2 },
    inheritAttrs:false,//可以关闭自动挂载到组件跟元素上的没有在props声明的属性
    props: { foo: String },// foo作为props属性绑定
    created() { console.log(this.$attrs); // { "boo": "Html", "coo": "CSS", "doo": "Vue", "title": "前端工匠" }
  }
}
</script>
```

//childCom2.vue



```html
<template>
    <div>
        <p>boo:{{boo}}</p>
        <p>childCom2的$attrs:{{$attrs}}</p>
        <child-com3 v-bind="$attrs"></child-com3>
    </div>
</template>
<script>
import childCom3 from "./childCom3.vue";
export default {
    components:{ childCom3 },
    inheritAttrs:false,//可以关闭自动挂载到组件跟元素上的没有在props声明的属性
    props: { foo: String },// foo作为props属性绑定
    created() { console.log(this.$attrs); // { "boo": "Html", "coo": "CSS", "doo": "Vue", "title": "前端工匠" }
  }
}
</script>
```

// childCom3.vue

```html
<template>
  <div> 
    <p>childCom3: {{ $attrs }}</p>
  </div>
</template>
<script>
export default{
  props: {
    coo: String,
    title: String
  }
};
</script>
```

如上图所示 $attrs表示没有继承数据的对象，格式为{属性名：属性值}。Vue2.4提供了 $attrs ,$listeners 来传递数据与事件，跨级组件之间的通讯变得更简单。

简单来说： $attrs与 $listeners 是两个对象， $attrs 里存放的是父组件中绑定的非 Props 属性， $listeners里存放的是父组件中绑定的非原生事件。

7.provide/inject
1.简介

Vue2.2.0新增API,这对选项需要一起使用，以允许一个祖先组件向其所有子孙后代注入一个依赖，不论组件层次有多深，并在起上下游关系成立的时间里始终生效。一言而蔽之：祖先组件中通过provider来提供变量，然后在子孙组件中通过inject来注入变量。provide / inject API 主要解决了跨级组件间的通信问题，不过它的使用场景，主要是子组件获取上级组件的状态，跨级组件间建立了一种主动提供与依赖注入的关系。

2.举个例子

假设有两个组件： A.vue 和 B.vue，B 是 A 的子组件

```
// A.vue
export default{
  provide: {    name: '浪里行舟'  }
}
// B.vue
export default {
  inject: ['name'],
  mounted () {
    console.log(this.name); // 浪里行舟
  }
}
```


可以看到，在 A.vue 里，我们设置了一个 provide: name，值为 浪里行舟，它的作用就是将 name 这个变量提供给它的所有子组件。而在 B.vue 中，通过 inject 注入了从 A 组件中提供的 name 变量，那么在组件 B 中，就可以直接通过 this.name 访问这个变量了，它的值也是 浪里行舟。这就是 provide / inject API 最核心的用法。

需要注意的是：provide 和 inject 绑定并不是可响应的。这是刻意为之的。然而，如果你传入了一个可监听的对象，那么其对象的属性还是可响应的----vue官方文档 所以，上面 A.vue 的 name 如果改变了，B.vue 的 this.name 是不会改变的，仍然是 浪里行舟。

3.provide与inject 怎么实现数据响应式

一般来说，有两种办法：

provide祖先组件的实例，然后在子孙组件中注入依赖，这样就可以在子孙组件中直接修改祖先组件的实例的属性，不过这种方法有个缺点就是这个实例上挂载很多没有必要的东西比如props，methods

使用2.6最新API Vue.observable 优化响应式 provide(推荐)

我们来看个例子：孙组件D、E和F获取A组件传递过来的color值，并能实现数据响应式变化，即A组件的color变化后，组件D、E、F不会跟着变（核心代码如下：）


// A 组件 
```
<div>
      <h1>A 组件</h1>
      <button @click="() => changeColor()">改变color</button>
      <ChildrenB/><ChildrenC/>
</div>
......

  data() {   
    return
     {
        color: "blue"
     };
  },

// provide() {
//   return {
//     theme: {
//       color: this.color //这种方式绑定的数据并不是可响应的
//     } // 即A组件的color变化后，组件D、E、F不会跟着变 
//   };
// },
  provide() { 
    return{
      theme: this//方法一：提供祖先组件的实例
    };
  },
  methods: {
    changeColor(color) {  
    if(color) {     
        this.color = color;
    } else{      
        this.color = this.color === "blue"? "red": "blue";
     }
   }
  }
// 方法二:使用vue2.6最新API Vue.observable 优化响应式 provide
// provide() {
//   this.theme = Vue.observable({
//     color: "blue"
//   });
//   return {
//     theme: this.theme
//   };
// },
// methods: {
//   changeColor(color) {
//     if (color) {
//       this.theme.color = color;
//     } else {
//       this.theme.color = this.theme.color === "blue" ? "red" : "blue";
//     }
//   }  
// }
// F 组件 
<template functional>
  <div class="border2">
    <h3 :style="{ color: injections.theme.color }">F 组件</h3>
  </div>
</template>
<script>
export default
 {
  inject: {
  theme: {   
 //函数式组件取值不一样     
    default: () => ({})
   }
  }
};
</script>
```

虽说provide 和 inject 主要为高阶插件/组件库提供用例，但如果你能在业务中熟练运用，可以达到事半功倍的效果！

8. $parent / $children　＆ ref
ref：如果在普通的 DOM 元素上使用，引用指向的就是 DOM 元素；如果用在子组件上，引用就指向组件实例

$parent / $children：访问父 / 子实例

需要注意的是：这两种都是直接得到组件实例，使用后可以直接调用组件的方法或访问数据。我们先来看个用 ref来访问组件的例子：

```html
// component-a 子组件
export default
 {
  data () {   
    return
     {
         title: 'Vue.js'
     }
  },
  methods: {
    sayHello () {
      window.alert('Hello');
    }
  }
}
// 父组件
<template>
  <component-a ref="comA"></component-a>
</template>
<script>  
export default
 {
    mounted () {    
        const comA = this.$refs.comA;
        console.log(comA.title);  // Vue.js
        comA.sayHello();  // 弹窗
    }
  }
</script>
```

不过，这两种方法的弊端是，无法在跨级或兄弟间通信。

```html
// parent.vue
<component-a></component-a>
<component-b></component-b>
<component-b></component-b>
```


我们想在 component-a 中，访问到引用它的页面中（这里就是 parent.vue）的两个 component-b 组件，那这种情况下，就得配置额外的插件或工具了，比如 Vuex 和 Bus 的解决方案。

总结
常见使用场景可以分为三类：

父子通信： 父向子传递数据是通过 props，子向父是通过 events（ $emit）；通过父链 / 子链也可以通信（ $parent / $children）；ref 也可以访问组件实例；provide / inject API； $attrs/$listeners

兄弟通信： Bus；Vuex

跨级通信： Bus；Vuex；provide / inject API、 $attrs/$listeners