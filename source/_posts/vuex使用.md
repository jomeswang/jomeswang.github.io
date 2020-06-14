---
title: vuex使用
top: false
comments: true
categories:
  - vuex
tags:
  - vuex
abbrlink: a47b42bc
date: 2020-06-13 11:48:31
---

## 1. vuex简介

vuex是专门用来管理vue.js应用程序中状态的一个插件。他的作用是将应用中的所有状态都放在一起，集中式来管理。需要声明的是，这里所说的状态指的是vue组件中data里面的属性。了解vue的同学应该是明白data是怎么回事的吧，如果不懂的话，建议先学完vue的基础知识再看vuex。

<!--more-->

## 2. vuex的组成结构示意图

vuex的特点是把数据单独隔离，形成一棵树状图。单独隔离就意味着它有自己的生态系统。输入和输出，其中action作为数据的输入，state作为数据的输出。如下图：

![](http://photo.jomeswang.top/20200613120122.png)

vuex里有这么一个规则：

> 只能在mutaions里修改state，actions不能直接修改state

 

mutations即变化，修改state的数据，而且只能是同步的，不能存在异步的操作。如果需要异步怎么办呢？把异步操作放在actions里，拿到数据再通过mutations同步处理。vuex做的其实是把职权明确了，责任细分了。所以它文档里也说，小系统可以不用。状态数据少，没有细分的必要。

通过这个图，我们很容易就对vuex的组成部分，以及vuex与组件(components)之间的联系一目了然。其实这张图，有点迷惑人，暂时看不懂也没关系，只要有一个直观的认识就行了。这张描述图就不用了![img](https://res.wx.qq.com/mpres/htmledition/images/icon/common/emotion_panel/emoji_wx/2_05.png?tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)，大家请往下看。

## 3. vuex 的核心概念

### 3.1 store

vuex 中最关键的是store对象，这是vuex的核心。可以说，vuex这个插件其实就是一个store对象，每个vue应用仅且仅有一个store对象。

#### 3.1.1 创建store

```
const store = new Vuex.Store({...});
```

可见，store是Vuex.Store这个构造函数new出来的实例。在构造函数中可以传一个对象参数。这个参数中可以包含5个对象：

- 1.state – 存放状态
- 2.getters – state的计算属性
- 3.mutations – 更改状态的逻辑，同步操作
- 4.actions – 提交mutation，异步操作
- 5.mudules – 将store模块化

关于store，需要先记住两点：

1. store 中存储的状态是响应式的，当组件从store中读取状态时，如果store中的状态发生了改变，那么相应的组件也会得到更新；

2. 不能直接改变store中的状态。改变store中的状态的唯一途径是提交(commit)mutations。这样使得我们可以方便地跟踪每一个状态的变化。

#### 3.1.2 一个完整的store的结构是这样的

```
const store = new Vuex.Store({
  state: {
    // 存放状态
  },
  getters: {
    // state的计算属性
  },
  mutations: {
    // 更改state中状态的逻辑，同步操作
  },
  actions: {
    // 提交mutation，异步操作
  },
  // 如果将store分成一个个的模块的话，则需要用到modules。
   //然后在每一个module中写state, getters, mutations, actions等。
  modules: {
    a: moduleA,
    b: moduleB,
    // ...
  }
});
```

### 3.2 state

state上存放的，说的简单一些就是变量，也就是所谓的状态。没有使用 state 的时候，我们都是直接在 data 中进行初始化的，但是有了 state 之后，我们就把 data 上的数据转移到 state 上去了。另外有些状态是组件私有的状态，称为组件的局部状态，我们不需要把这部分状态放在store中去。

#### 3.2.1 如何在组件中获取vuex状态

由于vuex的状态是响应式的，所以从store中读取状态的的方法是在组件的计算属性中返回某个状态。

```
const Counter = {
  template: `<div>{{ count }}</div>`,
  computed: {
    count () {
      // 获取store中的状态
      return this.$store.state.count;
    }
  }
}
```

#### 3.2.2 mapState

当一个组件获取多种状态的时候，则在计算属性中要写多个函数。为了方便，可以使用mapState辅助函数来帮我们生成计算属性。

```
import { mapState } from  'vuex';
export default {
  // ...
  data (){
    localState: 1
  }
  computed: mapState({
    // 此处的state即为store里面的state
    count: state => state.count,
    // 当计算属性的名称与state的状态名称一样时，可以省写
    // 映射 this.count1 为 store.state.count1
    count1,
    //'count'等同于 ‘state => state.count’
    countAlias: 'count',
    countPlus (state){
    // 使用普通函数是为了保证this指向组件对象
      return state.count + this.localState;
    }
  })
}
//上面是通过mapState的对象来赋值的，还可以通过mapState的数组来赋值
computed: mapState(['count']);
//这种方式很简洁，但是组件中的state的名称就跟store中映射过来的同名
```

对象扩展运算符

mapState 函数返回的是一个对象，为了将它里面的计算属性与组件本身的局部计算属性组合起来，需要用到对象扩展运算符。

```
computed: {
  localState () { 
  ... mapState ({
      
    })
  }
```

这样，mapState中的计算属性就与localState计算属性混合一起了。

### 3.3 getters

有时候我们需要从 store 中的 state 中派生出一些状态，例如对列表进行过滤并计数。此时可以用到getters，getters可以看作是store的计算属性，其参数为state。

```
const store = new Vuex.Store({
  state: {
    todos: [
      {id: 1, text: 'reading', done: true},
      {id: 2, text: 'playBastketball', done: false}
    ]
  },
  getters: {
    doneTodos: state => {
      return state.todos.filter(todo => todo.done);
    }
  }
});
```

#### 3.3.1 获取getters里面的状态，方法一

```
//在组件中，则要写在计算属性中，
computed: {
  doneTodos () {
    return this.$store.getters.doneTodos;
  }
}
```

#### 3.3.2 使用mapGetters获取getters里面的状态：方法二

```
import {mapState, mapGetters} from 'vuex';
computed: {
...mapState(['increment']),
...mapGetters(['doneTodos'])
}
```

### 3.4 mutations

mutations里面是如何更改state中状态的逻辑。更改Vuex中的state的唯一方法是，提交mutation，即store.commit(‘increment’)。

#### 3.4.1 提交载荷(payload)

可以向commit传入额外的参数，即mutation的载荷。

```
mutations: {
  increment(state, n){
    state.count += n;
  }
}
store.commit('increment', 10);
```

payload还可以是一个对象。

```
mutations: {
  increment(state, payload){
  state.count += payload.amount;
}
}
store.commit('increment', {amount: 10});
```

还可以使用type属性来提交mutation。

```
store.commit({
  type: 'increment',
  amount: 10
});
// mutations保持不变
mutations: {
  increment(state, payload){
    state.count += payload.amount;
  }
}
```

注意：mutation必须是同步函数，不能是异步的，这是为了调试的方便。



#### 3.4.2 在组件中提交mutations

那么mutation应该在哪里提交呢？ 因为js是基于事件驱动的，所以改变状态的逻辑肯定是由事件来驱动的，所以store.commit(‘increment’)是在组件的methods中来执行的。

方法1: 在组件的methods中提交

```
methods: {
  increment(){
    this.$store.commit('increment');
  }
}
```

方法2: 使用mapMutaions

用 mapMutations 辅助函数将组件中的 methods 映射为 store.commit 调用。

```
import { mapMutaions } from 'vuex';
export default {
  // ...
  methods: {
    ...mapMutaions([
    'increment' // 映射 this.increment() 为 this.$store.commit('increment')
  ]),
  ...mapMutaions([
      add: 'increment' // 映射 this.add() 为 this.$store.commit('increment')
    ])
    }
}

// 因为mutation相当于一个method，所以在组件中，可以这样来使用
<button @click="increment">+</button>
```

### 3.5 actions

因为mutations中只能是同步操作，但是在实际的项目中，会有异步操作，那么actions就是为了异步操作而设置的。这样，就变成了在action中去提交mutation，然后在组件的methods中去提交action。只是提交actions的时候使用的是dispatch函数，而mutations则是用commit函数。

#### 3.5.1 一个简单的action

```
const store = new Vuex.Store({
  state: {
    count: 0
  },
  mutations: {
    increment(state){
      state.count++;
    }
  },
  actions: {
    increment(context){
      context.commit('increment');
    }
    /* 可以用参数结构的方法来写action
     increment({commit}){
     commit('increment');
     }
     */
  }
});

// action函数接受一个context参数，这个context具有与store实例相同的方法和属性。

// 分发action
store.dispatch('increment');
```

action同样支持payload和对象方式来分发，格式跟commit是一样的，不再赘述。

#### 3.5.2 在组件中分发action

方法1: 在组件的methods中，使用this.$store.dispatch(‘increment’)。

方法2: 使用mapActions，跟mapMutations是类似的。

```
import { mapActions } from 'vuex'
export default {
  // ...
  methods: {
    ...mapActions([
    'increment' // 映射 this.increment() 为 this.$store.dispatch('increment')
  ]),
  ...mapActions({
  add: 'increment' // 映射 this.add() 为 this.$store.dispatch('increment')
})
}
}

// 同样在组件中，可以这样来使用
<button @click="increment">+</button>
```

#### 3.5.3 组合actions

因为action是异步的，那么我们需要知道这个异步函数什么时候结束，以及等到其执行后，会利用某个action的结果。这个可以使用promise来实现。在一个action中返回一个promise，然后使用then()回调函数来处理这个action返回的结果。

```
actions:{
  actionA({commit}){
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        commit('someMutation');
        resolve();
      },1000);
    })
  }
}

// 这样就可以操作actionA返回的结果了
store.dispatch('actionA').then(() => {
  // dosomething ...
});

// 也可以在另一个action中使用actionA的结果
actions: {
  // ...
  actionB({ dispatch, commit }){
    return dispatch('actionA').then(() => {
      commit('someOtherMutation');
    })
  }
}
```

## 4 mudules

module是为了将store拆分后的一个个小模块，这么做的目的是因为当store很大的时候，分成模块的话，方便管理。

### 4.1 每个module拥有自己的state, getters, mutation, action

```
const moduleA = {
    state: {...},
    getters: {...},
    mutations: {....},
  actions: {...}
}

const moduleB = {
    state: {...},
    getters: {...},
    mutations: {....},
  actions: {...}
}

const store = new Vuex.Store({
  modules: {
    a: moduleA,
    b: moduleB
  }
});

store.state.a // 获取moduleA的状态
store.state.b // 获取moduleB的状态
```

### 4.2 模块内部的状态

对于模块内部的mutation和getter，接受的第一个参数是模块的局部状态state。顺便说一下，根结点的状态为rootState。

```
const moduleA = {
  state: { count: 0},
  getters: {
    doubleCount(state){
      return state.count * 2;
    }
  },
  mutations: {
    increment(state){
      state.count ++ ;
    }
  },
  actions: {...}
}
```

### 4.3 模块的动态注册

在模块创建之后，可以使用store.registerModule方法来注册模块。

```
store.registerModule('myModule', {
  // ...
});
```

依然的，可以通过store.state.myModule来获取模块的状态。

可以使用store.unregisterModule(moduleName)来动态的卸载模块，但是这种方法对于静态模块是无效的（即在创建store时声明的模块）。

## 5 含有vuex的项目的结构

### 5.1 应该遵循的规则

1. 应用层级的状态都应该集中在store中

2. 提交 mutation 是更改状态state的唯一方式，并且这个过程是同步的。

3. 异步的操作应该都放在action里面