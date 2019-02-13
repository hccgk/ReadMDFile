# 接入ZFPlayer 说明

接入分为2种方式一种是直接在view上面接入，这种比较简单，一种是在scrollview上面接入，这个比较复杂。原始的demo比较复杂业务场景和自己的场景不是很贴合，所以抽取使用精髓为我用

先说第一种方式：【view上面直接添加】

```objective-c
 	//设置player
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    self.player = [[ZFPlayerController alloc] initWithPlayerManager:playerManager containerView:self.containerView];//containerView 为展示的view这个view 是个uiimageview
    self.player.controlView = self.controlView; //通用控制层，这就是为什么不用阿里云sdk而选择这个
    self.player.pauseWhenAppResignActive = NO; //后台不播放
    //    self.player.assetURLs = self.assetURLs;
    self.player.shouldAutoPlay = NO; // 只有在scrollview上才能起作用，子类页可以。这里是指无效
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.playBtn];//增加一个按钮，好开始播放，如果自动不放直接设置    ’self.player.assetURL =  [NSURL URLWithString:@"http://player.alicdn.com/video/aliyunmedia.mp4"];‘
//就可以播放了。
    //控制层
    - (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
    }
    return _controlView;
}

```

需要引入属性

```objective-c
@property (nonatomic, strong) ZFPlayerController *player;
@property(nonatomic,strong) ZFPlayerControlView *controlView;
```

第二种方式【重点】：

头文件

```objective-c
#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"
#import "ZFUtilities.h"
#import "UIImageView+ZFCache.h"
#import "ZFPlayerControlView.h"
#import "DJPosVideoTableViewCell.h"
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;

```

然后就是自定义cell cell里面有个imageview，要有个tag，在tableview初始化的时候需要给他设置.

使用的关键方法是 playerWithScrollView：playerManager：containerViewTag：

~~~objective-c
-(void)testTVB{
    self.urls = [NSMutableArray array];
    [self.urls addObject:[NSURL URLWithString:@"http://player.alicdn.com/video/aliyunmedia.mp4"]];
    [self.urls addObject:[NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo-transcode/20985849_722f981a5ce0fc6d2a5a4f40cb0327a5_3.mp4"]];
    [self.view addSubview:self.tableView];
    /// playerManager
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// player的tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:100];
    self.player.controlView = self.controlView;
    self.player.assetURLs = self.urls;
    self.player.shouldAutoPlay = NO;
    /// 1.0是完全消失的时候
    self.player.playerDisapperaPercent = 1.0;
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
        [UIViewController attemptRotationToDeviceOrientation];
        self.tableView.scrollsToTop = !isFullScreen;
    };
    
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player stopCurrentPlayingCell];
        //        }
    };

}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenW, kScreenH - kTopHeight - kBottomSafeBarHeight) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
    }
    return _tableView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJPosVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"djfakljdfljwqioef"];
    if (!cell) {
        cell = [[DJPosVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"djfakljdfljwqioef"];
    }
    DJPosVidioModel *mmodel = [[DJPosVidioModel alloc] init];
    
    mmodel.imageName = @"https://duojia-app.oss-cn-beijing.aliyuncs.com/ios/201812201035043823808.png";
    mmodel.vurl = @"http://player.alicdn.com/video/aliyunmedia.mp4";
    cell.model = mmodel;
//    kWeakSelf(self);
    cell.playBlock = ^(UIButton * _Nonnull btn) {
//        kStrongSelf(weakself);
//        //知道是那一个indexpath
//        [strongweakself.player playTheIndexPath:indexPath scrollToTop:NO];
//        //还有展位图等内容的显示一个队contentview的设置
//        [strongweakself.controlView showTitle:@"test"
//                     coverURLString:mmodel.vurl
//                     fullScreenMode:ZFFullScreenModeLandscape];
    };
        
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetWidth(self.view.frame) *9 /16;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /// 如果正在播放的index和当前点击的index不同，则停止当前播放的index
    if (self.player.playingIndexPath != indexPath) {
        [self.player stopCurrentPlayingCell];
    }
    /// 如果没有播放，则点击进详情页会自动播放
    if (!self.player.currentPlayerManager.isPlaying) {
        [self.player playTheIndexPath:indexPath scrollToTop:NO];
        //还有展位图等内容的显示一个队contentview的设置
        NSURL *url = self.urls[indexPath.row];
        [self.controlView showTitle:@"test"
                     coverURLString:url.absoluteString
                               fullScreenMode:ZFFullScreenModePortrait];

    }
}


#pragma mark - UIScrollViewDelegate 列表播放必须实现

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}
#pragma mark - UIScrollViewDelegate 列表播放必须实现
~~~

cell的初始化时

~~~objective-c
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}

-(void)makeUI{
    _contenerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*9/16)];
    [self.contentView addSubview:_contenerView];
    _contenerView.tag = 100;
    _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenW/2.0-18, kScreenW*9/16/2.0-18, 36, 36)];
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"playIcon"]];
    [_playBtn addTarget:self
                 action:@selector(playAction)  forControlEvents:UIControlEventTouchUpInside];
    [_contenerView addSubview:_playBtn];
}
-(void)setModel:(DJPosVidioModel *)model{
    _model = model;
}
-(void)playAction{
    if (self.playBlock) {
        self.playBlock(_playBtn);
    }
}

~~~

在tableview的delegate里面响应这个view找到这个tag然后对应的indexpat的内容进行播放

方法是：

~~~objective-c
[self.player playTheIndexPath:indexPath scrollToTop:NO];
NSURL *url = self.urls[indexPath.row];
        [self.controlView showTitle:@"test"
                     coverURLString:url.absoluteString
                               fullScreenMode:ZFFullScreenModePortrait];
~~~

这个方法开始就开始播放了

最终列表中只有一个player，然后内容是根据数据源发生的改变，显示的位置也是根据数据进行改变。内存效率的提升是显著的。对比自己写cell然后弄好多个播放器， 太粗放



------

如果其他样式的cell也可以，数据源也是完全自定义，精髓就在cell里面的uiimageview然后赋值tag 

然后控制播放可以用block，点击cell可以是不同的样式，然后在delegate里面进行区分。