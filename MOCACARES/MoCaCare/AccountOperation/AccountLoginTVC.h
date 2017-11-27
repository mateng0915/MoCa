//
//  AccountLoginTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountLoginTVC : UITableViewController <UITextFieldDelegate>
/// 输入框——邮箱（账号）
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
/// 输入框——密码
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
/// 按钮——登录
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
/// 按钮——注册
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
/// 按钮——查看周围
@property (weak, nonatomic) IBOutlet UIButton *btnLookAround;


/** 显示界面 */
+ (void)display;

/** 实例化变量 */
+ (UINavigationController *)defaultLoginNVC;

/** 登录 */
- (IBAction)btnLoginClick:(UIButton *)sender;
/** 游客登录 */
- (IBAction)btnLookAroundClick:(UIButton *)sender;
@end
