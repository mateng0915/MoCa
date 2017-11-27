//
//  DiscoverCVCFlowLayout.m
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "DiscoverCVCFlowLayout.h"
#import "DiscoverSearchResultCell.h"
#import "ModelDiscover.h"

static CGFloat ofs8;
static CGFloat ofs15;
@implementation DiscoverCVCFlowLayout

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)direction {
    if (self = [super init]) {
        self.scrollDirection = direction;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    ofs8 = AutoSwitchWidth(8);
    ofs15 = AutoSwitchWidth(15); 
    // item 上下最小间距
    self.minimumLineSpacing = ofs15;
    // item 左右最小间距
    self.minimumInteritemSpacing = ofs15;
}

#pragma mark - 计算Cell大小
+ (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = 0, height = 0;
    if (indexPath.section == 0) {
        width = (M_Width - ofs15 * 2 - ofs8 * 2) - 1;
        height = width / 3.0;
    } else if (indexPath.section == 1) {
        width = M_Width - ofs15 * 2 - 1;
        height = AutoSwitchWidth(60.0);
    } else {
        width = (M_Width - ofs15 * 3) / 2.0 - 1;
        height = width;
    }
    CGSize size = CGSizeMake(width, height);
    return size;
}

+ (CGSize)sizeForTopTypeItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (M_Width - ofs15 * 4) / 3.0;
    CGSize size = CGSizeMake(width, width);
    return size;
}

+ (CGSize)sizeForSearchResultItemAtIndexPath:(NSIndexPath *)indexPath
                               searchResults:(NSArray<ModelEvent *> *)results {
    CGFloat width = 0, height = 0; 
    if (indexPath.section == 0 ||
        indexPath.section == 1) {
        return [self sizeForItemAtIndexPath:indexPath];
    } else {
        width = M_Width - ofs15 * 2;
        ModelEvent *event = results[indexPath.row];
        height = [DiscoverSearchResultCell cellHeightWithEvent:event];
    }
    CGSize size = CGSizeMake(width, height);
    return size;
}

#pragma mark - 计算Section空白填充
+ (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (section == 0) {
        insets = UIEdgeInsetsMake(ofs8, ofs8, 0, ofs8);
    } else if (section == 1) {
        insets = UIEdgeInsetsMake(ofs8, ofs15, ofs8, ofs15);
    } else {
        insets = UIEdgeInsetsMake(0, ofs15, 22, ofs15);
    }
    return insets;
}
@end
