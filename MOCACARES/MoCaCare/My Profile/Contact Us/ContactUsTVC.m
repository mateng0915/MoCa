//
//  ContactUsTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ContactUsTVC.h"
#import "ServiceMyProfile.h"

@implementation ContactUsTVC 
- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.rowHeight = 100;
    
    self.textView.layer.cornerRadius = 4;
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.borderColor = [UIColor darkTextColor].CGColor;
    self.btnSubmit.layer. cornerRadius = 4;
}
#pragma mark - <TableViewDataSource>
#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - 按钮事件
- (IBAction)btnSubmitClick:(UIButton *)sender {
    NSLog(@"Submit");
    NSString *content = self.textView.text;
    if (content.length < 15) {
        [MyFunction displayAlertLabelWithMessage:@"Please enter at least 15 characters"];
        return;
    }
    sender.userInteractionEnabled = NO;
    [ServiceMyProfile feedback:content success:^{
        sender.userInteractionEnabled = YES;
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}
@end
