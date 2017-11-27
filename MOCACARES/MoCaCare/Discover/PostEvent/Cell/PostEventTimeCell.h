//
//  PostEventTimeCell.h
//  MoCaCare
//
//  Created by xhb on 2017/10/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventCell.h"

@interface PostEventTimeCell : PostEventCell

#pragma mark - 时间
/// 时间选框背景
@property (weak, nonatomic) IBOutlet UIView *viewTime;
/// 时间模式
@property (weak, nonatomic) IBOutlet UILabel *lblTimeModel;

/** 设置时间模式 */
- (IBAction)btnTimeModelClick:(UIButton *)sender;

#pragma mark - One-off
/// 开始日期
@property (weak, nonatomic) IBOutlet UIButton *btnDayStart;
/// 结束日期
@property (weak, nonatomic) IBOutlet UIButton *btnDayEnd;
/// 开始小时
@property (weak, nonatomic) IBOutlet UIButton *btnHourStart;
/// 结束小时
@property (weak, nonatomic) IBOutlet UIButton *btnHourEnd;

/** 设置开始日期 */
- (IBAction)btnDayStartClick:(UIButton *)sender;
/** 设置结束日期 */
- (IBAction)btnDayEndClick:(UIButton *)sender;
/** 设置开始小时 */
- (IBAction)btnHourStartClick:(UIButton *)sender;
/** 设置结束小时 */
- (IBAction)btnHourEndClick:(UIButton *)sender;

#pragma mark - Recurring
/// 周几
@property (weak, nonatomic) IBOutlet UIButton *btnWeek;
/// 结束时间
@property (weak, nonatomic) IBOutlet UIButton *btnDay;

/** 设置周几 */
- (IBAction)btnWeekClick:(UIButton *)sender;
/** 设置开始日期 */
- (IBAction)btnDayClick:(UIButton *)sender;

#pragma mark - To be advice







@end
