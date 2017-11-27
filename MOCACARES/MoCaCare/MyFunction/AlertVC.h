//
//  AlertVC.h
//  ThirteenWater
//
//  Created by xhb on 2017/6/1.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertVC : UIViewController

/// 是否开启背景触摸关闭(默认开启)
@property (nonatomic, assign) BOOL tap_dismiss;

/// 弹窗主体
@property (weak, nonatomic) IBOutlet UIView *viewAlert;

/**
 * 视图控制器提示窗
 * @param parentVC :承载的父控制器
 */
- (void)displayWithParentViewController:(UIViewController *)parentVC;
/**
 * 隐藏视图控制器提示窗
 */
- (void)dismiss;
/**
 * 退出按钮声明
 */
- (IBAction)buttonDismissTouchUpInside:(UIButton *)sender;

/**
 * 添加高斯模糊背景
 * @param style :模糊深度
 */
- (void)addBlurEffect:(UIBlurEffectStyle)style;

/**
 * 背景触摸消失
 * @param sender :背景按钮
 */
- (void)tapBackgroupView:(UIButton *)sender;
@end
