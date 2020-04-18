---
title: CTRL C失效修复方法
top: false
comments: true
abbrlink: c42bcc71
date: 2020-04-04 17:24:42
categories:
tags:
---

方法一：在运行窗口重新注册以下DLL文件。 
regsvr32 Shdocvw.dll 
regsvr32 Shell32.dll （注意这个命令，先不用输） 
regsvr32 Oleaut32.dll 
regsvr32 Actxprxy.dll 
regsvr32 Mshtml.dll 
regsvr32 Urlmon.dll 

<!-- more -->

第二个命令可以先不用输，输完这些命令后重新启动windows，如果发现无效，再 
重新输入一遍，这次输入第二个命令。 

方法二：COMCTL32.DLL文件产生的问题。 
在升级IE或windows时这个文件可能被替换了，也许新版本的COMCTL32.DLL文件有 
BUG。 
找一张windows安装光盘，搜索它，找到一个名为COMCTL32.DL_的文件，把它拷贝 
出来，用 winrar提取 这个文件为COMCTL32.DLL文件，并覆盖现有文件。

