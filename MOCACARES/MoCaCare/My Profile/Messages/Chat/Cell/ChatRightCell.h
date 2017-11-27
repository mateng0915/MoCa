//
//  ChatRightCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelChatMsg;
@interface ChatRightCell : UITableViewCell

/// 消息内容
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
/// 消息背景
@property (weak, nonatomic) IBOutlet UIView *viewMsg;

/// 数据
@property (nonatomic, weak) ModelChatMsg *model;
@end
