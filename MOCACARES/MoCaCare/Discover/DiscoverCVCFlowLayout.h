//
//  DiscoverCVCFlowLayout.h
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@class ModelEvent;
@interface DiscoverCVCFlowLayout : UICollectionViewFlowLayout

/*
 * 实例化变量
 * direction :拖动方向
 */
- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)direction;

/*
 * 计算Cell大小
 * @param indexPath :Cell所在位置
 */
+ (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/*
 * 计算顶部类别Cell大小
 * @param indexPath :Cell所在位置
 */
+ (CGSize)sizeForTopTypeItemAtIndexPath:(NSIndexPath *)indexPath;

/*
 * 计算搜索结果Cell大小
 * @param indexPath :Cell所在位置
 * @param results :结果
 */
+ (CGSize)sizeForSearchResultItemAtIndexPath:(NSIndexPath *)indexPath
                               searchResults:(NSArray<ModelEvent *> *)results;

/*
 * 计算Section空白填充
 * @param Section :Section
 */
+ (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section;
@end
