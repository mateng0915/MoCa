//
//  NotificationsCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationsTVC.h"

@interface NotificationsCell : UITableViewCell
/// 头像
@property (weak, nonatomic) IBOutlet UIButton *btnHeader;
/// 活动标题
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/// 活动简介
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
/// 志愿者提问
@property (weak, nonatomic) IBOutlet UILabel *lblNotification;
/// 承载容器
@property (nonatomic, strong) NotificationsTVC *tvc;

/** 点击头像 */
- (IBAction)btnHeaderClick:(UIButton *)sender;
@end
