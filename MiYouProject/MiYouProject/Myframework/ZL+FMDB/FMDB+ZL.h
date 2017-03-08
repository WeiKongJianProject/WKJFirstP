//
//  FMDB+ZL.h
//  SecondProject
//
//  Created by wkj on 2017/3/7.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface FMDB_ZL : NSObject
//单例  创建

+ (instancetype)sharedInstance;

//增 删  改  查
//创建数据库
- (FMDatabase *)createDBwithName:(NSString *)nameStr;
//获取数据库路径
- (NSString *)dbLuJing:(NSString *)nameStr;
//创建表
- (BOOL)createDbTablewithTableName:(NSString *)tableName withDB:(FMDatabase *)DB withSQLiteInfo:(NSString *) sqliteString;
//表中插入数据
- (BOOL)insertTableWithDBlujing:(NSString *)dbLuJing
                 withSQLiteInfo:(NSString *)sqlLiteString
                   withCanSHu01:(NSString *) canShu01
                   withCanShu02:(NSString *)canShu02
                   withCanShu03:(NSString *)canShu03
                   withCanShu04:(NSString *) canShu04;
//删除表中数据
- (BOOL)deleteTableWithDBlujing:(NSString *)dbLuJing
                 withSQLiteInfo:(NSString *)sqlLiteString
                   withCanSHu01:(NSString *)canShu01
                   withCanShu02:(NSString *)canShu02
                   withCanShu03:(NSString *)canShu03
                   withCanShu04:(NSString *)canShu04;;
//更新 修改表中数据
- (BOOL)updateTableWithDBlujing:(NSString *)dbLuJing
                 withSQLiteInfo:(NSString *)sqlLiteString
                   withCanSHu01:(NSString *)canShu01
                   withCanShu02:(NSString *)canShu02
                   withCanShu03:(NSString *)canShu03
                   withCanShu04:(NSString *)anShu04;;
//查询表中数据
- (FMResultSet *)chaXunQueryTableWWithDBlujing:(NSString *)dbLuJing withSQLiteInfo:(NSString *)sqlLiteString;

@end
