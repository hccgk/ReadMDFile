//
//  Kdefine.h
//  duojia4iOS
//
//  Created by 何川 on 2018/10/9.
//  Copyright © 2018年 duojia. All rights reserved.
//

#ifndef Kdefine_h
#define Kdefine_h
#define introUserDefaultsKeyStr @"introUserDefaultsKeyStr"
//#define appEnvironment @"dev"
//#define appEnvironment @"adhot"
#define appEnvironment @"appstore"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define Scale  kScreenW/320.0 //不考虑4s 高度上是几乎合理的

#define kIPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

// Tabbar height.
#define  kBottomBarHeight         (kIPHONE_X ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define  kBottomSafeBarHeight         (kIPHONE_X ? (34.f ) : 0.f)
// Navigattion height
#define kTopHeight  (kIPHONE_X ? 88 : 64)
#define kTopSafeHeight [[UIApplication sharedApplication] statusBarFrame].size.height   //普通的是20 iPhone X 是44
#define kNavH (kStatusBarHeight + kNavBarHeight)

#define vCFBundleShortVersionStr [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define KeyWindow ([UIApplication sharedApplication].delegate).window

#define kradiusValue 4
#define kcolorgb(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
#define kcolorhex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

//配色表
#define kLocal(key)\
NSLocalizedString(key, nil)

#define kSVP \
[SVProgressHUD setInfoImage:[UIImage sd_animatedGIFNamed:@"DJloading"]];\
[SVProgressHUD setImageViewSize:CGSizeMake(60, 60)];\
[SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];\
[SVProgressHUD setMinimumDismissTimeInterval:1000];\
[SVProgressHUD showInfoWithStatus:nil];

//[SVProgressHUD show];\
[SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
#define kSVPover \
[SVProgressHUD dismiss];

#define kErrorStr(string)\
[SVProgressHUD showErrorWithStatus:string];\
[SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];\
[SVProgressHUD dismissWithDelay:1.5];

#define kError(error)\
[SVProgressHUD showErrorWithStatus:error.localizedDescription];\
[SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];\
[SVProgressHUD dismissWithDelay:1.5];

#define kSuccess(string)\
[SVProgressHUD showSuccessWithStatus:string];\
[SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];\
[SVProgressHUD dismissWithDelay:1.5];
// 图片默认类型
#define imageViewDefaultContentMode(contenView)\
contenView.contentMode=UIViewContentModeScaleAspectFill;\
[contenView.layer setMasksToBounds:YES];

//圆角 注意不复杂时候可以使用,复杂时候不能使用这个
#define kRViewBorderRadiusAndCorlor(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]];

#define kRViewShadowRadius(View, Radius)\
View.layer.cornerRadius= Radius;\
View.layer.shadowColor=[UIColor colorWithHexString:@"#172A920A"].CGColor;\
View.layer.shadowOffset=CGSizeMake(10, 10);\
View.layer.shadowOpacity=0.5;\
View.layer.shadowRadius=5;

#define kRViewBorderRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\

#define kRViewRadius(View, Radius)\
[View jk_setRoundedCorners:UIRectCornerAllCorners radius:Radius];\

#define kWeakSelf(type) __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) strong##type = type;

//通用的移除通知
#define KremoveNotificationCenterObserverDealloc - (void)dealloc{ [[NSNotificationCenter defaultCenter] removeObserver:self];  NSLog(@"死亡dealloc:%@",[[self class] description]);}
//调试
#ifdef DEBUG
#define kLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define kLog(...)
#endif

//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程 子线程上执行
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);

//版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//沙盒目录文件
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//存储对象
#define kUserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
//获得存储的对象
#define kUserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

//删除对象
#define kUserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

//警告消除
#pragma mark - Clang

#define ArgumentToString(macro) #macro
#define ClangWarningConcat(warning_name) ArgumentToString(clang diagnostic ignored warning_name)

#define BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(ClangWarningConcat(#warningName))
#define EndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define BeginIgnorePerformSelectorLeaksWarning BeginIgnoreClangWarning(-Warc-performSelector-leaks)
#define EndIgnorePerformSelectorLeaksWarning EndIgnoreClangWarning

#define BeginIgnoreAvailabilityWarning BeginIgnoreClangWarning(-Wpartial-availability)
#define EndIgnoreAvailabilityWarning EndIgnoreClangWarning

#define BeginIgnoreDeprecatedWarning BeginIgnoreClangWarning(-Wdeprecated-declarations)
#define EndIgnoreDeprecatedWarning EndIgnoreClangWarning

//左 宽
#define DJWidth(x)   ((x) * kScreenW/375.0)
//上 高
#define DJHeight(y)  ((y) * kScreenH/667.0)

#define RealValue(Value)  ((Value)/320.0f *[[UIScreen mainScreen] bounds].size.width)
#define TableViewW  kScreenW - RealValue(130*0.5)

#define DJ_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"DJSearchhistories.plist"] // the path of search record cached


#endif /* Kdefine_h */

