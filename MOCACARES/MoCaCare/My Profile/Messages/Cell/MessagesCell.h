//
//  MessagesCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagesTVC.h"

@class ModelChatMsg, DXBadgeButton;
@interface MessagesCell : UITableViewCell
/// 头像
@property (weak, nonatomic) IBOutlet UIButton *btnHeader;
/// 用户名
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/// 用户描述
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
/// 注册日期？
@property (weak, nonatomic) IBOutlet UILabel *lblSignDay;
/// 新消息提醒标志
@property (weak, nonatomic) IBOutlet DXBadgeButton *badgeMsg;

/// 承载容器
@property (nonatomic, strong) MessagesTVC *tvc;
/// 数据
@property (nonatomic, weak) ModelChatMsg *model;

/** 点击头像 */
- (IBAction)btnHeaderClick:(UIButton *)sender;
@end
