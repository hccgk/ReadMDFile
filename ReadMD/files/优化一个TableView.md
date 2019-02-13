# 优化一个TableView

1. 若高度一定，直接使用rowHeight属性而不是使用heightForRowAtIndexPath方法，以减少调用的消耗.不一样就缓存起来提高效率
2. 不要在tableView:cellForRowAtIndexPath:中做太多的计算和IO操作，比如可以将需要的计算提前计算好、IO操作也提前计算好。它应该直接调用来显示就可以。
3. 将计算行高的时间提前到从服务器获取数据的时候，计算完了高度一并写回数据库或者通过转型为model，将高度放到模型中。但是，最好将高度缓存起来。若一个model的数据有不同的状态，比如展开与收起状态，应该也将高度都缓存起来。注意使用异步去计算，计算完成后再回到主线程显示。
4. 在设置显示图片时，不要直接设置UIImageView的contentMode属性自动适应，图片变形会计算transform，压缩时会乘以一个矩阵，消耗性能。对于要求性能较高的app，应该将得到的图片经过处理成UIImageView大小后再呈现。
5. 不要将视图的opaque属性设置为NO，默认为YES,它表示不透明度。当opque为NO的时候，图层的半透明取决于图片和其本身合成的图层为结果。YES 绘图系统会将 view看为完全不透明，这样绘图系统就可以优化一些绘制操作以提升性能
6. layer添加圆角是比较耗时的，这样会离屏渲染，需要牺牲更多的性能。比如，图片显示有圆角时，可以通过core graphics来生成带圆角的图片等
7. 手动绘制cell。绘制cell不建议使用UIView，建议使用CALayer。 UIView的绘制是建立在CoreGraphic上的，其使用的是CPU。CALayer使用的是Core Animation，CPU、GPU都可以使用且由系统自动决定使用哪一个。UIView的绘制，使用的是自下向上的一层一层的绘制，而后渲染。Layer处理的是纹理，利用GPU的 Texture Cache和独立的浮点数计算单元可以加速纹理的处理。
8. 重用cell。防止重复的绘制，减少渲染次数，可提高性能。
9. 减少subviews的数量。尽量放在同一层view上显示。
10. 尽量少动态给cell添加子view。用addView给Cell动态添加View，可以初始化时就添加，然后通过hide来控制是否显示。

