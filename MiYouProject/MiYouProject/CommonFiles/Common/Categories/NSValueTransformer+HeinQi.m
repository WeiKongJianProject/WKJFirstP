//
//  NSValueTransformer+HeinQi.m
//  FashionShop
//
//  Created by 王闻昊 on 15/8/24.
//  Copyright (c) 2015年 HeinQi. All rights reserved.
//

#import "NSValueTransformer+HeinQi.h"
#import <Mantle/MTLValueTransformer.h>

NSString * const HQDateValueTransformerName = @"HQDateValueTransformerName";

@implementation NSValueTransformer (HeinQi)

+(void)load {
    @autoreleasepool {
        MTLValueTransformer *dateValueTransformer = [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *value, BOOL *success, NSError **error) {
            if (!value) return nil;
            
            if (![value isKindOfClass:NSNumber.class]) {
                if (error != NULL) {
                    NSDictionary *userInfo = @{
                                               NSLocalizedDescriptionKey: NSLocalizedString(@"Could not convert value to NSDate", @""),
                                               NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedString(@"Expected an NSNumber, got: %@.", @""), value],
                                               MTLTransformerErrorHandlingInputValueErrorKey : value
                                               };
                    
                    *error = [NSError errorWithDomain:MTLTransformerErrorHandlingErrorDomain code:MTLTransformerErrorHandlingErrorInvalidInput userInfo:userInfo];
                }
                *success = NO;
                return nil;
            }
            
            NSDate *result = [NSDate dateWithTimeIntervalSince1970:value.doubleValue/1000];
            
            if (!result) {
                if (error != NULL) {
                    NSDictionary *userInfo = @{
                                               NSLocalizedDescriptionKey: NSLocalizedString(@"Could not convert value to NSDate", @""),
                                               NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedString(@"Input vaule %@ was malformed", @""), value],
                                               MTLTransformerErrorHandlingInputValueErrorKey : value
                                               };
                    
                    *error = [NSError errorWithDomain:MTLTransformerErrorHandlingErrorDomain code:MTLTransformerErrorHandlingErrorInvalidInput userInfo:userInfo];
                    
                    *success = NO;
                    return nil;
                }
            }
            
            return result;
            
        } reverseBlock:^id(NSDate *date, BOOL *success, NSError **error) {
            if (!date) return nil;
            
            if (![date isKindOfClass:NSDate.class]) {
                if (error != NULL) {
                    NSDictionary *userInfo = @{
                                               NSLocalizedDescriptionKey: NSLocalizedString(@"Could not convert Date to Number", @""),
                                               NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedString(@"Expected an NSDate, got: %@.", @""), date],
                                               MTLTransformerErrorHandlingInputValueErrorKey : date
                                               };
                    
                    *error = [NSError errorWithDomain:MTLTransformerErrorHandlingErrorDomain code:MTLTransformerErrorHandlingErrorInvalidInput userInfo:userInfo];
                }
                *success = NO;
                return nil;
            }
            
            return [NSNumber numberWithDouble:[date timeIntervalSince1970]*1000];
        }];
        
        [NSValueTransformer setValueTransformer:dateValueTransformer forName:HQDateValueTransformerName];
    }
}

@end
