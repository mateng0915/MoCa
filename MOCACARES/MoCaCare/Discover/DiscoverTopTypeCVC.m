//
//  DiscoverTopTypeCVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "DiscoverTopTypeCVC.h"
#import "DiscoverCVC.h"
#import "DiscoverTypeCell.h"
#import "DiscoverCVCFlowLayout.h"
#import "ServiceDiscover.h"

@implementation DiscoverTopTypeCVC


- (void)viewDidLoad {
    [super viewDidLoad];
    /// 去除顶部预留空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self registerCellNibName:@"DiscoverTypeCell"];
    
    [self requestData];
}
- (void)registerCellNibName:(NSString *)name {
    [self.collectionView registerNib:[UINib nibWithNibName:name bundle:self.nibBundle] forCellWithReuseIdentifier:name];
}

#pragma mark - 数据请求
- (void)requestData {
    [ServiceDiscover getEventCategoryListSuccess:^(NSArray<ModelEventCategory *> *list) {
        self.categorys = [list copy];
        [self.collectionView reloadData];
    } failure:^{
        
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categorys.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverTypeCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"DiscoverTypeCell" forIndexPath:indexPath];
    ModelEventCategory *model = self.categorys[indexPath.row];
    [cell.imgVType sd_setImageWithURL:[Service getImageCompleteURLWithString:model.img] placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
    cell.lblType.text = model.name;
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [DiscoverCVCFlowLayout sizeForTopTypeItemAtIndexPath:indexPath];
    return size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    return insets;
} 

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UIViewController *VC = self.parentViewController;
    if ([VC isKindOfClass:[DiscoverCVC class]]) {
        DiscoverCVC *DVC = (DiscoverCVC *)VC;
        ModelEventCategory *model = self.categorys[indexPath.row];
        [DVC requestCategoryId:model.id
                        search:DVC.currentSearchStr
                   clearEvents:YES];
    }
}
@end
