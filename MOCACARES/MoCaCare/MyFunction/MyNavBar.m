//
//  MyNavBar.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MyNavBar.h"
#import "MainTabBarController.h"

@implementation MyNavBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNavBar];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setNavBar];
    }
    return self;
}

- (void)setNavBar {
    [self layoutIfNeeded];
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat margin = 0.0;
    CGFloat height = 64.0;
    self.vLine = [[UIView alloc] initWithFrame:CGRectMake(margin, height-1, M_Width - 2 * margin, 1)];
    self.vLine.backgroundColor = [UIColor clearColor];
    
    UIColor *color1 = [ModelUser accountColor];
    UIColor *color2 = ThemeColorRed;
    // 创建渐变色图层
    CAGradientLayer *layer_l = [CAGradientLayer layer];
    CAGradientLayer *layer_r = [CAGradientLayer layer];
    // 设置渐变色方向
    layer_l.startPoint = CGPointMake(0, 0.5);
    layer_l.endPoint = CGPointMake(1, 0.5);
    layer_r.startPoint = CGPointMake(1, 0.5);
    layer_r.endPoint = CGPointMake(0, 0.5);
    // 设置渐变色
    layer_l.colors = @[(id)color1.CGColor,
                       (id)color2.CGColor];
    layer_r.colors = @[(id)color1.CGColor,
                       (id)color2.CGColor];
    // 设置渐变图层大小
    CGFloat w = self.vLine.bounds.size.width;
    CGFloat h = self.vLine.bounds.size.height;
    layer_l.frame = CGRectMake(0, 0, w / 2.0, h);
    layer_r.frame = CGRectMake(w / 2.0, 0, w / 2.0, h);
    [self.vLine.layer addSublayer:layer_l];
    [self.vLine.layer addSublayer:layer_r];
    
    [self addSubview:self.vLine];
    
    self.btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnBack.frame = CGRectMake(margin, 20, 44, 44);
    self.btnBack.tintColor = [UIColor darkTextColor];
    [self.btnBack setImage:[MyFunction createItemImageWithName:@"icon_back"] forState:UIControlStateNormal];
    
    UINavigationController *NVC = [self getCurrentNVC];
    self.btnBack.hidden = (NVC.viewControllers.count <= 1);
    [self.btnBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnBack];
    
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(margin + self.btnBack.bounds.size.width, 20, M_Width - 2 * (margin + self.btnBack.bounds.size.width), 44)];
    self.lblTitle.text = ThemeTitle;
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle.textColor = ThemeColor;
    self.lblTitle.backgroundColor = [UIColor clearColor];
//    [self.lblTitle themeBoldFontOfSize:20.0];
    self.lblTitle.font = [UIFont fontWithName:@"Exo2-thin" size:20.0];
    [self addSubview:self.lblTitle];
}
- (void)back:(UIButton *)sender {
    UINavigationController *NVC = [self getCurrentNVC];
//    UIViewController *VC = NVC.childViewControllers.lastObject;
//    NSLog(@"POPVC = 【%@】", [VC class]);
    if (NVC.viewControllers.count > 1) 
        [NVC popViewControllerAnimated:YES];
}
- (UINavigationController *)getCurrentNVC {
    UIViewController *RootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    NSLog(@"【%@】", [RootVC class]);
    if ([RootVC isKindOfClass:[MainTabBarController class]]) {
        MainTabBarController *TAB = (MainTabBarController *)M_VC;
        UINavigationController *NVC = TAB.childViewControllers[TAB.selectedIndex];
        return NVC;
    }
    return nil;
}
@end
