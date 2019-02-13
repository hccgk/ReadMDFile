# 判断点击事件是否在layer上

```objective-c
//创建手势添加到视图上
self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
[self.view addGestureRecognizer:self.tapGesture];

#pragma mark - 点击
/** 点击事件*/
-(void)click:(UITapGestureRecognizer *)tapGesture {

    CGPoint touchPoint = [tapGesture locationInView:self];
    //遍历当前视图上的子视图的presentationLayer 与点击的点是否有交集
    for (UIView *subView in self.view.subviews) {
        if ([subView.layer.presentationLayer hitTest:touchPoint]) {
            NSLog(@"点击的是：%@",subView);
        }
    }
}

作者：Augustinus
链接：https://www.jianshu.com/p/90895fc375f4
來源：简书
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
```

# 离屏点击事件处理

~~~objective-c
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        //***核心代码可以这么做  寻找btn外侧边缘
        //1.首先view为nil就说明找不到
        //2.CGPoint bpoint = [btn convertPoint:point fromView:self];  相对btn  点击的位置和self进行坐标转换
        //3. 看按着btn转换的新的触控点在不在这个btn的 bounds里面，如果在就说明离屏点击了这个btn
        // if (CGRectContainsPoint(btn.bounds, bpoint)) {
        //            view = btn;
        //   }
        //4.
        //return view;
        //***核心代码可以这么做
        if (self.dbuttons.count > 0) {
//找到对应的view
            for (UIButton *btn  in self.dbuttons) {
//坐标转换
                CGPoint bpoint = [btn convertPoint:point fromView:self];
//如果是就返回它
                if (CGRectContainsPoint(btn.bounds, bpoint)) {
                    view = btn;
                }
            }
        }
    }
    return view;
}
~~~

