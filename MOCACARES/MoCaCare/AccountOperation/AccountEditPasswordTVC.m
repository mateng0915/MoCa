//
//  AccountEditPasswordTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/10/12.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "AccountEditPasswordTVC.h"
#import "AccountEditPasswordVC.h"
#import "ServiceAccount.h"

@implementation AccountEditPasswordTVC

#pragma mark - 界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, M_Width, 22.0)];
    
    [self setTextFieldStyle:self.textFieldPin];
    [self setTextFieldStyle:self.textFieldNewPSD];
    [self setTextFieldStyle:self.textFieldRePSD];
    self.btnEnter.layer.cornerRadius = 8;
    self.btnReturn.layer.cornerRadius = 8;
    if (self.lblDes) {
        NSString *str = [NSString stringWithFormat:@"A temporary PIN has been sent to\nyour registered email.\nPlease enter below:"];
        self.lblDes.text = str;
    }
    if (self.lblCompleted) {
        NSMutableAttributedString *mAtr = [[NSMutableAttributedString alloc] initWithString:@"Congratulations!\nNow your password has\nbeen reset."];
        [mAtr addAttribute:NSForegroundColorAttributeName value:ThemeColorRed range:NSMakeRange(0, @"Congratulations!".length)];
        self.lblCompleted.attributedText = mAtr;
    }
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
- (IBAction)btnEnterClick:(UIButton *)sender {
    if (!M_CheckStrNil(self.textFieldPin.text) ||
        !M_CheckStrNil(self.textFieldNewPSD.text) ||
        !M_CheckStrNil(self.textFieldRePSD.text)) {
        [MyFunction displayAlertLabelWithMessage:@"please fill in the form"];
        return;
    }
    if (![self.textFieldNewPSD.text isEqualToString:self.textFieldRePSD.text]) {
        [MyFunction displayAlertLabelWithMessage:@"please reconfirm the password"];
        return;
    }
    sender.userInteractionEnabled = NO;
    [ServiceAccount setNewPassword:self.textFieldNewPSD.text PIN:self.textFieldPin.text success:^{
        sender.userInteractionEnabled = YES;
        AccountEditPasswordVC *VC = [AccountEditPasswordVC defalutType:EditPasswordCompleted];
        NSMutableArray<UIViewController *> *VCS = [self.navigationController.viewControllers mutableCopy];
        [VCS removeLastObject];
        [VCS addObject:VC];
        [self.navigationController setViewControllers:VCS animated:YES];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}
- (IBAction)btnReturnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableViewDataSource

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.tableView endEditing:YES];
    return YES;
}

@end
