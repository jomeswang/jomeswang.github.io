---
title: 以太链上发行自己的代币Token
top: false
comments: true
categories:
  - 区块链
tags:
  - 区块链
  - 以太链开发
abbrlink: 4f7564f
date: 2021-02-13 16:18:33
---

> 最近币圈随便发行的币太多了，都不知道什么币有什么的一个价值，所以自己亲自来尝试以下，发币的一个流程。

<!--more-->

## 一： 流程介绍

1. 创建自己的钱包
2. 编写智能合约
3. 部署智能合约
4. 添加和接受代币

智能合约地址:  https://github.com/jomeswang/solidity_learning/blob/master/Constrast/simple_erc20_constrast.sol

小狐狸钱包官网： https://metamask.io/

智能合约查询网站： https://blockexplorer.one/eth/ropsten

以太坊编译器： https://remix.ethereum.org/



## 二： 创建自己的一个MetaMask 钱包

安装 MetaMask 插件（使用谷歌浏览器f）需要fq： https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=zh-CN

![](https://photo.jomeswang.top/20210213170032.png)

安装之后 然后他会弹出一个页面，点击确认进入来进入到这一个页面之后 ，之后点击下面的 创建钱包的这一个按钮。

![](https://photo.jomeswang.top/20210213170301.png)

然后点击I agree，进入到设置密码的阶段。

![](https://photo.jomeswang.top/20210213170532.png)

**注意：必须把下述的这一个密语复制 并且 妥善的保存下来（这是你账户的唯一凭证）**

![](https://photo.jomeswang.top/20210213170546.png)

之后会让你重新输入这一个密语。

这就算 将 注册钱包的这一个流程完成啦！！！



## 三： 编写智能合约

智能合约地址:  https://github.com/jomeswang/solidity_learning/blob/master/Constrast/simple_erc20_constrast.sol

打开这一个地址然后复制里面的一个代码：

![](https://photo.jomeswang.top/20210213172459.png)



## 四： 部署智能合约

由于部署合约需要一定的GAS 费用，因此我们先在 测试网络上获取需要的测试ETF。

![](https://photo.jomeswang.top/20210213173336.png)

![](https://photo.jomeswang.top/20210213173426.png)

![](https://photo.jomeswang.top/20210213173442.png)

![](https://photo.jomeswang.top/20210213173514.png)

然后看到下面 transactions  出现记录之后，就阔以耐心等待了，之后等3-5 分钟之后点击 刚刚那一个小猫咪插件 就阔以看到 我们已经有了 1个ETF（虽然是在测试网络上的）

![](https://photo.jomeswang.top/20210213174244.png)



以太坊编译器： https://remix.ethereum.org/

打开这一个网站

![](https://photo.jomeswang.top/20210213173055.png)

之后编译代码

![](https://photo.jomeswang.top/20210213181147.png)

之后部署在测试链上去

![](https://photo.jomeswang.top/20210213182029.png)

发现右边有这一个说明成功部署好了

![](https://photo.jomeswang.top/20210213182213.png)



## 六： 添加代币

左下角有这一个出现

![](https://photo.jomeswang.top/20210213182412.png)

复制后要在 metamask 钱包中添加这一个代币

![](https://photo.jomeswang.top/20210213182454.png)

![](https://photo.jomeswang.top/20210213182618.png)

![](https://photo.jomeswang.top/20210213182638.png)

有啦！！！！

![](https://photo.jomeswang.top/20210213182707.png)

成功导入 ！！！！

发现整一个发布代币的流程非常简单。。。。。。 而且代币还有更简单的一个发布手段，代币做起来不难，主要是看代币背后的团队以及项目靠不靠谱，在2021的这一个大牛市时保持一番对币的清晰认识，这总归是我们这一群开发者所要做的事情，为大家解开发币的神秘面纱，普及区块链概念，让更多人了解区块链，认识区块链，看到区块链给我们生活带来的改变。