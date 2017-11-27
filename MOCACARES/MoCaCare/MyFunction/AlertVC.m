//
//  AlertVC.m
//  ThirteenWater
//
//  Created by xhb on 2017/6/1.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "AlertVC.h"

@interface AlertVC ()

@end

@implementation AlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 修改背景颜色
//    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.view.backgroundColor = [UIColor clearColor];
    self.viewAlert.backgroundColor = [UIColor clearColor];
    
    /// 添加高斯模糊
//    [self addBlurEffect:UIBlurEffectStyleDark];
    
    self.tap_dismiss = YES;
    /// 背景触摸退出
    [self addTapBackDismiss];
}

/// 添加高斯模糊
- (void)addBlurEffect:(UIBlurEffectStyle)style {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effecView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effecView.userInteractionEnabled = NO;
    effecView.frame = M_Window.bounds;
    [self.view insertSubview:effecView atIndex:0];
}

/// 背景触摸退出
- (void)addTapBackDismiss {
    UIButton *bgBtn = [[UIButton alloc] initWithFrame:M_Window.bounds];
    bgBtn.backgroundColor = [UIColor clearColor];
    [bgBtn addTarget:self action:@selector(tapBackgroupView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:bgBtn atIndex:0];
}

- (void)tapBackgroupView:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.tap_dismiss)
        [self buttonDismissTouchUpInside:sender];
}
- (IBAction)buttonDismissTouchUpInside:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismiss];
    /// 父级界面一起消失, 只在点击关闭按钮或者背景触摸消失事件才出发该功能
    if ([self.parentViewController isKindOfClass:[AlertVC class]]) {
        [((AlertVC *)self.parentViewController) dismiss];
    } 
}

/**
 * 视图控制器提示窗
 * @param parentVC :承载的父控制器
 */
- (void)displayWithParentViewController:(UIViewController *)parentVC {
    [parentVC addChildViewController:self];
    UIView *superView = parentVC.view;
    self.view.bounds = superView.bounds;
    self.view.center = superView.center;
    [superView addSubview:self.view];
    self.viewAlert.transform = CGAffineTransformMakeScale(0, 0);
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.viewAlert.transform = CGAffineTransformIdentity;
        self.view.center = parentVC.view.center;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
/**
 * 隐藏视图控制器提示窗
 */
- (void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            self.view.alpha = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
    });
}
@end
