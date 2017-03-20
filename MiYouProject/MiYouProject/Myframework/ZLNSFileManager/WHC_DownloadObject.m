//
//  WHC_DownloadObject.m
//  WHC_FileDownloadDemo
//
//  Created by 吴海超 on 15/11/27.
//  Copyright © 2015年 吴海超. All rights reserved.
//

#import "WHC_DownloadObject.h"
#import <CommonCrypto/CommonDigest.h>
const static double k1MB = 1024 * 1024;

@implementation WHC_DownloadObject 

- (instancetype)init {
    self = [super init];
    if (self) {
        _downloadSpeed = @"0KB/s";
        _downloadState = WHCNone;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_etag forKey:@"etag"];
    [aCoder encodeObject:_fileName forKey:@"fileName"];
    [aCoder encodeObject:_downloadPath forKey:@"downloadPath"];
    [aCoder encodeInt64:_totalLenght forKey:@"totalLenght"];
    [aCoder encodeInt64:_currentDownloadLenght forKey:@"currentDownloadLenght"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _etag = [aDecoder decodeObjectForKey:@"fileName"];
        _downloadSpeed = @"0KB/s";
        _fileName = [aDecoder decodeObjectForKey:@"fileName"];
        _downloadPath = [aDecoder decodeObjectForKey:@"downloadPath"];
        _currentDownloadLenght = [aDecoder decodeInt64ForKey:@"currentDownloadLenght"];
        _totalLenght = [aDecoder decodeInt64ForKey:@"totalLenght"];
     
        
        _downloadState = _totalLenght != 0 ? (self.currentDownloadLenght == self.totalLenght ? WHCDownloadCompleted : WHCDownloadCanceled) : WHCNone;
        
        NSLog(@"--_downloadState =->%lu<- _totalLenght-->%llu<----",(unsigned long)_downloadState,_currentDownloadLenght);
    }
    return self;
}

+ (NSString *)cacheDirectory {
    return [NSString stringWithFormat:@"%@/Library/Caches/WHCDownloadObjectCache/",NSHomeDirectory()];
}

+ (NSString *)cachePlistDirectory {
    return [NSString stringWithFormat:@"%@/Library/Caches/WHCCachePlistDirectory/",NSHomeDirectory()];
}

+ (NSString *)cachePlistPath {
    
    
    return [NSString stringWithFormat:@"%@WHCDownloadCache.plist",[WHC_DownloadObject cachePlistDirectory]];
}

+ (NSString *)videoDirectory {
    //return [NSFileManagerZL pathDocument];
    //return [NSString stringWithFormat:@"%@/Library/Caches/WHCVideos/",NSHomeDirectory()];
    return [NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()];
}

+ (WHC_DownloadObject *)readDiskCache:(NSString *)downloadPath {
    
    WHC_DownloadObject *DownloadOb2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[WHC_DownloadObject getCachedFileName:downloadPath]];
    NSLog(@"--WHC_DownloadObject *DownloadOb2 = -->%@<----",DownloadOb2);
    return DownloadOb2;
}

+ (BOOL)existLocalSavePath:(NSString *)downloadPath {
    NSFileManager * fm = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    return [fm fileExistsAtPath:[WHC_DownloadObject getCachedFileName:downloadPath] isDirectory:&isDirectory];
}

+ (NSArray *)readDiskAllCache {
    NSMutableArray * downloadObjectArr = [NSMutableArray array];
    NSMutableDictionary * cacheDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[WHC_DownloadObject cachePlistPath]];
    
    NSLog(@"--WHCDownloadCache.plist-->%@<----",[NSString stringWithFormat:@"%@WHCDownloadCache.plist",[WHC_DownloadObject cachePlistDirectory]]);
    
    if (cacheDictionary != nil) {
        NSArray * allKeys = [cacheDictionary allKeys];
        for (NSString * path in allKeys) {
            
            WHC_DownloadObject *DownloadOb = [WHC_DownloadObject readDiskCache:path];
            NSLog(@"--WHC_DownloadObject *DownloadOb = -->%@<----",DownloadOb);
            [downloadObjectArr addObject:DownloadOb];
        }
    }
    
    
    
    
    //简单举例：查询DownloadObject表
//    [DownloadObject selectWhereMainQueue:nil groupBy:nil orderBy:nil limit:nil selectResultsBlock:^(NSArray *selectResults) {
//        downloadObjectArr = [NSMutableArray arrayWithArray:selectResults];
//        for (DownloadObject *temsoao in downloadObjectArr) {
//            switch (temsoao.downloadState) {
//                case 0:
//                    temsoao.downloadState = WHCNone;
//                    break;
//                case 1:
//                    temsoao.downloadState = WHCDownloading;
//                    break;
//                case 2:
//                    temsoao.downloadState = WHCDownloadCompleted;
//                    break;
//                case 3:
//                    temsoao.downloadState = WHCDownloadCanceled;
//                    break;
//                case 4:
//                    temsoao.downloadState = WHCDownloadWaitting;
//                    break;
//                default:
//                    temsoao.downloadState = WHCDownloadWaitting;
//                    break;
//            }
//            
//        }
//        
//    }];

    return downloadObjectArr;
}

+ (NSString *)getCachedFileName:(NSString *)name {
    NSMutableString * cachedFileName = [NSMutableString string];
    if (name != nil) {
        const char * cStr = name.UTF8String;
        unsigned char buffer[CC_MD5_DIGEST_LENGTH];
        memset(buffer, 0x00, CC_MD5_DIGEST_LENGTH);
        CC_MD5(cStr, (CC_LONG)(strlen(cStr)), buffer);
        for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            [cachedFileName appendFormat:@"%02x",buffer[i]];
        }
        return [NSString stringWithFormat:@"%@%@",[WHC_DownloadObject cacheDirectory],cachedFileName];
    }
    return [NSString stringWithFormat:@"%@WHC",[WHC_DownloadObject cacheDirectory]];
}

- (float)downloadProcessValue {
    return (double)_currentDownloadLenght / ((double)_totalLenght == 0 ? 1 : _totalLenght);
}

- (NSString *)currentDownloadLenghtToString {
    return [NSString stringWithFormat:@"%.1fMB",(double)_currentDownloadLenght / k1MB];
}

- (NSString *)totalLenghtToString {
    return [NSString stringWithFormat:@"%.1fMB",(double)_totalLenght / k1MB];
}

- (NSString *)downloadProcessText {
    return [NSString stringWithFormat:@"%@/%@",self.totalLenghtToString , self.currentDownloadLenghtToString];
}

- (NSString *)percentageLabelText {
    return [NSString stringWithFormat:@"%.1f%%",([self.currentDownloadLenghtToString floatValue] / [self.totalLenghtToString floatValue] ) * 100];
    
}

- (void)createCacheDirectory:(NSString *)path {
    NSFileManager * fm = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    if (![fm fileExistsAtPath:path isDirectory:&isDirectory]) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES
                       attributes:@{NSFileProtectionKey:NSFileProtectionNone} error:nil];
    }
}

- (void)writeDiskCache {
    if (_downloadPath != nil) {
        [self createCacheDirectory:[WHC_DownloadObject cacheDirectory]];
        [NSKeyedArchiver archiveRootObject:self
                                    toFile:[WHC_DownloadObject getCachedFileName:_fileName]];//_downloadPath
        [self createCacheDirectory:[WHC_DownloadObject cachePlistDirectory]];
        NSMutableDictionary * cacheDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[WHC_DownloadObject cachePlistPath]];
        if (cacheDictionary == nil) {
            cacheDictionary = [NSMutableDictionary dictionary];
        }
        [cacheDictionary setObject:@"WHC" forKey:_fileName];//_downloadPath
        
        [cacheDictionary writeToFile:[WHC_DownloadObject cachePlistPath] atomically:YES];
        
        
//        DownloadObject *loadObject = [[DownloadObject alloc] init];//创建表
//        loadObject.fileName = self.fileName;
//        loadObject.downloadState = 1;
//        loadObject.totalLenght = self.totalLenght;
//        loadObject.currentDownloadLenght = self.currentDownloadLenght;
//        loadObject.downloadPath = self.downloadPath;
//        loadObject.downloadSpeed = self.downloadSpeed;
//        loadObject.hostID = self.hostID;
//        [DownloadObject save:loadObject resBlock:^(BOOL res) {
//            NSLog(@"---->保存DownloadObject成功：=%@====-%ld---",loadObject.fileName,(long)loadObject.hostID);
//        }];
        
    }
}

- (void)removeFromDisk {
    NSFileManager * fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:[WHC_DownloadObject getCachedFileName:_fileName]]) {//_downloadPath
        [fm removeItemAtPath:[WHC_DownloadObject getCachedFileName:_fileName] error:nil];//_downloadPath
        NSMutableDictionary * cacheDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[WHC_DownloadObject cachePlistPath]];
        if (cacheDictionary != nil) {
            [cacheDictionary removeObjectForKey:_fileName];//_downloadPath
            [cacheDictionary writeToFile:[WHC_DownloadObject cachePlistPath] atomically:YES];
        }
        if ([fm fileExistsAtPath:[NSString stringWithFormat:@"%@%@",[WHC_DownloadObject videoDirectory],_fileName]]) {
            [fm removeItemAtPath:[NSString stringWithFormat:@"%@%@",[WHC_DownloadObject videoDirectory],_fileName] error:nil];
        }
    }
}

@end
