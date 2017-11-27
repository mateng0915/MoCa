//
//  HostedByMeCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HostedByMeTVC, ModelEvent;
@interface HostedByMeCell : UITableViewCell

/// 封面
@property (weak, nonatomic) IBOutlet UIImageView *imgVThumb;
/// 活动标题
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/// 活动简述
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
/// 活动时间
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
/// 编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
/// 检查按钮
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;

/// 承载控制器
@property (nonatomic, strong) HostedByMeTVC *tvc;
/// 事件数据模型
@property (nonatomic, weak) ModelEvent *model;

/** 预定、取消该活动 */
- (IBAction)btnCheckClick:(UIButton *)sender;
/** 编辑 */
- (IBAction)btnEditClick:(UIButton *)sender;
@end
