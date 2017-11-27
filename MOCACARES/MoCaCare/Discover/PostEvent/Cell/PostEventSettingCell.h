//
//  PostEventSettingCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventCell.h"

@interface PostEventSettingCell : PostEventCell

#pragma mark - 类别
/// 类别选框背景
@property (weak, nonatomic) IBOutlet UIView *viewCategory;
/// 当前类别
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;

/** 设置类别 */
- (IBAction)btnCategoryClick:(UIButton *)sender;

#pragma mark - 活动操作
/// 按钮——发布|更新活动
@property (weak, nonatomic) IBOutlet UIButton *btnPostEvent;
/// 按钮——删除活动
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteEvent;

/** 发布活动 */
- (IBAction)btnPostEventClick:(UIButton *)sender;
/** 删除活动 */
- (IBAction)btnDeleteEventClick:(UIButton *)sender;
@end
