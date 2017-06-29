//
//  MianZeViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/5/10.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "MianZeViewController02.h"

@interface MianZeViewController02 ()

@end

@implementation MianZeViewController02

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    [self startAFnetWorking];
    
    
}

- (void)startAFnetWorking{
    
    NSString * url = [NSString stringWithFormat:@"%@&action=statement",URL_Common_ios];
    NSLog(@"免责声明：链接：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dic[@"result"] isEqualToString:@"success"]) {
            NSString * string = dic[@"content"];
            
            //NSString * htmlstr = [NSString stringWithFormat:@"<html><body>%@</body></html>",string];
            
            //[self.webView loadHTMLString:htmlstr baseURL:nil];
            self.label.text = string;
        }
        
        NSLog(@"免责声明结果：%@",dic);
    } failure:^(NSError *error) {
        
    }];

}

- (IBAction)backButtonAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
