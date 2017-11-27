//
//  DiscoverActivityCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelEvent;
@interface DiscoverActivityCell : UICollectionViewCell
/// 封面
@property (weak, nonatomic) IBOutlet UIImageView *imgVThumb;
/// 标题
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/// 类别
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;

/// 数据模型
@property (nonatomic, weak) ModelEvent *event; 
@end
