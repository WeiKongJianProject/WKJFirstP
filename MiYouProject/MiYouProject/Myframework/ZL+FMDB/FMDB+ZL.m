//
//  FMDB+ZL.m
//  SecondProject
//
//  Created by wkj on 2017/3/7.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "FMDB+ZL.h"

@implementation FMDB_ZL
static FMDB_ZL * shareObj = nil;

//创建数据库
- (FMDatabase *)createDBwithName:(NSString *)nameStr{
    //1.获取数据库文件路径
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    NSString * nameString = [NSString stringWithFormat:@"%@.sqlite",nameStr];
    NSString * fileName = [doc stringByAppendingPathComponent:nameString];
    NSLog(@"数据库的路径：%@",fileName);
    //获取数据库
    FMDatabase * db = [FMDatabase databaseWithPath:fileName];
    return db;
}
//获取数据库路径
- (NSString *)dbLuJing:(NSString *)nameStr{
    //1.获取数据库文件路径
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    NSString * nameString = [NSString stringWithFormat:@"%@.sqlite",nameStr];
    NSString * fileName = [doc stringByAppendingPathComponent:nameString];
    return fileName;
}
//创建表
- (BOOL)createDbTablewithTableName:(NSString *)tableName withDB:(FMDatabase *)DB withSQLiteInfo:(NSString *)sqliteString{
    BOOL isSuccess = NO;
    
    if ([DB open])
    {
        
        //4.创表
        //sqlite语句实例
        //@"CREATE TABLE IF NOT EXISTS t_home_searchHistory (id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,age integer NOT NULL);"
        BOOL result = [DB executeUpdate:sqliteString];
        
        if (result)
        {
            NSLog(@"创建表成功");
            isSuccess = YES;
        }else {
            NSLog(@"创表失败");
            isSuccess = NO;
        }
    }
    else{
        isSuccess = NO;
        NSLog(@"打开数据库失败");
    }

    return isSuccess;
}
//表中插入数据
- (BOOL)insertTableWithDBlujing:(NSString *)dbLuJing withSQLiteInfo:(NSString *)sqlLiteString withCanSHu01:(NSString *)canShu01 withCanShu02:(NSString *)canShu02 withCanShu03:(NSString *)canShu03 withCanShu04:(NSString *)canShu04{
    /*
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    //
    NSString *fileName = [doc stringByAppendingPathComponent:@"searchHistory.sqlite"];
     */
    //2.创建队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbLuJing];
    __block BOOL whoopsSomethingWrongHappened = true;
//    //可变参数
//    va_list args;
//    va_start(args, sqlLiteString);
//    va_end(args);

    
    //2.把任务包装到事务里  安全性高
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         /*
          whoopsSomethingWrongHappened &=  [db executeUpdate:@"INSERT INTO myTable VALUES (?)",[NSNumber numberWithInt:1]];
          whoopsSomethingWrongHappened &= [db executeUpdate:@"INSERT INTO myTable VALUES (?)",[NSNumber numberWithInt:2]];
          whoopsSomethingWrongHappened &= [db executeUpdate:@"INSERT INTO myTable VALUES (?)",[NSNumber
          numberWithInt:3]];
          */

         //插入数据库  sql 实例语句 @"INSERT INTO t_home_searchHistory(name,age) VALUES (?,?);",@"周++",@"10000"
         whoopsSomethingWrongHappened &= [db executeUpdate:sqlLiteString,canShu01,canShu02,canShu03,canShu04];
         //如果有错误 返回
         if (!whoopsSomethingWrongHappened)
         {
             *rollback = YES;
             return;
         }
     }];
    
    return YES;
}
//删除表中数据
- (BOOL)deleteTableWithDBlujing:(NSString *)dbLuJing withSQLiteInfo:(NSString *)sqlLiteString withCanSHu01:(NSString *)canShu01 withCanShu02:(NSString *)canShu02 withCanShu03:(NSString *)canShu03 withCanShu04:(NSString *)canShu04{
    //创建队列
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:dbLuJing];
    __block BOOL whoopsSomethingWrongHappened = true;
    //在事物里 打包  执行
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        //修改更新 语句
        //@"delete from t_home_searchHistory where id = ?;",@(deleteId)
        whoopsSomethingWrongHappened &= [db executeUpdate:sqlLiteString,canShu01,canShu02,canShu03,canShu04];
        //如果有错误 返回
        if (!whoopsSomethingWrongHappened)
        {
            *rollback = YES;
            return;
        }
    }];
    return YES;
}
//更新表中数据 修改
- (BOOL)updateTableWithDBlujing:(NSString *)dbLuJing withSQLiteInfo:(NSString *)sqlLiteString withCanSHu01:(NSString *)canShu01 withCanShu02:(NSString *)canShu02 withCanShu03:(NSString *)canShu03 withCanShu04:(NSString *)canShu04
{
    //1.创建队列
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:dbLuJing];
    __block BOOL whoopsSomethingWrongHappened = true;
    //在事物里 打包  执行
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        //删除语句 @"update t_home_searchHistory set name = ? where name = ?;",@"王",@"周"]
        whoopsSomethingWrongHappened &= [db executeUpdate:sqlLiteString,canShu01,canShu02,canShu03,canShu04];
        //如果有错误 返回
        if (!whoopsSomethingWrongHappened)
        {
            *rollback = YES;
            return;
        }
    }];

    return YES;
}
//查询表中数据
- (FMResultSet *)chaXunQueryTableWWithDBlujing:(NSString *)dbLuJing withSQLiteInfo:(NSString *)sqlLiteString{
    //1.创建队列
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:dbLuJing];
    __block FMResultSet * result = nil;
    //__block BOOL whoopsSomethingWrongHappened = true;
    //在事物里 打包  执行 手动开启 事物
         [queue inDatabase:^(FMDatabase *db) {
    
         // 开启事务
             [db beginTransaction];
             //查询语句 实例 @"SELECT * FROM t_home_searchHistory"
             FMResultSet *rs = [db executeQuery:sqlLiteString];
             result = rs;
         // 提交事务
             [db commit];
         }];
    /*
    //自动 在 事物 里处理方法
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        // 查询数据 @"SELECT * FROM t_home_searchHistory"
         FMResultSet *rs = [db executeQuery:sqlLiteString];
        
        // 遍历结果集  
     //在 外部控制器中执行
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"name"];
            int age = [rs intForColumn:@"age"];
            int id = [rs intForColumn:@"id"];
            NSLog(@"查询数据库中的数据为：%d-----%@----%d",id,name,age);
        }
        
       
    }];
    */
    return result;
}

#pragma mark  FMResultSet 查询结果转化方法
//intForColumn:
//longForColumn:
//longLongIntForColumn:
//boolForColumn:
//doubleForColumn:
//stringForColumn:
//dataForColumn:
//dataNoCopyForColumn:
//UTF8StringForColumnIndex:
//objectForColumn:
#pragma end mark


////数据库使用FMDB框架代码操作
////1.0创建数据库
//- (void)createDB{
//    //1.获得数据库文件的路径
//    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
//    //
//    NSString *fileName = [doc stringByAppendingPathComponent:@"searchHistory.sqlite"];
//    
//    //2.获得数据库
//    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
//    
//    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
//    if ([db open])
//    {
//        
//        //4.创表
//        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_searchHistory (id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,age integer NOT NULL);"];
//        
//        if (result)
//        {
//            NSLog(@"创建表成功");
//        }else {
//            NSLog(@"创表失败");
//        }
//    }
//    //更新
//    [db executeUpdate:@"UPDATE t_home_searchHistory SET age = ? WHERE name = ?;", @"21", @"lu"];
//    //插入
//    [db executeUpdate:@"INSERT INTO t_home_searchHistory(name,age) VALUES (?,?);",@"周",@"100"];
//    //将对象转化为 NSData
//    //NSData *petsData = [NSKeyedArchiver archivedDataWithRootObject:people.pets];
//    // 查询数据
//    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_home_searchHistory"];
//    
//    // 遍历结果集
//    while ([rs next]) {
//        NSString *name = [rs stringForColumn:@"name"];
//        int age = [rs intForColumn:@"age"];
//        NSLog(@"查询数据库中的数据为：%@----%d",name,age);
//    }
//    
//    //1.创建队列
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
//    __block BOOL whoopsSomethingWrongHappened = true;
//    
//    //2.把任务包装到事务里
//    [queue inTransaction:^(FMDatabase *db, BOOL *rollback)
//     {
//         whoopsSomethingWrongHappened &=  [db executeUpdate:@"INSERT INTO t_home_searchHistory VALUES (?)",[NSNumber numberWithInt:1]];
//         whoopsSomethingWrongHappened &= [db executeUpdate:@"INSERT INTO t_home_searchHistory VALUES (?)",[NSNumber numberWithInt:2]];
//         whoopsSomethingWrongHappened &= [db executeUpdate:@"INSERT INTO t_home_searchHistory VALUES (?)",[NSNumber
//                                                                                              numberWithInt:3]];
//         //如果有错误 返回
//         if (!whoopsSomethingWrongHappened)
//         {
//             *rollback = YES;
//             return;
//         }
//     }];
//    
//    /*
//     FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
//     
//     [queue inDatabase:^(FMDatabase *db) {
//     [db executeUpdate:@"INSERT INTO t_student(name) VALUES (?)", @"Jack"];
//     [db executeUpdate:@"INSERT INTO t_student(name) VALUES (?)", @"Rose"];
//     [db executeUpdate:@"INSERT INTO t_student(name) VALUES (?)", @"Jim"];
//     
//     FMResultSet *rs = [db executeQuery:@"select * from t_student"];
//     while ([rs next]) {
//     // …
//     }
//     }];
//     
//     [self.queue inDatabase:^(FMDatabase *db) {
//     
//     // 开启事务
//     [db beginTransaction];
//     BOOL result = [db executeUpdate:@"update t_student set age = 20 where id >= 20; "];
//     if (result) {
//     NSLog(@"修改成功");
//     }else{
//     NSLog(@"修改失败");
//     }
//     // 提交事务
//     [db commit];
//     }];
//     
//     */
//}





#pragma mark 单例
//-------------以下是单例写法----------
+ (FMDB_ZL *)shareFMDB{
    if(!shareObj){
        shareObj = [[super allocWithZone:NULL]init];
    
    }
    return shareObj;
}

+ (id)copyWithZone:(struct _NSZone*)zone{
    return [self shareFMDB];

}
- (id)copyWithZone:(NSZone *)zone{
    return self;
}

+ (instancetype)sharedInstance{
    static FMDB_ZL * shareObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObject = [[super allocWithZone:NULL]init];
    });
    return shareObject;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}
#pragma end mark
@end
