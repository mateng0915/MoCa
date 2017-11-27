//
//  EditMyInterestsTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditMyProfileTVC : UITableViewController
/// 输入框——昵称
@property (weak, nonatomic) IBOutlet UITextField *textFieldUsername;
/// 输入框——年龄
@property (weak, nonatomic) IBOutlet UITextField *textFieldAge;
/// 输入框——职业
@property (weak, nonatomic) IBOutlet UITextField *textFieldOccupation;
/// 输入框——性别
@property (weak, nonatomic) IBOutlet UITextField *textFieldGender;
/// 输入框——描述
@property (weak, nonatomic) IBOutlet UITextView *textViewStatement;
/// 标签——账号类别
@property (weak, nonatomic) IBOutlet UILabel *lblType;
/// 标签——邮箱
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
/// 标签——密码
@property (weak, nonatomic) IBOutlet UILabel *lblPassword;
/// 按钮——修改密码
@property (weak, nonatomic) IBOutlet UIButton *btnResetPassword;
/// 按钮——公开邮箱
@property (weak, nonatomic) IBOutlet UIButton *btnPublicEmail;
/// 按钮——公开发布的活动
@property (weak, nonatomic) IBOutlet UIButton *btnPublicEvents;
/// 按钮——保存修改
@property (weak, nonatomic) IBOutlet UIButton *btnSaveEdit;

/** 修改密码 */
- (IBAction)btnResetPasswordClick:(UIButton *)sender;
/** 公开邮箱 */
- (IBAction)btnPublicEmailClick:(UIButton *)sender;
/** 公开发布的活动 */
- (IBAction)btnPublicEventsClick:(UIButton *)sender;
/** 保存修改 */
- (IBAction)btnSaveEditClick:(UIButton *)sender;

/// 公布邮箱标识
@property (nonatomic, assign) BOOL publicEmail;
/// 公布活动标识
@property (nonatomic, assign) BOOL publicEvents;
/// 未选择图片
@property (nonatomic, strong) UIImage *img_selected_n;
/// 选择图片
@property (nonatomic, strong) UIImage *img_selected_s;

@end
