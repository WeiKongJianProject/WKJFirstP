//
//  NSFileManagerZL.m
//  MiYouProject
//
//  Created by wkj on 2017/3/17.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "NSFileManagerZL.h"

@implementation NSFileManagerZL

+ (NSString *)pathDocument{
    //NSString *dirHome=NSHomeDirectory();//获取APP沙盒根路径
    //NSString *tmpDirectory = NSTemporaryDirectory();//获取Tmp目录路径
    //文件路径是数组，这里取第一个元素
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return docPath;
}

+ (NSString *)pathCaches{
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    return cachesPath;
}

+ (NSString *)pathLibrary{
    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    return libraryPath;
}
+ (NSString *)pathPreferences{

    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString*preferencePath = [libraryPath stringByAppendingString:@"/Preferences"];
    return preferencePath;
}

#pragma mark - 获取path路径下文件夹大小
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path{
    
    // 获取“path”文件夹下的所有文件
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    
    for (NSString *subPath in subPathArr){
        
        // 1. 拼接每一个文件的全路径
        filePath =[path stringByAppendingPathComponent:subPath];
        // 2. 是否是文件夹，默认不是
        BOOL isDirectory = NO;
        // 3. 判断文件是否存在
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        
        // 6. 获取每一个文件的大小
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        
        // 7. 计算总大小
        totleSize += size;
    }
    
    //8. 将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    
    if (totleSize > 1000 * 1000){
        totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
        
    }else if (totleSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f ];
        
    }else{
        totleStr = [NSString stringWithFormat:@"%.2fB",totleSize / 1.00f];
    }
    
    return totleStr;
}


#pragma mark - 清除path文件夹下缓存大小
+ (BOOL)clearCacheWithFilePath:(NSString *)path{
    
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    NSString *filePath = nil;
    
    NSError *error = nil;
    
    for (NSString *subPath in subPathArr)
    {
        filePath = [path stringByAppendingPathComponent:subPath];
        
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }
    }
    return YES;
}
#pragma mark 文件操作方法 02
/*
 *1.0
 *创建文件夹 目录
 */
+ (BOOL)createWenJianJiaDir:(NSString *)fileName{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if  (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {//先判断目录是否存在，不存在才创建
        BOOL res=[fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        return res;
    } else return NO;
    
}
/*
 *2.0
 *创建文件
 */
+ (BOOL)createFilewithPath:(NSString *)path withFileName:(NSString *)fileName{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testPath = [path stringByAppendingPathComponent:fileName];//在传入的路径下创建test.c文件
    BOOL res=[fileManager createFileAtPath:testPath contents:nil attributes:nil];
    //通过data创建数据
    //[fileManager createFileAtPath:testPath contents:data attributes:nil];
    return res;
    
}
/*
 *3
 *写数据到文件
 */
+ (BOOL)writeFileWithPath:(NSString *)path witnFileName:(NSString *)fileName{
    NSString *testPath = [path stringByAppendingPathComponent:fileName];
    NSString *content=@"将数据写入到文件！";
    BOOL res=[content writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return res;

}
/*
 *4
 *读取文件
 */
+ (BOOL)readFileWithPath:(NSString *)path withFileName:(NSString *)fileName{
    NSString *testPath = [path stringByAppendingPathComponent:fileName];
    //方法1:
    NSData * data = [NSData dataWithContentsOfFile:testPath];
    NSString * content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return YES;
//    //方法2:
//    NSString * content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"文件读取成功: %@",content);
}
/*
 //获取文件属性
 -(void)fileAttriutes:(NSString *)path{
 NSFileManager *fileManager = [NSFileManager defaultManager];
 NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
 NSArray *keys;
 id key, value;
 keys = [fileAttributes allKeys];
 int count = [keys count];
 for (int i = 0; i < count; i++)
 {
 key = [keys objectAtIndex: i];  //获取文件名
 value = [fileAttributes objectForKey: key];  //获取文件属性
 }
 }
 */
/*
 *5
 *根据路径删除文件
 */
+ (BOOL)deleteFileWithPath:(NSString *)path withFileName:(NSString *)fileName{

    NSString * testPath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL res=[fileManager removeItemAtPath:testPath error:nil];
    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:path]?@"YES":@"NO");
    return res;
    
}

/*
 *6
 *根据文件名删除文件
 */
+ (BOOL)deleteFileWithFileName:(NSString *)fileName{

    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    NSString * testPath = [NSString stringWithFormat:@"%@/%@",path,fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
   return [fileManager removeItemAtPath:testPath error:nil];//getLocalFilePath方法在下面
}
/*
 *7
 *根据文件名获取资源文件路径
 */
+ (NSString *)getResourcesFile:(NSString *)fileName{

    return [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
}
/*
 *8
 *根据文件名获取文件路径
 */
+ (NSString *)getLocalFilePath:(NSString *) fileName{
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    return [NSString stringWithFormat:@"%@/%@",path,fileName];
}
/*
 *9
 *根据文件路径获取文件名称
 */
+ (NSString *)getFileNameByPath:(NSString *)filepath{
    NSArray *array=[filepath componentsSeparatedByString:@"/"];
    if (array.count==0) return filepath;
    return [array objectAtIndex:array.count-1];
}
/*
 *10
 *根据路径获取该路径下所有目录
 */
+ (NSArray *)getAllFileByName:(NSString *)path{

    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSArray *array = [defaultManager contentsOfDirectoryAtPath:path error:nil];
    return array;
}
/*
 *11
 *根据路径获取文件目录下所有文件
 */
+ (NSArray *)getAllFloderByName:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /*
    NSArray * fileAndFloderArr = [self getAllFileByName:path];
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    //在上面那段程序中获得的fileList中列出文件夹名
    for (NSString * file in fileAndFloderArr){
        
        NSString *paths = [path stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:paths isDirectory:(&isDir)];
        if (isDir) {
            [dirArray addObject:file];
        }
        isDir = NO;
    }
    return dirArray;
    */
     NSArray *resultArray = [fileManager contentsOfDirectoryAtPath:path error:nil];
    return resultArray;
}
/*

 //浅层遍历(遍历根目录第一层文件和文件夹)
 NSString *HomeDir = NSHomeDirectory();
 NSArray *resultArray = [manager contentsOfDirectoryAtPath:HomeDir error:nil];
 for(id obj in resultArray) {
 NSLog(@"浅层遍历obj = %@",obj);
 }
 
 //深层遍历(遍历tmp路径下的所有文件夹和文件)
 NSArray *resultArr1 = [manager subpathsOfDirectoryAtPath:HomeDir error:nil];
 for(id obj1 in resultArr1) {
 NSLog(@"深层遍历obj = %@",obj1);
 }
 
 */
/*
 *12
 *获取文件及目录的大小
 */
+ (float)sizeOfDirectory:(NSString *)dir{
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:dir];
    NSString *pname;
    int64_t s=0;
    while (pname = [direnum nextObject]){
        //NSLog(@"pname   %@",pname);
        NSDictionary *currentdict=[direnum fileAttributes];
        NSString *filesize=[NSString stringWithFormat:@"%@",[currentdict objectForKey:NSFileSize]];
        NSString *filetype=[currentdict objectForKey:NSFileType];
        
        if([filetype isEqualToString:NSFileTypeDirectory]) continue;
        s=s+[filesize longLongValue];
    }
    return s*1.0;
    
}

/*
 *13
 *重命名文件或目录
 */
//+ (BOOL)renameFileName:(NSString *)oldName toNewName:(NSString *)newName{
//    BOOL result = NO;
//    NSError * error = nil;
//    result = [[NSFileManager defaultManager] moveItemAtPath:[kDSRoot stringByAppendingPathComponent:oldName] toPath:[kDSRoot stringByAppendingPathComponent:newName] error:&error];
//    
//    if (error){
//        NSLog(@"重命名失败：%@",[error localizedDescription]);
//    }
//    
//    return result;
//}
/*
 *14
 *读取文件
 */
+ (NSData *)readFileContent:(NSString *)filePath{
    return [[NSFileManager defaultManager] contentsAtPath:filePath];
}
/*
 *15
 *保存文件
 */
+ (BOOL)saveToDirectory:(NSString *)path data:(NSData *)data name:(NSString *)newName{
    NSString * resultPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",newName]];
    return [[NSFileManager defaultManager] createFileAtPath:resultPath contents:data attributes:nil];
}

#pragma end mark
#pragma mark 计算缓存方法 03

/*
 *16
 *计算单个文件的大小
 */
//计算单个文件大小的方法
+ (long long)fileSizeAtPath:(NSString *)path{

    //创建一个文件管理者
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:path]) {
        return [[manger attributesOfItemAtPath:path error:nil] fileSize];
    }
    return 0;
    
}
/*
 *17
 *计算文件夹的大小
 */
//计算一个文件夹大小
+ (float)folderSizeAtPath:(NSString *)path{
    //创建文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        return 0;
    }
    //根据路径获取文件夹里面的元素的集合
    //获取集合类型的枚举器
    NSEnumerator *enumerator = [[manager subpathsAtPath:path] objectEnumerator];
    //每次遍历得到的文件名
    NSString *fileName = [NSString string];
    //文件夹大小
    float folderSize = 0;
    while ((fileName = [enumerator nextObject]) != nil) {
        NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:absolutePath];
    }
    return folderSize / (1024.0 * 1024.0);

}
/*
 *18
 *清除缓存
 */
//清空缓存方法
+ (void)cleanCaches:(NSString *)path{

    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSArray *fileNameArray = [manager subpathsAtPath:path];
        for (NSString *fileName in fileNameArray) {
            //拼接绝对路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            //通过管理者删除文件
            [manager removeItemAtPath:absolutePath error:nil];
        }
    }
}
/*
 *19
 *判断后缀名是否 是指定名称
 */

+ (BOOL)panDuanHouZhuiis:(NSString *)houName withPath:(NSString *)path{
    //获取文件后缀名
    NSString *resultStr = [path pathExtension];
    
    BOOL result = NO;
    //NSLog(@"文件的后缀名为 = %@",resultStr);
    if ([resultStr isEqualToString:houName]) {
        result = YES;
    }
    else{
        result = NO;
    }
    
    return result;
}


#pragma end mark


@end
