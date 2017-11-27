//
//  MenuVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MenuVC.h"
#import "MenuTVC.h"

@interface MenuVC ()
/// 侧边菜单
@property (nonatomic, strong) MenuTVC *menuTVC;
@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:self.view.bounds];
    [btn addTarget:self action:@selector(btnBgClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)btnBgClick:(UIButton *)sender {
    [self dismiss];
}

- (void)displayWithViewController:(UIViewController *)VC
                        categorys:(NSArray<ModelEventCategory *> *)categorys
                selectedCategorys:(NSArray<ModelEventCategory *> *)selectedCategorys
                       selectMenu:(blockSelectMenu)selected {
    [VC.tabBarController addChildViewController:self];
    [VC.tabBarController.view addSubview:self.view];
    [VC.tabBarController.view bringSubviewToFront:self.view];
    self.menuTVC = [[MenuTVC alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:self.menuTVC]; 
    self.menuTVC.tableView.frame = CGRectMake(M_Width, 0, MenuWidth, M_Height);
    [self.view addSubview:self.menuTVC.view];
    self.menuTVC.blockMenu = selected;
    self.menuTVC.categorys = categorys;
    self.menuTVC.selectedCategorys = [selectedCategorys mutableCopy];
    ShowBtnEvents(NO);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.menuTVC.tableView.frame = CGRectMake(M_Width - MenuWidth, 0, MenuWidth, M_Height);
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.menuTVC.tableView.frame = CGRectMake(M_Width, 0, MenuWidth, M_Height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            self.menuTVC = nil;
        }
        ShowBtnEvents(YES);
    }];
}
@end
