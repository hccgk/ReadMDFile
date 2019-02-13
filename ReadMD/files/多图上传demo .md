~~~objective-c
  // 创建标签列表
    HDragItem *item = [[HDragItem alloc] init];
    item.backgroundColor = kcolorhex(0xf8f8f9);
    item.contentMode = UIViewContentModeScaleAspectFill;
    item.image = [UIImage imageNamed:@"照相机"];
    item.isAdd = YES;
    item.url = @"add";
    HDragItemListView *itemList = [[HDragItemListView alloc] initWithFrame:CGRectMake(0, _imageLabel.bottom+15, self.view.frame.size.width, 100)];
    [itemList setupitemListCols:4 Max:4];

    self.itemList = itemList;
    itemList.backgroundColor = [UIColor clearColor];
    // 高度可以设置为0，会自动跟随标题计算
    // 设置排序时，缩放比例
    itemList.scaleItemInSort = 1.3;
    // 需要排序
    itemList.isSort = YES;
    itemList.isFitItemListH = YES;
    [itemList addItem:item];
    itemList.height = itemList.itemListH;

    kWeakSelf(self)
    [itemList setClickItemBlock:^(HDragItem *item) {
        if (item.isAdd) {
            [weakself callImageTag:@"addImage"];
        }
    }];
    
    /**
     * 移除tag 高度变化，得重设
     */
    itemList.deleteItemBlock = ^(HDragItem *item) {
        HDragItem *lastItem = [weakself.itemList.itemArray lastObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!lastItem.isAdd) {
                HDragItem *item = [[HDragItem alloc] init];
                item.backgroundColor = kcolorhex(0xf8f8f9);
                item.contentMode = UIViewContentModeScaleAspectFill;
                item.image = [UIImage imageNamed:@"照相机"];
                item.isAdd = YES;
                [weakself.itemList addItem:item];
            }
        });
       
      
    };
    
    [_backView addSubview:itemList];
~~~





对应控制器DJMineFeedBackController



还有TZImagePickerControllerDelegate 的实现