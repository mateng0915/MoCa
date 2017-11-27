//
//  AccountLoginTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "AccountLoginTVC.h"
#import "MainTabBarController.h"
#import "ServiceAccount.h"

@implementation AccountLoginTVC

/** 显示界面 */
+ (void)display {
    UIWindow *window = [UIApplication sharedApplication].keyWindow; 
    UINavigationController *NVC = [self defaultLoginNVC];
    window.rootViewController = NVC;
}
/** 实例化变量 */
+ (UINavigationController *)defaultLoginNVC {
    static UINavigationController *NVC;
    if (!NVC) {
        NVC = [UIStoryboard storyboardWithName:@"AccountOperation" bundle:nil].instantiateInitialViewController;
//        NSLog(@"%@", NVC);
    }
    return NVC;
} 

#pragma mark - 视图加载
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ShowBtnEvents(NO);
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /// 修改控件样式
    [self setTextFieldStyle:self.textFieldEmail];
    [self setTextFieldStyle:self.textFieldPassword];
    self.btnLogin.layer.cornerRadius = 8;
    self.btnSignUp.layer.cornerRadius = 8;
    self.btnLookAround.layer.cornerRadius = 8;
    /// 设置tableCell自适应
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

#pragma mark - 设置输入框样式
- (void)setTextFieldStyle:(UITextField *)textField {
    textField.backgroundColor = [UIColor clearColor];
    textField.layer.borderWidth = 1.0;
    textField.layer.borderColor = [UIColor whiteColor].CGColor;
    textField.layer.cornerRadius = 8;
    textField.delegate = self;
}

#pragma mark - 按钮事件
/** 登录 */
- (IBAction)btnLoginClick:(UIButton *)sender {
//    NSLog(@"Login");
    if (!M_CheckStrNil(self.textFieldEmail.text) ||
        !M_CheckStrNil(self.textFieldPassword.text)) {
        [MyFunction displayAlertLabelWithMessage:@"Please fill in the form"];
        return;
    }
    sender.userInteractionEnabled = NO;
    [ServiceAccount loginEmail:self.textFieldEmail.text password:self.textFieldPassword.text success:^{
        sender.userInteractionEnabled = YES;
        [MainTabBarController display];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}
/** 游客登录 */
- (IBAction)btnLookAroundClick:(UIButton *)sender {
    NSLog(@"LookAround");
    [MainTabBarController display];
}


#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.tableView endEditing:YES];
    return YES;
}

@end
