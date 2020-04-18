---
title: python 的文件操作os和正则表达式re
top: false
comments: true
categories:
  - python
tags:
  - python_os
  - python_re
abbrlink: 608ff6ff
date: 2020-04-05 15:53:35
---

## 一：前言

最近在学爬虫，需要用到文件操作来存储数据，和用正则表达式来对数据进行挑选，

因此使用python的os库来进行文件操作和正则表达式库re来进行

<!-- more -->

## 二：步骤

### 2.1 使用os库来进行文件操作

####  2.1.1	读文件

在 Python 中，读文件主要分为三个步骤：

- 打开文件
- 读取内容
- 关闭文件

一般使用形式如下：

```python
try:
    f = open('/path/to/file', 'r')    # 打开文件
    data = f.read()                   # 读取文件内容
finally:
    if f:
        f.close()                     # 确保文件被关闭
```

注意到，我们在代码中加了 `try...finally`，这是因为，如果打开和读取文件时出现错误，文件就没有被关闭。为了确保在任何情况下，文件都能被关闭，我们加了 `try...finally`。

上面的代码中，'r' 模式表示读模式，`open` 函数的常用模式主要有：

| ‘r'  |                读模式                |
| :--: | :----------------------------------: |
| ‘w'  |                写模式                |
| ‘a'  |               追加模式               |
| ‘b'  | 二进制模式（可添加到其他模式中使用） |
| ‘+'  | 读/写模式（可添加到其他模式中使用）  |

上面的读文件做法很繁琐，我们可以使用 Python 的 `with` 语句来帮我们自动调用 `close` 方法：

```python
with open('/path/to/file', 'r', encoding = 'utf-8') as f:
    data = f.read()
```

可以看到，这种方式很简洁，而且还能在出现异常的情况下自动关闭文件。

通常而言，读取文件有以下几种方式：

- 一次性读取所有内容，使用 `read()` 或 `readlines()`；
- 按字节读取，使用 `read(size)`；
- 按行读取，使用 `readline()`；

#### 2.1.2   读取所有内容

读取所有内容可以使用 `read()` 或 `readlines()`。我们在上面已经介绍过 `read()` 了，现在，让我们看看 `readlines()`。

`readlines()` 方法会把文件读入一个字符串列表，在列表中每个字符串就是一行。

假设有一个文件 data.txt，它的文件内容如下（数字之间的间隔符是'\t'）：

```python
10  1   9   9
6   3   2   8
20  10  3   23
1   4   1   10
10  8   6   3
10  2   1   6
```

我们使用 `readlines()` 将文件读入一个字符串列表：

```python
with open('data.txt', 'r') as f:
    lines = f.readlines()
    line_num = len(lines)
    print lines
    print line_num
```

执行结果：

```
['10\t1\t9\t9\n', '6\t3\t2\t8\n', '20\t10\t3\t23\n', '1\t4\t1\t10\n', '10\t8\t6\t3\n', '10\t2\t1\t6']
6
```

可以看到，列表中的每个元素都是一个字符串，刚好对应文件中的每一行。

#### 2.1.3   按字节读取

如果文件较小，一次性读取所有内容确实比较方便。但是，如果文件很大，比如有 100G，那就不能一次性读取所有内容了。这时，我们构造一个固定长度的缓冲区，来不断读取文件内容。

看看例子：

```python
with open('path/to/file', 'r') as f:
    while True:
        piece = f.read(1024)        # 每次读取 1024 个字节（即 1 KB）的内容
        if not piece:
            break
        print piece
```

在上面，我们使用 `f.read(1024)` 来每次读取 1024 个字节（1KB） 的文件内容，将其存到 piece，再对 piece 进行处理。

事实上，我们还可以结合 yield 来使用：

```python
def read_in_chunks(file_object, chunk_size=1024):
    """Lazy function (generator) to read a file piece by piece.
    Default chunk size: 1k."""
    while True:
        data = file_object.read(chunk_size)
        if not data:
            break
        yield data

with open('path/to/file', 'r') as f:
    for piece in read_in_chunks(f):
        print piece
```

#### 2.1.4    逐行读取

在某些情况下，我们希望逐行读取文件，这时可以使用 `readline()` 方法。

看看例子：

```python
with open('data.txt', 'r') as f:
    while True:
        line = f.readline()     # 逐行读取
        if not line:
            break
        print line,             # 这里加了 ',' 是为了避免 print 自动换行
```

执行结果：

```
10  1   9   9
6   3   2   8
20  10  3   23
1   4   1   10
10  8   6   3
10  2   1   6
```

#### 2.1.5    文件迭代器

在 Python 中，**文件对象是可迭代的**，这意味着我们可以直接在 for 循环中使用它们，而且是逐行迭代的，也就是说，效果和 `readline()` 是一样的，而且更简洁。

看看例子：

```python
with open('data.txt', 'r') as f:
    for line in f:
        print line,
```

在上面的代码中，f 就是一个文件迭代器，因此我们可以直接使用 `for line in f`，它是逐行迭代的。

看看执行结果：

```python
10  1   9   9
6   3   2   8
20  10  3   23
1   4   1   10
10  8   6   3
10  2   1   6
```

再看一个例子：

```python
with open(file_path, 'r') as f:
    lines = list(f)
    print lines
```

执行结果：

```python
['10\t1\t9\t9\n', '6\t3\t2\t8\n', '20\t10\t3\t23\n', '1\t4\t1\t10\n', '10\t8\t6\t3\n', '10\t2\t1\t6']
```

可以看到，我们可以对文件迭代器执行和普通迭代器相同的操作，比如上面使用 `list(open(filename))` 将 f 转为一个字符串列表，这样所达到的效果和使用 `readlines` 是一样的。

#### 2.1.6   写文件

写文件使用 `write` 方法，如下：

```python
with open('/Users/ethan/data2.txt', 'w') as f:
    f.write('one\n')
    f.write('two')
```

- 如果上述文件已存在，则会清空原内容并覆盖掉；
- 如果上述路径是正确的（比如存在 /Users/ethan 的路径），但是文件不存在（data2.txt 不存在），则会新建一个文件，并写入上述内容；
- 如果上述路径是不正确的（比如将路径写成 /Users/eth ），这时会抛出 IOError；

如果我们想往已存在的文件追加内容，可以使用 'a' 模式，如下：

```python
with open('/Users/ethan/data2.txt', 'a') as f:
    f.write('three\n')
    f.write('four')
```

#### 2.1.7	小结

- 推荐使用 with 语句操作文件 IO。
- 如果文件较大，可以按字节读取或按行读取。
- 使用文件迭代器进行逐行迭代。

#### 2.1.8 os模块操作文件

 Python 的 os 模块封装了常见的文件和目录操作，本文只列出部分常用的方法，更多的方法可以查看[官方文档](https://docs.python.org/3/library/os.path.html)。 

下面是部分常见的用法：

|       方法       |             说明             |
| :--------------: | :--------------------------: |
|     os.mkdir     |           创建目录           |
|     os.rmdir     |           删除目录           |
|    os.rename     |            重命名            |
|    os.remove     |           删除文件           |
|    os.getcwd     |       获取当前工作路径       |
|     os.walk      |           遍历目录           |
|   os.path.join   |       连接目录与文件名       |
|  os.path.split   |       分割文件名与目录       |
| os.path.abspath  |         获取绝对路径         |
| os.path.dirname  |           获取路径           |
| os.path.basename |     获取文件名或文件夹名     |
| os.path.splitext |      分离文件名与扩展名      |
|  os.path.isfile  | 判断给出的路径是否是一个文件 |
|  os.path.isdir   | 判断给出的路径是否是一个目录 |

下面给出几种常见的用法:

```
 bk_dir = os.path.join('123', '234') #可以创建多级目录的路径，拼接路径
 if not os.path.exists(bk_dir): # 判断是否存在，不存在就创建，
    os.mkdir(bk_dir)
```

### 2.2 使用re正则表达式进行正则匹配

正则表达式就是描述一种字符串匹配模式的表达式
可以用来检查一个串是否含有某种子串、将匹配的子串替换或者从某个串中取出符合某个条件的子串等。

**在编写处理字符串的程序或者网页时会频繁使用，比如爬虫**

![](http://photo.jomeswang.top/20200405175109.png)

#### 2.2.1 反斜杠的困扰

有一点需要特别注意的是，正则表达式使用 `\` 对特殊字符进行转义，比如，为了匹配字符串 'python.org'，我们需要使用正则表达式 `'python\.org'`，而 Python 的字符串本身也用 `\` 转义，所以上面的正则表达式在 Python 中应该写成 `'python\\.org'`，这会很容易陷入 `\` 的困扰中，因此，我们建议使用 Python 的原始字符串，只需加一个 r 前缀，上面的正则表达式可以写成：

```
r'python\.org'
```

#### 2.2.2 re模块的使用方法

使用 re 模块有两种方式：

- 使用 re.compile 函数生成一个 Pattern 对象，然后使用 Pattern 对象的一系列方法对文本进行匹配查找；
- 直接使用 re.match, re.search 和 re.findall 等函数直接对文本匹配查找；![](http://photo.jomeswang.top/20200405182701.png)

我比较喜欢第二种写法，所以就用第二种写法写这篇博客

#### 2.2.3  安装并导入re

```
pip install re
```

```
# 在文件中使用
import re
```

#### 2.2.4 re的语法(pattern 是正则表达式)

1. re.findall(pattern, string[, flags])

   **findall 以列表形式返回全部能匹配的子串，# 如果没有匹配，则返回一个空列表。**

2.  re.match(pattern, string[, flags]):

   **match 方法用于查找字符串的头部（也可以指定起始位置），它是一次匹配，只要找到了一个匹配的结果就返回， 而不是查找所有匹配的结果。它的一般使用形式如下：**

   ![](http://photo.jomeswang.top/20200405183810.png)

   3.  re.sub(pattern, repl, string[, count])

   `count 用于指定最多替换次数，不指定时全部替换。`

   `pattern：匹配正则表达式`

   `repl:  匹配后替换的字符串`

   `string： 要被匹配的字符串`

   4. re.subn(pattern, repl, string[, count])

   `subn 方法跟 sub 方法的行为类似，也用于替换。它的使用形式如下：`

   ![](http://photo.jomeswang.top/20200405192351.png)



参考链接：

 https://wiki.jikexueyuan.com/project/explore-python/File-Directory/text_file_io.html 