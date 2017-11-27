//
//  EventCommentCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EventCell.h"

@class ModelComment;
@interface EventCommentCell : EventCell <UITextViewDelegate>
/// 评论输入框
@property (weak, nonatomic) IBOutlet UITextView *textViewInput;
/// 评论者头像
@property (weak, nonatomic) IBOutlet UIButton *btnHeader;
/// 评论者用户名
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
/// 评论内容父视图
@property (weak, nonatomic) IBOutlet UIView *viewComment;
/// 评论内容
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
/// 按钮-发送评论
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

/// 评论数据模型
@property (nonatomic, weak) ModelComment *model;
 
/** 点击头像 */
- (IBAction)btnHeaderClick:(UIButton *)sender;
/** 发送评论 */
- (IBAction)btnSendClick:(UIButton *)sender;

@end
