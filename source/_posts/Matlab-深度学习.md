---
title: Matlab 深度学习
top: false
comments: true
categories:
  - Matlab
tags:
  - Matlab
  - Deep Learning
abbrlink: 4ca17e7a
date: 2020-06-29 23:40:37
---

> 入坑 MATLAB 进行深度学习

<!--more--->

## 一：摄像头

### 1.1   两种获取摄像头的方式

Matlab自身不支持直接读取摄像头数据，需要安装硬件支持包才可以获取，目前常用的有两个包：

![](http://photo.jomeswang.top/20200625234633.png)

第一个是 MATLAB Support Package for USB Webcams，这个包可以获取任何USB摄像头的图像（UVC），也可以获取电脑自带摄像头的数据，兼容 R2014a 到 R2020a 的版本。

第二个是Image Acquisition Toolbox Support Package for OS Generic Video Interface，更加通用，它也兼容 R2014a 到 R2020a 的版本。（推荐）

点击获取附加功能中的获取硬件支持包（安装适合的包）：

![](http://photo.jomeswang.top/20200625234839.png)

### 1.2   第一种方法摄像头的使用（webcams）

#### 1.2.1   查看当前摄像头设备列表

```
webcamlist
```

![](http://photo.jomeswang.top/20200626004325.png)


需要注意，使用webcam的时候，下标从1开始，1对应USB Camera，2对应Integrated Camera。

#### 1.2.2    获取视频对象

一行代码即可获取，非常舒服，比如获取外接USB摄像头的输入对象：

```
cam1 = webcam(1)
```

![](http://photo.jomeswang.top/20200626004407.png)

同样可以获取电脑自带摄像头的输入对象：

```
cam1 = webcam(2)
```


![](http://photo.jomeswang.top/20200626004416.png)

#### 1.2.3    预览视频对象

使用如下命令即可预览视频对象，该函数会自动打开一个窗口，播放摄像头画面：

```
preview(cam1)
```

#### 1.2.4   查看摄像头支持的分辨率并修改：

```
<刚刚获取的设备对象>.AvailableResolutions
```

然后根据修改为需要的分辨率：

![](http://photo.jomeswang.top/20200626004458.png)

再次preview之后即可看到分辨率改变。

#### 1.2.5   用完之后清除对象

```
clear <刚刚获取的对象>
```

#### 1.2.6    拍照（抓取画面）

```
mypic = snapshot(cam1);
imshow(mypic);
```



### 1.3   第二种方法摄像头的使用（Image Acquisition Toolbox）

#### 1.3.1    首先执行这条命令打开摄像头，测试是否可以调用videoinput函数：

```
video_source = videoinput('winvideo',1)
```

如果出现图中的错误，那么恭喜你，需要手动安装硬件支持包了。

![](http://photo.jomeswang.top/20200626004837.png)

#### 1.3.2   查看电脑上已经安装的图像适配器

```
imaqhwinfo()
```

![](http://photo.jomeswang.top/20200626004915.png)

其中InstalledAdaptors的值给出了当前电脑上已经安装的摄像头适配器个数，这里我的电脑上只有一个：winvideo。

#### 1.3.3    查看摄像头设备具体参数

使用该命令查看上一步获取到的图像适配器的具体参数：

```
win_info = imaqhwinfo('winvideo')
```

![](http://photo.jomeswang.top/20200626005159.png)

可以看到其中给出了该图像适配器具体的一些参数，特别需要注意的是，该函数返回了连接在当前图像适配器winvideo上的所有摄像头的设备ID和设备信息！

当前我的电脑上一共有两个摄像头，一个是笔记本电脑内置的摄像头，另一个是我连接的USB 2.0 摄像头，接下来以USB摄像头为例，说明如何查看摄像头的设备ID和具体信息：

在工作区找到保存信息的变量win_info，双击查看其值：

![](http://photo.jomeswang.top/20200626083926.png)

可以看到，两个摄像头的设备ID分别为1和2，一般来说，电脑内置的摄像头的ID为1。

同样，双击win_info.DeviceInfo变量，可以查看摄像头的具体参数：

![](http://photo.jomeswang.top/20200626083944.png)

#### 1.3.4    创建视频输入对象

使用如下的命令来创建一个视频输入对象：

```
video_obj = videoinput(adaptorname,deviceID,format)
```

该函数的三个参数说明如下：

+ adaptorname：适配器名称（必须）
+ deviceID：设备ID号（必须）
+ format：视频采集格式（不填写则使用默认）
  如下，我要创建USB摄像头的视频输入对象：

```
video_obj = videoinput('winvideo',2)
```

![](http://photo.jomeswang.top/20200626084122.png)

#### 1.3.5    预览视频对象

使用如下命令即可预览视频对象，该函数会自动打开一个窗口，播放摄像头画面：

```
preview(video_obj)
```

#### 1.3.6     捕抓画面

```
mypic = getsnapshot(video_obj);
imshow(mypic);
```



## 二： 迁移学习

> AlexNet已经训练了超过100万张图片，可以将图片分类为1000个对象类别(如键盘、咖啡杯、铅笔和许多动物)。该网络已经学习了大量图像的丰富特征表示。该网络以一幅图像作为输入，并输出图像中对象的标签以及每个对象类别的概率。

### 2.1 首先安装相应的包

`Deep Learning Toobox Model for Alexnet Network`

![](http://photo.jomeswang.top/20200626171932.png)

### 2.2 使用方法

![](http://photo.jomeswang.top/20200626172036.png)

### 2.3  加载数据集

需要先将数据标注好，即在一个文件夹下放多个标签名字的文件夹，里面有相应的图片。

```
%  使用数据集函数载入并标记数据
imds = imageDatastore('MerchData', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
    
% 分离训练数据和测试数据
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');

```

### 2.4  加载训练网络

```
net = alexnet;
%  取出网络所需的图片大小
inputSize = net.Layers(1).InputSize

```

其中图片的大小有限制，不同的网络不一样。Alexnet  的限制是227 227 3.

方法一（推荐）：

```
pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);

%  训练数据
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);
    
% 测试数据
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

```

方法二： 使用imresize  方法改变大小

```
% This file in order to change the photo size into the fit size

source_files = "Answer";

imds = imageDatastore(source_files, 'IncludeSubFolders', true, 'LabelSource', 'foldernames');
lens = length(imds.Labels);
% lens = 2;

% imshow(readimage(imds, 2))
for i=1:lens
    dir = char(imds.Files(i));
    img=imresize(readimage(imds, i),[227,227]);
    imwrite(img, dir);
    i
end

disp("All thing has been done successfully!")
```



### 2.5  取代最后一层

预训练的网络的最后三层被配置为1000个类。这三层必须针对新的分类问题进行微调。从预先训练好的网络中提取除后三层之外的所有层。

```
layersTransfer = net.Layers(1:end-3);
numClasses = numel(categories(imdsTrain.Labels))
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];
```



### 2.6 训练网络

```
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

% 开始训练网络
netTransfer = trainNetwork(augimdsTrain,layers,options);

```



### 2.7 验证网络

```
[YPred,scores] = classify(net,augimdsValidation);
% YPred 含最大可能分类，  scores 含各个分类的可能概率值

% 测试网络的准确性
YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation)
```



## 三：计算机视觉

### 3.1  摄像头处理数据

```
vidobj = videoinput('winvideo',1); %capture the device handle


set(vidobj, 'FramesPerTrigger',1); % each time we call trigger one frame gets captured
set(vidobj, 'TriggerRepeat',inf); % we can have infinite triggers

triggerconfig(vidobj, 'manual'); % the trigger will be called manually. We can also set times for the same
start(vidobj); % start the device capture

% 采集每一帧的数据
trigger(vidobj); % capture one frame
im=getdata(vidobj); % frame is a matrix that stores the frame
%     im = getsnapshot(cam);
image(ax1,im);
```

