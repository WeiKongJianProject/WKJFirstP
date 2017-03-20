//
//  DownloadModel.h
//  ABBPlayer
//
//  Created by beyondsoft-聂小波 on 16/9/20.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHC_DownloadObject.h"
#import <WHCNetWorkKit/WHC_HttpManager.h>
#import "Reachability.h"


#define WHC_BackgroundDownload (1)

// showMsg
typedef void(^DownloadModelShowMsg)(NSString *message);

@interface DownloadModel : NSObject

/** showMsg */
@property (nonatomic, copy  ) DownloadModelShowMsg showModelMssage;

- (void)downLoadWith:(NSString *)playUrl title:(NSString *)title defaultFormat:(NSString *)defaultFormat;
@end
