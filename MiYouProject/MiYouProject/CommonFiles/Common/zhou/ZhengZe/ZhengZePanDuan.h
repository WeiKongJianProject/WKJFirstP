//
//  ZhengZePanDuan.h
//  1PXianProject
//
//  Created by apple on 15/11/15.
//  Copyright (c) 2015年 JiJianNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhengZePanDuan : NSObject
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;
#pragma 6-20位数字或字符组合
+ (BOOL)checkPasswordMeiLuo:(NSString *)password;
#pragma 英文字母
+ (BOOL)checkEnglishZiMu:(NSString *)string;
#pragma 中文判断
+ (BOOL)checkZhongWen:(NSString *)zhongWen;
@end
