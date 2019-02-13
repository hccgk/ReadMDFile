//
//  DJFileManager.h
//  duojia4iOS
//
//  Created by edz on 2018/10/12.
//  Copyright © 2018年 duojia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJFileManager : NSObject

//存储序列化对象(Documents文件夹下)
+ (BOOL)saveObject:(id)object filePath:(NSString *)path;

//读取序列化对象(Documents文件夹下)
+ (id)loadObject:(NSString *)path;

//创建指定路径文件夹(Documents文件夹下)
+ (BOOL)createDirectoryAtPath:(NSString *)path;

//删除指定文件(Documents文件夹下)
+ (BOOL)deleteFile:(NSString *)path;

//是否存在指定文件(Documents文件夹下)
+ (BOOL)fileExistsAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
