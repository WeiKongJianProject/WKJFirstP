//
//  ZLCollectionGirdVIew.m
//  MiYouProject
//
//  Created by apple on 2017/3/12.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLCollectionGirdVIew.h"
#define kGNCOLGRIDVIEWID @"GNCOLGRIDVIEWID"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@protocol GNColGridViewLayoutDelegate <NSObject>

- (NSInteger)numberOfColums;
- (NSInteger)totolNumber;
- (CGFloat)height;

@end

@interface GNColGridViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<GNColGridViewLayoutDelegate> delegate;
@property (nonatomic, assign) NSInteger col;
@property (nonatomic, assign) NSInteger sum;
@property (nonatomic, assign) CGFloat height; //每行高度

@end

@implementation GNColGridViewLayout

- (NSInteger)col {
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfColums)]) {
        return [_delegate numberOfColums];
    }
    return 0;
}

- (NSInteger)sum {
    if (_delegate && [_delegate respondsToSelector:@selector(totolNumber)]) {
        return [_delegate totolNumber];
    }
    return 0;
}

- (CGFloat)height {
    if (_delegate && [_delegate respondsToSelector:@selector(height)]) {
        return [_delegate height];
    }
    return 0;
}

- (CGSize)collectionViewContentSize {
    if (self.col <= 0) {
        return CGSizeZero;
    }
    
    NSInteger row = self.sum / self.col + ((self.sum % self.col) > 0 ? 1: 0);
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = self.height * row;
    return CGSizeMake(width, height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
- (void)prepareLayout
{
    [super prepareLayout];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    if (self.col <= 0) {
        return attributes;
    }
    CGFloat itemWidth = SCREEN_WIDTH / self.col;
    attributes.center =  CGPointMake((indexPath.row % self.col + 0.5) * itemWidth, self.height * (indexPath.row / self.col + 0.5));
    attributes.size = CGSizeMake(itemWidth, self.height);
    attributes.indexPath = indexPath;
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < [array count]; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

@end

@interface ZLCollectionGirdVIew()<UICollectionViewDataSource, UICollectionViewDelegate, GNColGridViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation ZLCollectionGirdVIew
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)initUI {
    GNColGridViewLayout *layout = [[GNColGridViewLayout alloc] init];
    [layout setDelegate:self];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kGNCOLGRIDVIEWID];
    [self addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger sum = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(totolNumberOfGridView:)]) {
        sum = [_delegate totolNumberOfGridView:self];
    }
    return sum;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath   {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGNCOLGRIDVIEWID forIndexPath:indexPath];
    if (_delegate && [_delegate respondsToSelector:@selector(gridView:gridAtIndex:)]) {
        for (UIView *subView in cell.contentView.subviews) {
            if (subView.subviews) {
                [subView removeFromSuperview];
            }
        }
        UIButton *view = [UIButton new];
        view = [_delegate gridView:self gridAtIndex:indexPath.row];
        view.tag = indexPath.row;
        [view addTarget:self action:@selector(onItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [view setCenter:CGPointMake(cell.frame.size.width / 2, cell.frame.size.height / 2)];
//        view.center.x = cell.frame.size.width / 2;
//        view.center.y = cell.frame.size.height / 2;
        [cell.contentView addSubview:view];
    }
    return cell;
}

#pragma mark - GNColGridViewLayoutDelegate
- (NSInteger)numberOfColums {
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfColumsInGridView:)]) {
        return [_delegate numberOfColumsInGridView:self];
    }
    return 0;
}

- (NSInteger)totolNumber {
    if (_delegate && [_delegate respondsToSelector:@selector(totolNumberOfGridView:)]) {
        return [_delegate totolNumberOfGridView:self];
    }
    return 0;
}

- (CGFloat)height {
    if (_delegate && [_delegate respondsToSelector:@selector(heightForRowInGridView:)]) {
        return [_delegate heightForRowInGridView:self];
    }
    return 0.0;
}

#pragma mark - action
- (void)onItemClick:(UIButton*) button{
    if (_delegate && [_delegate respondsToSelector:@selector(gridView:onItemClick:)]) {
        [_delegate gridView:self onItemClick:button.tag];
    }
}

#pragma mark - public
- (void)reLoadData {
    NSInteger row = [self totolNumber] / [self numberOfColums] + (([self totolNumber] % [self numberOfColums]) > 0 ? 1: 0);
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = self.height * row;
    [_collectionView setContentSize:CGSizeMake(SCREEN_WIDTH, height)];
    //_collectionView.frame.size.height = height;
    [_collectionView reloadData];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
