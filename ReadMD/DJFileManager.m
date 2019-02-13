//
//  DJFileManager.m
//  duojia4iOS
//
//  Created by edz on 2018/10/12.
//  Copyright © 2018年 duojia. All rights reserved.
//

#import "DJFileManager.h"
//#import "NSString+DJCategory.h"

@implementation DJFileManager

//存储序列化对象(Documents文件夹下)
+ (BOOL)saveObject:(id)object filePath:(NSString *)path
{
    if (!object || ![self createDirectoryAtPath:path]) {
        return NO;
    }
    
    NSString *filePath = path.documentFilePath;
    if ([object isKindOfClass:[UIImage class]]) {
        //图片用原始持久化方法，减少多次编码引起的存取错误
        NSData *imageData = UIImageJPEGRepresentation((UIImage *)object, 1.0);
        return [imageData writeToFile:filePath atomically:NO];
    } else {
        return [NSKeyedArchiver archiveRootObject:object toFile:filePath];
    }
}


/*读取序列化对象(Documents文件夹下)*/
+ (id)loadObject:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path.documentFilePath];
}

//创建指定路径文件夹(Documents文件夹下)
+ (BOOL)createDirectoryAtPath:(NSString *)path
{
    if (!path.length) {
        return NO;
    }
    
    NSString *filePath = path.documentFilePath;
    NSString *directoryPath = [filePath substringToIndex:filePath.length - [(NSString *)filePath.pathComponents.lastObject length]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:directoryPath]) {
        return [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return YES;
}

//删除指定文件(Documents文件夹下)
+ (BOOL)deleteFile:(NSString *)path
{
    NSString *filePath = path.documentFilePath;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

//是否存在指定文件(Documents文件夹下)
+ (BOOL)fileExistsAtPath:(NSString *)path
{
    NSString *filePath = path.documentFilePath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

@end
