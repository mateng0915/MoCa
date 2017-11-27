//
//  MyEventsVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEventsVC : UIViewController
/// 导航视图
@property (weak, nonatomic) IBOutlet UIView *viewNav;
/// 主体显示视图
@property (weak, nonatomic) IBOutlet UIView *viewContent;
/// 按钮——行程表
@property (weak, nonatomic) IBOutlet UIButton *btnCalendar;
/// 按钮——书签
@property (weak, nonatomic) IBOutlet UIButton *btnBookmark;
/// 按钮——我的活动
@property (weak, nonatomic) IBOutlet UIButton *btnHosted;
/// 约束——我的活动按钮宽度（组织者宽度屏幕1/3,参与者为0）
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutBtnHostedWidth;

/** 查看行程表 */
- (IBAction)btnCalendarClick:(UIButton *)sender;
/** 查看书签 */
- (IBAction)btnBookmarkClick:(UIButton *)sender;
/** 查看举办的活动 */
- (IBAction)btnHostedClick:(UIButton *)sender;
@end
