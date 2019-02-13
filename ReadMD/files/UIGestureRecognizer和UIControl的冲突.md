#UIGestureRecognizer和UIControl的冲突
点击程序的任意区域，都没有跳转提示，只有父view的背景不断变化，似乎子view添加的手势处理事件完全没有被触发。

问题分析
经过调试发现，完全没有响应子view的UIControl的touchUpInside事件，而是响应了父控件的tap事件。是因为UIGesture Recognizer的级别较高，而且由于cancelsTouchesInView默认是yes，所以UIControl不足以识别出touchUpInside事件，假如我们将UIControl的响应事件改成touchDown的话，你会发现，两者都响应。同样，保留touchUpInside将cancelsTouchesInView设置成NO，有同样的效果。 
实际上，UIGestureRecognizer和UIControl的冲突本质上是UIGestureRecognizer和Touches响应的冲突，可参考上一节。 
但是，并不是UIControl的所有子类都会遭遇同样的问题。假如我们把UIControl换成UIButton的话，只会响应UIButton的touchUpInside，不会响应父View的tap事件。原因见苹果官方说明：

In iOS 6.0 and later, default control actions prevent overlapping gesture recognizer behavior. For example, the default action for a button is a single tap. If you have a single tap gesture recognizer attached to a button’s parent view, and the user taps the button, then the button’s action method receives the touch event instead of the gesture recognizer. This applies only to gesture recognition that overlaps the default action for a control, which includes: 
* A single finger single tap on a UIButton, UISwitch, UIStepper, UISegmentedControl, and UIPageControl. 
* A single finger swipe on the knob of a UISlider, in a direction parallel to the slider. 
* A single finger pan gesture on the knob of a UISwitch, in a direction parallel to the switch.

解决方案
在父View使用UIGesture的情况下，子view也使用UIGesture或者UIButton, UISwitch, UIStepper, UISegmentedControl, and UIPageControl.控件。
总结
UIGestureRecognizer 和 UITouch 都使用HitTest机制来寻找响应控件,hitest机制是本文一切冲突的基础
避免同时使用多套手势识别机制，在必须使用的时候，记得考虑上面提到的冲突
gesture recognizer 不参与响应链(这篇文章并未涉及,但是由于其高优先级，响应链对其根本无用武之地)
尽量不要直接使用UIControl
--------------------- 
作者：徐诺 
来源：CSDN 
原文：https://blog.csdn.net/woaihuangrong/article/details/52972913 
版权声明：本文为博主原创文章，转载请附上博文链接！