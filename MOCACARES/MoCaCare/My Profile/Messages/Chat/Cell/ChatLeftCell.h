//
//  ChatLeftCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatTVC.h"

@class ModelChatMsg;
@interface ChatLeftCell : UITableViewCell
/// 头像
@property (weak, nonatomic) IBOutlet UIButton *btnHeader;
/// 消息内容
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
/// 消息背景
@property (weak, nonatomic) IBOutlet UIView *viewMsg;

/// 承载容器
@property (nonatomic, strong) ChatTVC *tvc;
/// 数据
@property (nonatomic, weak) ModelChatMsg *model;

/** 点击头像 */
- (IBAction)btnHeaderClick:(UIButton *)sender;
@end
