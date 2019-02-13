#精确还原UI字体的行高和间距



使用方法:

``````objective-c
NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
paragraphStyle.maximumLineHeight = lineHeight;
paragraphStyle.minimumLineHeight = lineHeight;
NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
attributes[NSParagraphStyleAttributeName] = paragraphStyle;
CGFloat baselineOffset = (lineHeight - font.lineHeight) / 4;
attributes[NSBaselineOffsetAttributeName] = @(baselineOffset);
``````

使用一个工具类,来传入一个行间距,然后传出NSAttributedString 的attr,这样就能精确设置了



今天偶然看到了 [在iOS中如何正确的实现行间距与行高 - 掘金](https://juejin.im/post/5abc54edf265da23826e0dc9) 这边文章，豁然开朗。虽然设置 maximumLineHeight 和 minimumLineHeight 会导致显示有偏移，但整体高度是对的，利用 baselineOffset 将偏移修复即可，修复公式为 `(lineHeight - label.font.lineHeight) / 4`。