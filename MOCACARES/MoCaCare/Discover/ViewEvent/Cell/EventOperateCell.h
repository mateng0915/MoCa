//
//  EventOperateCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EventCell.h"

@class ModelEventDetail;
@interface EventOperateCell : EventCell
/// 按钮——订阅、收藏
@property (weak, nonatomic) IBOutlet UIButton *btnBookmark;
/// 按钮——参加活动
@property (weak, nonatomic) IBOutlet UIButton *btnParticipate;

/// 活动详情数据模型
@property (nonatomic, weak) ModelEventDetail *model;

/** 收藏活动 */
- (IBAction)btnBookmarkClick:(UIButton *)sender;
/** 参加活动 */
- (IBAction)btnParticipateClick:(UIButton *)sender;
@end
