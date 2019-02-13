# SDwebimage 处理大图片

大图片经过sd的解压缩会带来内存的指数上涨

所以要想内存不那么高，需要对大图片进行不解压缩处理

https://blog.csdn.net/guojiezhi/article/details/52033796

这篇文章是这么写的，也给出了苹果的解释。小图片解压缩是有意义的吧。

重绘也是个办法，就是在sd的什么位置做

