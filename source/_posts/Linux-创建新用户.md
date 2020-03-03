---
title: Linux Centos创建新用户
top: false
comments: true
categories:
  - Linux
tags:
  - Linux
abbrlink: ff24eac4
date: 2020-02-28 08:41:04
---

## 一：前言

感觉一直用root账户登录很不安全，因此创建一个新用户来进行日常的使用

<!-- more -->

## 二：步骤

### 2.1 新创建一个用户

```
adduser jomeswang
```

## `jomeswang`为我的用户名，你可以自行修改为自己的

### 2.2 创建 新用户的密码

```
passwd jomeswang
```

然后输入两次密码即可

### 2.3 对用户进行sudo授权

 个人用户的权限只可以在本home下有完整权限，其他目录要看别人授权。而经常需要root用户的权限，这时候sudo可以化身为root来操作。我记得我曾经sudo创建了文件，然后发现自己并没有读写权限，因为查看权限是root创建的。 

```
ls -l /etc/sudoers
-r-------- 1 root root 4251 9月  25 15:08 /etc/sudoers
```

只有读权限，然后为其添加写权限

```
chmod -v u+w /etc/sudoers
```

然后就可以写入内容了

```
vim /etc/sudoers
```

在下面的一行追加新增的用户

```
## Allow root to run any commands anywher  
root    ALL=(ALL)       ALL  
jomeswang    ALL=(ALL)       ALL  #这个是新增的用户
```

按:wq 保存，这时候记得将写权限收回

```
chmod -v u-w /etc/sudoers
```

这时候使用新用户登录，就可以使用sudo权限了

