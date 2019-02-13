# 模拟后台接口MOCK json-server

* 安装 json-server

```sudo npm install json-server -g```

* 使用,默认会创建一个db.json，里面有一些接口的json格式，可以对其进行处理

  `json-server --watch db.json`

* 例如默认的里面有posts那么访问的接口地址就是http://localhost:3000/posts/ get post都可以对里面的json接口进行处理

* 如果使用put patch delete 的话需要把id放上去也就是http://localhost:3000/posts/1  等url然后是参数

----

安装参考：https://www.cnblogs.com/ys-wuhan/p/6387791.html

使用参考：https://blog.csdn.net/zula1994/article/details/76889393

github地址：https://github.com/typicode/json-server

线上mock云服务：https://www.mocky.io/  特点还能通过设置模拟返回的延时是多久，这样能够测试本地网络缓慢的情况

