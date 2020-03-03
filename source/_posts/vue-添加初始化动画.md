---
title: vue 添加初始化动画
top: false
comments: true
categories:
  - vue
tags:
  - vue
abbrlink: d43325e4
date: 2020-03-01 15:58:54
---

 这个蛮简单的，蛮写一下
思路：在index.html文件的body中写一个id为Loading的div，然后再created生命周期的时候判断这个div是否存在，存在的话就移除。（建议用css写动画，减少资源占用） 

<!-- more -->

```
created: function(){
        document.body.removeChild(document.getElementById('Loading'));
    },

```

html内容如下

```
<!--加载中的动画-->
  <div id="Loading">
      <div class="loader-inner ball-beat">
          <div></div>
          <div></div>
          <div></div>
      </div>
  </div>

```

 附小动画样式代码： 

    <!-- 加载动画样式控制 -->
    <style type="text/css">
        #Loading {
            top:50%;
            left:50%;
            position: absolute;
            -webkit-transform: translateY(-50%)  translateX(-50%);
            transform: translateY(-50%)  translateX(-50%);
            z-index:100;
        }
        @-webkit-keyframes ball-beat {
            50% {
                opacity: 0.2;
                -webkit-transform: scale(0.75);
                transform: scale(0.75); }
                100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1); } }
    
        @keyframes ball-beat {
            50% {
                opacity: 0.2;
                -webkit-transform: scale(0.75);
                transform: scale(0.75); }
    
            100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1); } }
    
        .ball-beat > div {
            background-color: #5D9BFF;
            width: 15px;
            height: 15px;
            border-radius: 100% !important;
            margin: 2px;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
            display: inline-block;
            -webkit-animation: ball-beat 0.7s 0s infinite linear;
            animation: ball-beat 0.7s 0s infinite linear; }
        .ball-beat > div:nth-child(2n-1) {
            -webkit-animation-delay: 0.35s !important;
            animation-delay: 0.35s !important; }
    </style>
