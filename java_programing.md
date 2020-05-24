# IDEA使用
## 一、快速生成语句
- 快速生成main()方法：psvm
```java
    public static void main(String[] args) {
        
    }
```
- 快速生成输出语句：sout
```java
    System.out.println();
```

## 二、快捷键
- Ctrl+Alt+Space：代码提示和自动补全
- Ctrl+/：选中代码，单行注释
- Ctrl+Shift+/：选中代码，多行注释
- Ctrl+Alt+L：格式化
- Alt+Enter：快捷键导入包
- Ctrl+Alt+V：快速补全定义变量获得方法返回值
- Alt+Insert： 快速选择类成员构造函数和方法

# 一、java基础
## 1、变量
- 八种基本变量类型
> 整形

|类型|缺醒值|长度|范围|
|---|---|---|---|
|byte|0|8|-128~127|
|short|0|16|-32768~32767|
|int|0|32|~|
|long|0|64|~|

> 字符型

|类型|缺醒值|长度|范围|
|---|---|---|---|
|char|0|16|~|

> 浮点型

|类型|缺醒值|长度|范围|
|---|---|---|---|
|float|0|32||
|double|0|64|

> 布尔型

|类型|缺醒值|长度|范围|
|---|---|---|---|
|boolean|false|1|false/true|

- 字面值
> 整数字面值

```cpp
public class HelloWorld {
    public static void main(String[] args) {
        long val = 26L; //以L结尾的字面值表示long型
        int decVal = 26; //默认就是int型
        int hexVal = 0x1a; //16进制
        int oxVal = 032; //8进制
        int binVal = 0b11010; //2进制
        System.out.println(oxVal);
    }
}
```

> 浮点数字面值

当以f或者F结尾的时候，就表示一个float类型的浮点数，否则就是double类型（以d或者D结尾，写不写都可以）。   
浮点数还可以用E或者e表示（科学计数法）
e2表示10的二次方，即100
1.234e2 = 1.234x100 

> 字符和字符串字面值

字符的字面值放在单引号中    
字符串的字面值放在双引号中  
需要注意的是，\表示转义，比如需要表示制表符，回车换行，双引号等就需要用 \t \r \n \" 的方式进行

## 2、数据格式
- 数组
```java
    int [] arry;
    int arry [];
```
> 动态初始化：初始化指定长度，系统分配初始值
```java
    int [] arry = new int[3];
    //new申请内存空间
```
> 静态初始化：初始化指定初始值，分配初始值
```java
    int [] arry = new int[] {1，2，3};
    //new申请内存空间
```
> 数组遍历
```java
    for (int i = 0; i <arry.length ; i++){
            System.out.println(arry[i]);
    }
```
> 获取最值
```java
import java.util.Arrays;
    ...        
    Arrays.sort(arry);
    System.out.println(Arrays.toString(arry)+"\n");
```
- String
> new String 对象，JVM开辟新内存空间

> 以“ ”方式赋值新字符串，“ ”存在常量池，JVM本质只创建一个对象
```java
    String str = "abc";
    str.equals(str2);

    str.length();
```
- StringBuilder
> StringBuilder上的主要操作是append和insert方法，它们被重载以便接受任何类型的数据

## 3、方法
> 具有独立功能的代码块组成的整体
```java
    public static void method(int num) {
        
    }
```
> 带返回值方法
```java
    public static int method(int num) {
        ...
        return num;
    }
```
>方法重载
- 多个方法在同一个类中
- 多个方法具有相同的方法名
- 多个方法参数、类型或者数量不同
> 方法参数传递
- 对于引用类型的参数，形参改变实参也改变

> 成员变量和局部变量

|区别|成员变量|局部变量|
|---|---|---|
|类中位置不同|类中方法外|方法内或者方法形参|
|内存中位置不同|堆内存|栈内存|
|生命周期不同|随对象创建和消失|随方法调用创建和消失|
|初始化值不同|有默认初始值|无初始值，必须先定义后赋值|

## 4、构造方法
> 作用：创建对象，初始化成员变量
```java
public class StudenDemo {
    public static void main(String[] args{
        Student s =new Student();//构造函数
    }
}
```
```java
public class Studen {
    public student(参数) {
        //构造方法内书写的内容
    }
}
```
> 用户定义了构造方法，则不提供默认构造方法

## 5、this指针

## 6、封装
> 封装概述
- 面向对象三大原则之一（封装、继承、多态）
> 封装原则
- 隐藏成员变量，提供对应的方法
> 封装好处
- 提高代码安全性
- 提高代码复用性

## 7、API
> JDK-11-API文档的使用

## 8、集合
> 提供了存储空间可变的存储模型
- public class ArrayList<E>
- E - 此列表中的元素类型 
