//
//  MainTabBarController.h
//  MoCaCare
//
//  Created by xhb on 2017/9/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h> 

@interface MainTabBarController : UITabBarController


/// 按钮——发布活动（组织者才有该功能）
@property (nonatomic, strong) UIButton *btnPostEvent;

/** 实例化变量 */
+ (instancetype)defaultTabBarController;

/** 显示控制器
 */
+ (void)display;

/** 初始化子控件 */
- (void)setChildNavigationViewControllers;
@end
