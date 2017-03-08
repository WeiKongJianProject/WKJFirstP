//
//  UIButton+ZLWebPSetImage.m
//  Matro
//
//  Created by lang on 16/8/22.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#import "UIButton+ZLWebPSetImage.h"

@implementation UIButton (ZLWebPSetImage)

- (void)setZLWebPButton_ImageWithURLStr:(NSString *)urlStr withPlaceHolderImage:(UIImage *)placeImage{
    [self setImage:placeImage forState:UIControlStateNormal];
    //http://pic8.nipic.com/20100705/5304996_090725061810_2.jpg
    //http://obh57x2dk.bkt.clouddn.com/OH4H8VH65DW9.webp
    //创建url对象
    NSURL * url = [NSURL URLWithString:urlStr];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //2.1创建请求方式(默认是get,这一步可以不写)
    [request setHTTPMethod:@"get"];
    
    //创建响应对象(有时会出错)
    //NSURLResponse *response = nil;
    
    //创建连接对象
    //NSError *error = nil;
    //NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //self.image = [UIImage imageWithWebPData:data];
    
    //创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    /*
     //创建task(该方法内部做了处理,默认使用get)
     NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
     //NSLog(@"%@",data);
     [self setImage:[UIImage imageWithWebPData:data]];
     //NSLog(@"是否是主线程%d",[[NSThread mainThread]isMainThread]);
     }];
     */
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            [self performSelectorOnMainThread:@selector(changeImage:) withObject:data waitUntilDone:YES];
        }
        //NSLog(@"是否是主线程%d",[[NSThread mainThread] isMainThread]);
    }];
    
    //启动回话
    [task resume];

}
- (void)changeImage:(NSData *)data{
    [self setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
}

- (void)setZLWebPButton_BackgroundImageWithURLStr:(NSString *)urlStr withPlaceHolderImage:(UIImage *)placeImage{
    
    [self setBackgroundImage:placeImage forState:UIControlStateNormal];
    //http://pic8.nipic.com/20100705/5304996_090725061810_2.jpg
    //http://obh57x2dk.bkt.clouddn.com/OH4H8VH65DW9.webp
    //创建url对象
    NSURL * url = [NSURL URLWithString:urlStr];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //2.1创建请求方式(默认是get,这一步可以不写)
    [request setHTTPMethod:@"get"];
    
    //创建响应对象(有时会出错)
    //NSURLResponse *response = nil;
    
    //创建连接对象
    //NSError *error = nil;
    //NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //self.image = [UIImage imageWithWebPData:data];
    
    //创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    /*
     //创建task(该方法内部做了处理,默认使用get)
     NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
     //NSLog(@"%@",data);
     [self setImage:[UIImage imageWithWebPData:data]];
     //NSLog(@"是否是主线程%d",[[NSThread mainThread]isMainThread]);
     }];
     */
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            [self performSelectorOnMainThread:@selector(changeBackgroundImage:) withObject:data waitUntilDone:YES];
        }
        //NSLog(@"是否是主线程%d",[[NSThread mainThread] isMainThread]);
    }];
    
    //启动回话
    [task resume];



}

- (void)changeBackgroundImage:(NSData *)data{
    [self setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
}

@end
