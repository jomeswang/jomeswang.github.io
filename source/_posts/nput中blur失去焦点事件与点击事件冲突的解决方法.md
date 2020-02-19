---
title: input中blur失去焦点事件与点击事件冲突的解决方法（vue）
top: false
comments: true
categories:
  - vue
tags:
  - vue
  - js
abbrlink: a0e6a2de
date: 2020-02-19 21:53:46
---

## 一：前言

最近在做百度的下拉框时遇到一个问题就是在点击下拉框时，input失去焦点，从而是的下拉框消失，使得点击事件没有用，因此查阅资料得到答案。

<!-- more --->

## 二：步骤

 遇到一个问题，就是输入框input的blur事件与点击click事件的冲突了，在click的时候会先触发blur事件，没有触发click 

还有一种情况，下拉框blur和click事件冲突，导致不能正常选择值

原因：由于JavaScript为单线程，同一时间只能执行处理一个事件。“blur优先于click执行”。而在本示例中，由于blur处理程序，会将对下拉框展示区隐藏，所以导致其后续click事件并不会执行。

**解决方案1：对blur事件进行延迟，让click先执行。** 

```
 blurEvent(){
      setTimeout(()=>{this.rankSeen=false},300)//设置300ms后让下拉框消失
    },
```

**解决方案2：将click事件改为mousedown，让其优先于blur事件执行**

```
由@click="search(item.key)"
改为@mousedown"search(item.key)"
```

亲测这两种方法都可以解决这个问题。

 mousedown事件：当鼠标指针移动到元素上方，并按下鼠标按键时，会发生mousedown事件。

mouseup事件：当在元素上放松鼠标按钮时，会发生mouseup事件。 

### 注意： 

（1）mousedown与click 事件不同，mousedown事件仅需要按键被按下，而不需要松开即可发生。 

（2）mouseup与click事件不同，mouseup事件仅需要放松按钮。当鼠标指针位于元素上方时，放松鼠标按钮就会触发该事件。

其执行顺序为：mousedown >> mouseup >> click

参考网址：

 https://www.iteye.com/blog/570109268-2400122 

