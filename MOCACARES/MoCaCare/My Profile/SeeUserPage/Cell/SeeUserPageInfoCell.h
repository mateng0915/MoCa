//
//  SeeUserPageInfoCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeeUserPageTVC.h"

@interface SeeUserPageInfoCell : UITableViewCell
/// 头像
@property (weak, nonatomic) IBOutlet UIImageView *imgVHeader;
/// 用户名
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
/// 职业
@property (weak, nonatomic) IBOutlet UILabel *lblOccupation;
/// 描述
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
/// 按钮——关注
@property (weak, nonatomic) IBOutlet UIButton *btnFollow;
/// 按钮——发送消息
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;

/// 承载容器
@property (nonatomic, weak) SeeUserPageTVC *tvc;

/** 关注 */
- (IBAction)btnFollowClick:(UIButton *)sender;
/** 发送消息 */
- (IBAction)btnMessageClick:(UIButton *)sender;

@end
