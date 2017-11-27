//
//  AccountEditPasswordTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/10/12.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountEditPasswordTVC : UITableViewController<UITextFieldDelegate>

#pragma mark - 修改密码
/// 提示
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
/// 个人身份号码
@property (weak, nonatomic) IBOutlet UITextField *textFieldPin;
/// 新密码
@property (weak, nonatomic) IBOutlet UITextField *textFieldNewPSD;
/// 确认密码
@property (weak, nonatomic) IBOutlet UITextField *textFieldRePSD;
/// 提交按钮
@property (weak, nonatomic) IBOutlet UIButton *btnEnter;

/** 提交 */
- (IBAction)btnEnterClick:(UIButton *)sender;

#pragma mark - 修改完成
/// 完成提示
@property (weak, nonatomic) IBOutlet UILabel *lblCompleted;
/// 完成按钮
@property (weak, nonatomic) IBOutlet UIButton *btnReturn;

/** 完成 */
- (IBAction)btnReturnClick:(UIButton *)sender;

@end
