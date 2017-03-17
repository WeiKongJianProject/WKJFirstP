//
//  NSFileManagerZL.h
//  MiYouProject
//
//  Created by wkj on 2017/3/17.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManagerZL : NSObject

+ (NSString *)pathDocument;
+ (NSString *)pathLibrary;
+ (NSString *)pathCaches;
+ (NSString *)pathPreferences;

/*s*
 *  获取path路径下文件夹的大小
 *
 *  @param path 要获取的文件夹 路径
 *
 *  @return 返回path路径下文件夹的大小
 */
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path;

/**
 *  清除path路径下文件夹的缓存
 *
 *  @param path  要清除缓存的文件夹 路径
 *
 *  @return 是否清除成功
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;
/*
 *创建文件夹/目录
 */
+ (BOOL)createWenJianJiaDir:(NSString *)fileName;
/*
 *创建文件
 */
+ (BOOL)createFilewithPath:(NSString *)path withFileName:(NSString *)fileName;
/*
 *写数据到文件
 */
+ (BOOL)writeFileWithPath:(NSString *)path witnFileName:(NSString *)fileName;
/*
 *读取文件
 */
+ (BOOL)readFileWithPath:(NSString *)path withFileName:(NSString *)fileName;

/*
 *根据路径删除文件
 */
+ (BOOL)deleteFileWithPath:(NSString *)path withFileName:(NSString *)fileName;

/*
 *根据文件名删除文件
 */
+ (BOOL)deleteFileWithFileName:(NSString *)fileName;
/*
 *根据文件名获取资源文件路径
 */
+ (NSString *)getResourcesFile:(NSString *)fileName;
/*
 *根据文件名获取文件路径
 */
+ (NSString *)getLocalFilePath:(NSString *) fileName;
/*
 *根据文件路径获取文件名称
 */
+ (NSString *)getFileNameByPath:(NSString *)filepath;
/*
 *根据路径获取该路径下所有目录
 */
+ (NSArray *)getAllFileByName:(NSString *)path;
/*
 *根据路径获取文件目录下所有文件
 */
+ (NSArray *)getAllFloderByName:(NSString *)path;

/*
 *获取文件及目录的大小
 */
+ (float)sizeOfDirectory:(NSString *)dir;

/*
 *重命名文件或目录
 */
+ (BOOL)renameFileName:(NSString *)oldName toNewName:(NSString *)newName;
/*
 *读取文件
 */
+ (NSData *)readFileContent:(NSString *)filePath;
/*
 *保存文件
 */
+ (BOOL)saveToDirectory:(NSString *)path data:(NSData *)data name:(NSString *)newName;
//计算单个文件大小的方法
+ (long long)fileSizeAtPath:(NSString *)path;
//计算一个文件夹大小
+ (float)folderSizeAtPath:(NSString *)path;
//清空缓存方法
+ (void)cleanCaches:(NSString *)path;

//判断后缀名是否是MP4
+ (BOOL)panDuanHouZhuiis:(NSString *)houName withPath:(NSString *)path;


@end
