# App启动前优化

###原因

自定义的动态库超过50个、或编译结果二进制文件超过30MB

####查看时间的方法

在Xcode的菜单中选择`Project`→`Scheme`→`Edit Scheme...`，然后找到 `Run` → `Environment Variables` →`+`，添加name为`DYLD_PRINT_STATISTICSvalue`为`1`的环境变量

但是我试验了一把,没有拿到对应的时间信息不知道是不是工程的问题   后来发现吧那个name 去掉value就可以了

下面是在一个eth的demo工程得到的结果

```shell
Total pre-main time: 760.53 milliseconds (100.0%)
         dylib loading time: 124.83 milliseconds (16.4%)
        rebase/binding time: 555.38 milliseconds (73.0%)
            ObjC setup time:  36.81 milliseconds (4.8%)
           initializer time:  43.28 milliseconds (5.6%)
           slowest intializers :
               libSystem.dylib :   2.87 milliseconds (0.3%)
    libMainThreadChecker.dylib :  30.70 milliseconds (4.0%)
```

在Allin工程得到的结果

![image-20180903144824712](/var/folders/0k/dzm_mknj7g9dy4hv754dnz_80000gn/T/abnerworks.Typora/image-20180903144824712.png)

```shell
Total pre-main time: 1.4 seconds (100.0%)
         dylib loading time: 207.11 milliseconds (14.3%)
        rebase/binding time: 983.93 milliseconds (68.1%)
            ObjC setup time: 112.97 milliseconds (7.8%)
           initializer time: 139.88 milliseconds (9.6%)
           slowest intializers :
               libSystem.dylib :   3.96 milliseconds (0.2%)
                 MediaServices :  63.82 milliseconds (4.4%)
                         allin :  58.99 milliseconds (4.0%)
```

解读

1. main()函数之前总共使用了1.4 seconds
2. 在1.4 seconds中，加载动态库用了207.11ms，指针重定位使用了983.93ms，ObjC类初始化使用了1112.97ms，各种初始化使用了139.88ms。
3. 在初始化耗费的139.88ms中，用时最多的三个初始化是MediaServices、allin以及libSystem.dylib。

#### 影响的原因

- 动态库加载越多，启动越慢。
- ObjC类越多，启动越慢
- C的constructor函数越多，启动越慢
- C++静态对象越多，启动越慢
- ObjC的+load越多，启动越慢



#### 苹果对APP启动前的要求

- 应该在400ms内完成main()函数之前的加载

- 整体过程耗时不能超过20秒，否则系统会kill掉进程，App启动失败


###APP启动用户体验

1. main()函数之前
2. main()函数之后至applicationWillFinishLaunching完成
3. App完成所有本地数据的加载并将相应的信息展示给用户
4. App完成所有联网数据的加载并将相应的信息展示给用户

1+2一起决定了我们需要用户等待多久才能出现一个主视图，同时也是技术上可以精确测量的时长，1+2+3决定了用户视觉上的等待出现有用信息所需要的时长，1+2+3+4决定了我们需要多少时间才能让我们需要展示给用户的所有信息全部出现。



#### 可以的优化方法

1.移除不需要用到的动态库

2.移除不需要用到的类

3.合并功能类似的类和扩展（Category）

4.压缩资源图片

5.优化applicationWillFinishLaunching

6.优化rootViewController加载



参考链接:https://my.oschina.net/bugly/blog/1512600

