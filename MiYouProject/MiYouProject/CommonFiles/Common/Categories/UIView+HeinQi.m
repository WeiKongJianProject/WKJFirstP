//
//  UIView+HeinQi.m
//  FashionShop
//
//  Created by 王闻昊 on 15/8/13.
//  Copyright (c) 2015年 HeinQi. All rights reserved.
//

#import "UIView+HeinQi.h"
#import "UIColor+HeinQi.h"
#import "HFSConstants.h"

@implementation UIView (HeinQi)

-(void)showBadgeValue:(NSString *)value {
    
    [self removeBadgeValue];
    
    UITabBar *tabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:@"" image:nil tag:0];
    
    item.badgeValue = value;
    tabBar.items = @[item];
    
    for (UIView *viewTab in tabBar.subviews) {
        for (UIView *subview in viewTab.subviews) {
            NSString *className = [NSString stringWithUTF8String:object_getClassName(subview)];
            
            if ([className isEqualToString:@"UITabBarButtonBadge"] || [className isEqualToString:@"_UIBadgeView"]) {
                [subview removeFromSuperview];
                [self addSubview:subview];
                subview.frame = CGRectMake(self.frame.size.width - subview.frame.size.width / 2, - subview.frame.size.height / 2, subview.frame.size.width, subview.frame.size.height);
            }
        }
    }
}

-(void)removeBadgeValue {
    for (UIView *subview in self.subviews) {
        NSString *className = [NSString stringWithUTF8String:object_getClassName(subview)];
        
        if ([className isEqualToString:@"UITabBarButtonBadge"] || [className isEqualToString:@"_UIBadgeView"]) {
            [subview removeFromSuperview];
//            break;
        }
    }
}

-(void)loginType{
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithHexString:@"#AE8E5D"].CGColor;
    
    for (id tf in self.subviews) {
        if ([tf isKindOfClass:[UITextField class]]) {
            ((UITextField *)tf).textColor = [UIColor colorWithHexString:@"260e00"];
            [((UITextField *)tf) setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
    }
    
}


@end
