//
//  EventDetailCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EventCell.h"

@class ModelEventDetail;
@interface EventDetailCell : EventCell
/// 活动封面
@property (weak, nonatomic) IBOutlet UIImageView *imgVThumb;
/// 活动标题
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/// 活动副标题（类别）
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
/// 活动时间
@property (weak, nonatomic) IBOutlet UIButton *btnTime;
/// 活动地点
@property (weak, nonatomic) IBOutlet UIButton *btnAddress;
/// 举办者头像
@property (weak, nonatomic) IBOutlet UIButton *btnOrganizationHeader;
/// 活动描述
@property (weak, nonatomic) IBOutlet UILabel *lblDes;

/// 活动详情数据模型
@property (nonatomic, weak) ModelEventDetail *model;

/** 点击活动时间 */
- (IBAction)btnTimeClick:(UIButton *)sender;
/** 点击活动地点 */
- (IBAction)btnAddressClick:(UIButton *)sender;
/** 点击举办者头像 */
- (IBAction)btnOrganizationHeaderClick:(UIButton *)sender;

@end
