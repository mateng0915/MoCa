//
//  DiscoverSearchResultCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelDiscover.h"

@interface DiscoverSearchResultCell : UICollectionViewCell
/// 封面
@property (weak, nonatomic) IBOutlet UIImageView *imgVThumb;
/// 标题
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/// 类别
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
/// 描述
@property (weak, nonatomic) IBOutlet UILabel *lblDes;

/// 数据模型
@property (nonatomic, weak) ModelEvent *event;
/*
 * 计算高度
 * @param des :描述内容
 */
+ (CGFloat)cellHeightWithEvent:(ModelEvent *)event;

@end
