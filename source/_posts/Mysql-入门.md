---
title: Mysql 入门
top: false
comments: true
categories:
  - mysql
tags:
  - mysql
abbrlink: e72df9ae
date: 2020-07-03 14:20:30
---



> ### 数据库就是一种特殊的文件，其中存储着需要的数据

<!--more-->

## 一：操作数据库

### 1.1   命令行  连接 

```
mysql -uroot -p
回车后输入密码，当前设置的密码为mysql
```



### 1.2  查看所有数据库

```
show databases;
```



### 1.3 使用数据库

```
use 数据库名;
```



### 1.4 查看当前使用的数据库

```
select database();
```



### 1.5   创建数据库

```
create database 数据库名 charset=utf8;
例：
create database python charset=utf8;
```



### 1.6   删除数据库

```
drop database 数据库名;
例：
drop database python;
```



## 二：数据表操作

### 2.1  查看当前数据库中所有表

```
show tables;
```



### 2.2  查看表结构

```
desc 表名;
```



### 2.3 创建表

```
例：创建班级表

create table classes(
    id int unsigned auto_increment primary key not null,
    name varchar(10)
);
```



### 2.4  修改表-添加字段

```
alter table 表名 add 列名 类型;
例：
alter table students add birthday datetime;
```



### 2.5  修改表-修改字段：重命名版

```
alter table 表名 change 原名 新名 类型及约束;
例：
alter table students change birthday birth datetime not null;
```



### 2.6  修改表-修改字段：不重命名版

```
alter table 表名 modify 列名 类型及约束;
例：
alter table students modify birth date not null;
```



### 2.7  修改表-删除字段

```
alter table 表名 drop 列名;
例：
alter table students drop birthday;
```



### 2.8 删除表

```
drop table 表名;
例：
drop table students;
```



### 2.9  查看表的创建语句

```
show create table 表名;
例：
show create table classes;
```



## 三 .  MySQL 查询

### 3.1 普通查询

- 查询所有字段

```sql
select * from 表名;
例：
select * from students;
```

- 查询指定字段

```sql
select 列1,列2,... from 表名;
例:
select name from students;
```

- 使用 as 给字段起别名

```sql
select id as 序号, name as 名字, gender as 性别 from students;
```

- 可以通过 as 给表起别名

```sql
-- 如果是单表查询 可以省略表明
select id, name, gender from students;

-- 表名.字段名
select students.id,students.name,students.gender from students;

-- 可以通过 as 给表起别名 
select s.id,s.name,s.gender from students as s;
```

- 在select后面列前使用distinct可以消除重复的行

```sql
select distinct 列1,... from 表名;
例：
select distinct gender from students;
```



### 3.2  条件查询

使用where子句对表中的数据筛选，结果为true的行会出现在结果集中

- 语法如下：

```sql
select * from 表名 where 条件;
例：
select * from students where id=1;
```

- where后面支持多种运算符，进行条件的处理

  - 比较运算符 = > >= < <= != <> 

  - 逻辑运算符 and or not

  - 模糊查询  like  

    - %表示任意多个任意字符

    - _表示一个任意字符

      ```
      select * from students where name like '黄%' or name like '%靖';
      ```

  - 范围查询

    - in表示在一个非连续的范围内

      ```
      select * from students where id in(1,3,8);
      ```

    - between ... and ...表示在一个连续的范围内

      ```
      select * from students where id between 3 and 8;
      ```

    

  - 空判断   **判空is null**

    ```
    select * from students where height is null;
    ```

**优先级**

+ 优先级由高到低的顺序为：小括号，not，比较运算符，逻辑运算符



### 3.3 排序查询

为了方便查看数据，可以对数据进行排序

```sql
select * from 表名 order by 列1 asc|desc [,列2 asc|desc,...]
```

##### 说明

- 将行数据按照列1进行排序，如果某些行列1的值相同时，则按照列2排序，以此类推
- 默认按照列值从小到大排列（asc）
- asc从小到大排列，即升序
- desc从大到小排序，即降序

例：显示所有的学生信息，先按照年龄从大-->小排序，当年龄相同时 按照身高从高-->矮排序

```sql
select * from students  order by age desc,height desc;
```



### 3.4  聚合函数

+ count(*)表示计算总行数，括号中写星与列名，结果是相同的

+ max(列)表示求此列的最大值

+ min(列)表示求此列的最小值

+ sum(列)表示求此列的和

+ avg(列)表示求此列的平均值

```
select count(*) from students;
```



### 3.5  分组

+ group by的含义:将查询结果按照1个或多个字段进行分组，字段值相同的为一组

+ **group by + group_concat()**
  + group_concat(字段名)可以作为一个输出字段来使用，
  + 表示分组之后，根据分组结果，使用group_concat()来放置每一组的某字段的值的集合

+ ### group by + 集合函数

  + 通过group_concat()的启发，我们既然可以统计出每个分组的某字段的值的集合，那么我们也可以通过集合函数来对这个`值的集合`做一些操作

+ ### group by + having

  + having 条件表达式：用来分组查询后指定一些条件来输出查询结果
  + having作用和where一样，但having只能用于group by

+ ### group by + with rollup

  + with rollup的作用是：在最后新增一行，来记录当前列里所有记录的总和

```
select gender,group_concat(id) from students group by gender;
+--------+------------------+
| gender | group_concat(id) |
+--------+------------------+
| 男     | 3,4,8,9,14       |
| 女     | 1,2,5,7,10,12,13 |
| 中性   | 11               |
| 保密   | 6                |
+--------+------------------+

分别统计性别为男/女的人年龄平均值
select gender,avg(age) from students group by gender;
+--------+----------+
| gender | avg(age) |
+--------+----------+
| 男     |  32.6000 |
| 女     |  23.2857 |
| 中性   |  33.0000 |
| 保密   |  28.0000 |
+--------+----------+

select gender,count(*) from students group by gender having count(*)>2;
+--------+----------+
| gender | count(*) |
+--------+----------+
| 男     |        5 |
| 女     |        7 |
+--------+----------+

select gender,count(*) from students group by gender with rollup;
+--------+----------+
| gender | count(*) |
+--------+----------+
| 男     |        5 |
| 女     |        7 |
| 中性   |        1 |
| 保密   |        1 |
| NULL   |       14 |
+--------+----------+
```



### 3.6 分页

当数据量过大时，在一页中查看数据是一件非常麻烦的事情

#### 语法

```sql
select * from 表名 limit start,count
```

#### 说明

- 从start开始，获取count条数据

例1：查询前3行男生信息

```sql
select * from students where gender=1 limit 0,3;
```



### 3.7   总结

**查询的完整格式 ^_*^ 不要被吓到 其实很简单 !* _ !**

```sql
SELECT select_expr [,select_expr,...] [      
      FROM tb_name
      [WHERE 条件判断]
      [GROUP BY {col_name | postion} [ASC | DESC], ...] 
      [HAVING WHERE 条件判断]
      [ORDER BY {col_name|expr|postion} [ASC | DESC], ...]
      [ LIMIT {[offset,]rowcount | row_count OFFSET offset}]
]
```

- 完整的select语句

```sql
select distinct *
from 表名
where ....
group by ... having ...
order by ...
limit start,count
```

- 执行顺序为：
  - from 表名
  - where ....
  - group by ...
  - select distinct *
  - having ...
  - order by ...
  - limit start,count
- 实际使用中，只是语句中某些部分的组合，而不是全部



## 四：python 操作 MYSQL

![](http://photo.jomeswang.top/20200703155202.png)



### 4.1 引入模块

- 在py文件中引入pymysql模块

```python
from pymysql import *
```

### 4.2 Connection 对象

- 用于建立与数据库的连接
- 创建对象：调用connect()方法

```python
conn=connect(参数列表)
```

- 参数host：连接的mysql主机，如果本机是'localhost'
- 参数port：连接的mysql主机的端口，默认是3306
- 参数database：数据库的名称
- 参数user：连接的用户名
- 参数password：连接的密码
- 参数charset：通信采用的编码方式，推荐使用utf8

### 4.3 对象的方法

- close()关闭连接
- commit()提交
- cursor()返回Cursor对象，用于执行sql语句并获得结果

### 4.4 Cursor对象

- 用于执行sql语句，使用频度最高的语句为select、insert、update、delete
- 获取Cursor对象：调用Connection对象的cursor()方法

```python
cs1=conn.cursor()
```

### 4.5 对象的方法

- close()关闭
- execute(operation [, parameters ])执行语句，返回受影响的行数，主要用于执行insert、update、delete语句，也可以执行create、alter、drop等语句
- fetchone()执行查询语句时，获取查询结果集的第一个行数据，返回一个元组
- fetchall()执行查询时，获取结果集的所有行，一行构成一个元组，再将这些元组装入一个元组返回

### 4.6 对象的属性

- rowcount只读属性，表示最近一次execute()执行后受影响的行数
- connection获得当前连接对象



## 五：python mysql  增删改查

### 5.1 基础

```
from pymysql import *

def main():
    # 创建Connection连接
    conn = connect(host='localhost',port=3306,database='jing_dong',user='root',password='mysql',charset='utf8')
    # 获得Cursor对象
    cs1 = conn.cursor()
    # 执行insert语句，并返回受影响的行数：添加一条数据
    # 增加
    count = cs1.execute('insert into goods_cates(name) values("硬盘")')
    #打印受影响的行数
    print(count)

    count = cs1.execute('insert into goods_cates(name) values("光盘")')
    print(count)

    # # 更新
    # count = cs1.execute('update goods_cates set name="机械硬盘" where name="硬盘"')
    # # 删除
    # count = cs1.execute('delete from goods_cates where id=6')

    # 提交之前的操作，如果之前已经之执行过多次的execute，那么就都进行提交
    conn.commit()

    # 关闭Cursor对象
    cs1.close()
    # 关闭Connection对象
    conn.close()

if __name__ == '__main__':
    main()
```



### 5.2 查询一行数据

```py
from pymysql import *

def main():
    # 创建Connection连接
    conn = connect(host='localhost',port=3306,user='root',password='mysql',database='jing_dong',charset='utf8')
    # 获得Cursor对象
    cs1 = conn.cursor()
    # 执行select语句，并返回受影响的行数：查询一条数据
    count = cs1.execute('select id,name from goods where id>=4')
    # 打印受影响的行数
    print("查询到%d条数据:" % count)

    for i in range(count):
        # 获取查询的结果
        result = cs1.fetchone()
        # 打印查询的结果
        print(result)
        # 获取查询的结果

    # 关闭Cursor对象
    cs1.close()
    conn.close()

if __name__ == '__main__':
    main()
```



### 5.3  查询多行数据

```
from pymysql import *

def main():
    # 创建Connection连接
    conn = connect(host='localhost',port=3306,user='root',password='mysql',database='jing_dong',charset='utf8')
    # 获得Cursor对象
    cs1 = conn.cursor()
    # 执行select语句，并返回受影响的行数：查询一条数据
    count = cs1.execute('select id,name from goods where id>=4')
    # 打印受影响的行数
    print("查询到%d条数据:" % count)

    # for i in range(count):
    #     # 获取查询的结果
    #     result = cs1.fetchone()
    #     # 打印查询的结果
    #     print(result)
    #     # 获取查询的结果

    result = cs1.fetchall()
    print(result)

    # 关闭Cursor对象
    cs1.close()
    conn.close()

if __name__ == '__main__':
    main()
```

