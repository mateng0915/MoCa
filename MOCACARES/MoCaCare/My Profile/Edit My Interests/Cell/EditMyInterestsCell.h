//
//  EditMyInterestsCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditMyInterestsTVC.h"

@class ModelMyInterests;
@interface EditMyInterestsCell : UITableViewCell
/// 头像
@property (weak, nonatomic) IBOutlet UIButton *btnHeader;
/// 标签——用户名
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/// 标签——描述
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
/// 按钮——关注、跟随
@property (weak, nonatomic) IBOutlet UIButton *btnFollow;

/// 承载容器
@property (nonatomic, strong) EditMyInterestsTVC *tvc;
/// 数据模型
@property (nonatomic, weak) ModelMyInterests *model;

/** 点击头像 */
- (IBAction)btnHeaderClick:(UIButton *)sender;
/** 关注|取消关注用户 */
- (IBAction)btnFollowClick:(UIButton *)sender;

@end
