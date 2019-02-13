# 设计模式mvc,mvvm,mvp



参考youtube视频:https://www.youtube.com/watch?v=qzTeyxIW_ow

参考blog http://www.cocoachina.com/ios/20170213/18659.html  使用oc 使用rac进行延伸mvvm 这是国内的blog,那个人已经2年没有更新github了  [https://github.com/wanglongshuai/MVVM-RAC-Demo] github链接,可以看看2年前的mvvm



通过查看youtube视频,发现这几个设计模式,其实主要就是为了解决网络请求

很好的理解mvvm 的初始化使用,vm帮助  view-vc  ---- vm ----- model  vm做好多逻辑处理等.view更轻量化,vc也就轻了.但是没有绑定的介绍,说是用ReactiveCocoa  ReactiveObjc 
https://objccn.io/issue-13-1/



Viewmodel 属性值可以被vc复制给view.

view如何反馈给vm 代理,或者block;view声明调用代理,vm实现这个代理.得到view传递的参数或者调用vm的方法.如果是block就下view声明block属性,然后调用,vc使用这个block回调.