//
//  ZLCollectionGirdVIew.h
//  MiYouProject
//
//  Created by apple on 2017/3/12.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GNColGridView;

//用collectionView实现

@protocol GNColGridViewDelegagte <NSObject>

@required
//每行的高度
- (CGFloat)heightForRowInGridView:(GNColGridView *)gridView;
//gridView列的数量
- (NSInteger)numberOfColumsInGridView:(GNColGridView *)gridView;
//gridView中item总量
- (NSInteger)totolNumberOfGridView:(GNColGridView *)gridView;
//返回每个item
- (UIButton *)gridView:(GNColGridView *)gridView gridAtIndex:(NSInteger)index;
@optional
//item点击事件
- (void)gridView:(GNColGridView *)gridView onItemClick:(NSInteger)index;

@end
@interface ZLCollectionGirdVIew : UIView
@property (nonatomic, weak) id<GNColGridViewDelegagte> delegate;

- (void)reLoadData;
@end
