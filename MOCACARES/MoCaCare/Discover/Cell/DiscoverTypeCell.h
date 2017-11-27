//
//  DiscoverTypeCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverTypeCell : UICollectionViewCell
/// 类别图标
@property (weak, nonatomic) IBOutlet UIImageView *imgVType;
/// 类别名称
@property (weak, nonatomic) IBOutlet UILabel *lblType;

@end
