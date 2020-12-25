---
title: JS实现深拷贝
top: false
comments: false
categories:
  - JS
tags:
  - JS
abbrlink: b83467fc
date: 2020-12-24 14:46:51
---

> 最近得学一下 

<!--more-->

## 一： 递归 复制法

```
let deepClone = (obj)=>{
// 1. 先判断 是否是 [] || {}, 不是 就返回
  if(!obj | typeof obj !== "object")
    return obj
 // 2. 初始化 objClone
  let objClone = Array.isArray(obj)?[]:{}
  for(key in obj){
    if(typeof obj[key] == "object")
      objClone[key] = deepClone(obj[key])
    else
      objClone[key] = obj[key];
  }
  return objClone
}

let arr = ["sf", 1, {"fsdf": "fsdf"}, [1,2,3]]
console.log(deepClone(arr));
```



## 二： JSON 方法

```
let obj = [56, 43]
let objClone = JSON.parse(JSON.stringify(obj));
console.log(objClone);
```



## 三： lodash 方法

```

//  在这里主要的是 析构 cloneDeep 函数 之后 重命名为 clone 函数
const {cloneDeep: clone }   = require('lodash')

let objA = {
    a: 1,
    b: {
        c: 2,
        d: {
            e: 3
        }
    }
}

// copy objA save as new variable objB
let objB = clone(objA)

// change the values in the original object objA
objA.a = 20
objA.b.c = 30
objA.b.d.e = 40

console.log(JSON.stringify(objA))
// → {"a":20,"b":{"c":30,"d":{"e":40}}}

// objB which is the cloned object is still the same
console.log(JSON.stringify(objB))
// → {"a":1,"b":{"c":2,"d":{"e":3}}}
```

