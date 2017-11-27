//
//  SettingTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/25.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "SettingTVC.h"
#import "AccountLoginTVC.h"
#import "MainTabBarController.h"

@implementation SettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLableStyle:self.lblLogout];
    [self setLableStyle:self.lblMessage];
    [self setLableStyle:self.lblNotification];
    [self setLableStyle:self.lblRecommends];
    
    self.tableView.rowHeight = 44.0; 
    
    // 表头
    self.header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, M_Width, 120)];
    self.header.text = @"Setting";
    [self.header themeFontOfSize:20.0];
    self.header.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = self.header;
}
- (void)setLableStyle:(UILabel *)lbl {
    lbl.layer.masksToBounds = YES;
    lbl.layer.cornerRadius = 4.0;
    lbl.layer.borderWidth = 1.0;
    lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
}
#pragma mark - <TableViewDataSource>

#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
        return;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log Out" message:@"Are you sure log out ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ModelUser logOut];
        [AccountLoginTVC display];
    }];
    [alertController addAction:sureAc];
    UIAlertAction *cancelAc = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAc];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
