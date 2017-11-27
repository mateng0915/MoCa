//
//  EditMyInterestsTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EditMyProfileTVC.h"
#import "ServiceAccount.h"
#import "AccountEditPasswordVC.h"

@implementation EditMyProfileTVC

- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.rowHeight = 100;
    
    // 修改控件样式
    [self setTextFieldStyle:self.textFieldUsername];
    [self setTextFieldStyle:self.textFieldAge];
    [self setTextFieldStyle:self.textFieldOccupation];
    [self setTextFieldStyle:self.textFieldGender];
    self.textViewStatement.layer.cornerRadius = 4.0;
    self.textViewStatement.layer.borderWidth = 1.0;
    self.textViewStatement.layer.borderColor = [UIColor darkTextColor].CGColor;
    self.btnSaveEdit.layer.cornerRadius = 4.0;
    
    ModelUser *user = [ModelUser defaultUser];
    self.textFieldUsername.placeholder = user.username;
    self.lblType.text = user.type.integerValue == 2 ? @"Organisation" : @"Individual";
    self.lblEmail.text = user.email;
    self.textFieldAge.placeholder = user.age;
    self.textFieldOccupation.placeholder = user.occupation;
    self.textFieldGender.userInteractionEnabled = NO;
    self.textFieldGender.placeholder = user.sex.integerValue == 1 ? @"Male" : @"Female";
    
    self.publicEmail = user.is_show_email.boolValue;
    self.publicEvents = user.is_show_event.boolValue;
    self.img_selected_n = [UIImage imageNamed:@"icon_selected_n"];
    self.img_selected_s = [UIImage imageNamed:@"icon_selected_s"];
    [self updatePublickImage];
}
- (void)setTextFieldStyle:(UITextField *)textField {
    textField.superview.layer.cornerRadius = 4.0;
    textField.superview.layer.borderWidth = 1.0;
    textField.superview.layer.borderColor = [UIColor darkTextColor].CGColor;
}

#pragma mark - 更新图片
- (void)updatePublickImage {
    UIImage *img_publicEmail = self.img_selected_n;
    UIImage *img_publicEvents = self.img_selected_n;
    if (self.publicEmail)
        img_publicEmail = self.img_selected_s;
    if (self.publicEvents)
        img_publicEvents = self.img_selected_s;
    
    [self.btnPublicEmail setBackgroundImage:img_publicEmail forState:UIControlStateNormal];
    [self.btnPublicEvents setBackgroundImage:img_publicEvents forState:UIControlStateNormal];
}

#pragma mark - <TableViewDataSource>
#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 7) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        // 男
        UIAlertAction *male = [UIAlertAction actionWithTitle:@"Male" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.textFieldGender.text = action.title;
        }];
        // 女
        [alert addAction:male];
        UIAlertAction *female = [UIAlertAction actionWithTitle:@"Female" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.textFieldGender.text = action.title;
        }];
        [alert addAction:female];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            ShowBtnEvents(YES);
        }];
        [alert addAction:cancel];
        ShowBtnEvents(NO);
        [self presentViewController:alert animated:YES completion:nil];
    } else if (indexPath.row == 9) {
        [self btnPublicEmailClick:self.btnPublicEmail];
    } else if (indexPath.row == 10) {
        [self btnPublicEventsClick:self.btnPublicEvents];
    }
}

#pragma mark - 按钮事件
- (IBAction)btnResetPasswordClick:(UIButton *)sender {
//    NSLog(@"ResetPassword");
    sender.userInteractionEnabled = NO;
    [ServiceAccount sendPIDtoRegisteredEmailSuccess:^{
        sender.userInteractionEnabled = YES;
        AccountEditPasswordVC *VC = [AccountEditPasswordVC defalutType:EditPassword];
        [self.navigationController pushViewController:VC animated:YES];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}
- (IBAction)btnPublicEmailClick:(UIButton *)sender {
//    NSLog(@"PublicEmail");
    self.publicEmail = !self.publicEmail;
    [self updatePublickImage];
}
- (IBAction)btnPublicEventsClick:(UIButton *)sender {
//    NSLog(@"PubliEvents");
    self.publicEvents = !self.publicEvents;
    [self updatePublickImage];
}
- (IBAction)btnSaveEditClick:(UIButton *)sender {
//    NSLog(@"Save");
    ModelUser *user = [ModelUser defaultClearUser];
    user.username = M_CheckStrNil(self.textFieldUsername.text);
    user.age = M_CheckStrNil(self.textFieldAge.text);
    user.occupation = M_CheckStrNil(self.textFieldOccupation.text);
    user.sex = [M_CheckStrNil(self.textFieldGender.text) isEqualToString:@"Male"] ? @"1" : @"2";
    
    user.statement = M_CheckStrNil(self.textViewStatement.text);
    user.is_show_email = [@(self.publicEmail) description];
    user.is_show_event = [@(self.publicEvents) description];
    
    sender.userInteractionEnabled = NO;
    [ServiceAccount eidtUserInfo:user success:^{
        [self.navigationController popViewControllerAnimated:YES];
        sender.userInteractionEnabled = NO;
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}
@end
