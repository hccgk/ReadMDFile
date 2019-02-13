# ViewModel 制作

1. 第一种放到view里面
2. 第二种放到model里面
3. 第三种独立文件

本文选用第三种

就是首先创建vm文件，继承自nsobject

然后创建一个具有block回调的网络请求方法，这样网络请求就在vm里面了，然后vm回调一个空的block就可以是告诉C我干完了，你协调view吧



在C里面调用view的刷新

view --- viewmodel --- model

view使用vm里面的数据

vm被view触发操作，vm触发c让c进行操作



双向绑定（view <-->viewmodel）： view 设计2个接口一个读取数据的，从vm读取；一个触发时间，告诉vm我干了什么；



----

灵感来源，借鉴来源：https://github.com/LiJinShi/MVVM_Demo

其他参考blog

https://www.jianshu.com/p/1a9c3500f543

