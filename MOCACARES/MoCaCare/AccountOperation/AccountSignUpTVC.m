//
//  AccountSignUpTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "AccountSignUpTVC.h"
#import "MainTabBarController.h"

@implementation AccountSignUpTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 修改控件样式
    [self setTextFieldStyle:self.textFieldEmail];
    [self setTextFieldStyle:self.textFieldUsername];
    [self setTextFieldStyle:self.textFieldPassword];
    [self setTextFieldStyle:self.textFieldRePassword];
    self.btnVolunteer.layer.cornerRadius = 8;
    self.btnOrganization.layer.cornerRadius = 8;
    self.btnSignAndLogin.layer.cornerRadius = 8;
    self.btnToLoginVC.layer.cornerRadius = 8;
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

#pragma mark - 按钮事件——选择注册类型
/** 注册志愿者账号 */
- (IBAction)btnVolunteerClick:(UIButton *)sender {
    [self signUpInType:AccountTypeVolunteer];
}
/** 注册组织者账号 */
- (IBAction)btnOrganizationClick:(UIButton *)sender {
    [self signUpInType:AccountTypeOrganization];
}
- (void)signUpInType:(AccountType)type {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AccountOperation" bundle:self.nibBundle];
    AccountSignUpTVC *VC = [sb instantiateViewControllerWithIdentifier:@"AccountSignUpTVC"];
    VC.accountType = type;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 按钮事件——注册新用户
/** 注册并登录 */
- (IBAction)btnSignAndLoginClick:(UIButton *)sender {
//    NSLog(@"SignAndLogin");
    if (!M_CheckStrNil(self.textFieldEmail.text) ||
        !M_CheckStrNil(self.textFieldUsername.text) ||
        !M_CheckStrNil(self.textFieldPassword.text) ||
        !M_CheckStrNil(self.textFieldRePassword.text)) {
        [MyFunction displayAlertLabelWithMessage:@"Please fill in the form"];
        return;
    }
    if (![self.textFieldPassword.text isEqualToString:self.textFieldRePassword.text]) {
        [MyFunction displayAlertLabelWithMessage:@"Password Inconsistency"];
        return;
    }
    sender.userInteractionEnabled = NO;
    [ServiceAccount registerAccountType:self.accountType email:self.textFieldEmail.text username:self.textFieldUsername.text password:self.textFieldPassword.text success:^{
        sender.userInteractionEnabled = YES;
        [MainTabBarController display];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}
/** 跳转到登录界面 */
- (IBAction)btnToLoginVCClick:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
