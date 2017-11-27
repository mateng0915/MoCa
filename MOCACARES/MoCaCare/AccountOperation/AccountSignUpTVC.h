//
//  AccountSignUpTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceAccount.h"

@interface AccountSignUpTVC : UITableViewController<UITextFieldDelegate>

#pragma mark - 选择注册类型
/// 按钮——志愿者
@property (weak, nonatomic) IBOutlet UIButton *btnVolunteer;
/// 按钮——组织者
@property (weak, nonatomic) IBOutlet UIButton *btnOrganization;

/** 注册志愿者账号 */
- (IBAction)btnVolunteerClick:(UIButton *)sender;
/** 注册组织者账号 */
- (IBAction)btnOrganizationClick:(UIButton *)sender;

#pragma mark - 注册账号
/// 输入框——邮箱（账号）
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
/// 输入框——用户名（昵称）
@property (weak, nonatomic) IBOutlet UITextField *textFieldUsername;
/// 输入框——密码
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
/// 输入框——确认密码
@property (weak, nonatomic) IBOutlet UITextField *textFieldRePassword;
/// 按钮——注册并登录
@property (weak, nonatomic) IBOutlet UIButton *btnSignAndLogin;
/// 按钮——跳转到登录界面
@property (weak, nonatomic) IBOutlet UIButton *btnToLoginVC;
/// 按钮——查看周围
@property (weak, nonatomic) IBOutlet UIButton *btnLookAround;
/// 注册类型
@property (nonatomic, assign) AccountType accountType;

/** 注册并登录 */
- (IBAction)btnSignAndLoginClick:(UIButton *)sender;
/** 跳转到登录界面 */
- (IBAction)btnToLoginVCClick:(UIButton *)sender;
/** 游客登录 */
- (IBAction)btnLookAroundClick:(UIButton *)sender;

@end
