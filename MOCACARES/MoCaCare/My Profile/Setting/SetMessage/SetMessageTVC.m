//
//  SetMessageTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/25.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "SetMessageTVC.h"
#import "ServiceMyProfile.h"

@implementation SetMessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.header.text = @"Message Setting";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.0;
    
    self.lblRow0.text = @"Receive only meeages from users I follow";
    
    [self setLableStyle:self.lblRow0 cornerRadius:4.0];
    self.imgVs = @[self.imgVRow0];
    
    ModelUser *user = [ModelUser defaultUser];
    self.idx = user.receive.integerValue;
    [self updateImg];
}
- (void)setLableStyle:(UILabel *)lbl cornerRadius:(CGFloat)radius {
    lbl.preferredMaxLayoutWidth = M_Width - 8 * 4 - 30 - 5 * 2 - 1;
    UIView *contentView = lbl.superview;
    UIView *bgView = [contentView viewWithTag:10];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.layer.cornerRadius = radius;
    bgView.layer.borderWidth = 1.0;
    bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

#pragma mark - <TableViewDataSource>

#pragma mark - <TableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    M_Window.userInteractionEnabled = NO;
    [ServiceMyProfile systemConfigRrecommend:0 notify:0 receive:self.idx success:^{
        if (self.idx == indexPath.row + 1) {
            self.idx = 0;
        } else {
            self.idx = indexPath.row + 1;
        }
        [self updateImg];
        M_Window.userInteractionEnabled = YES;
        [M_UserDefault setValue:@(self.idx) forKey:SystemConfigReceive];
        [M_UserDefault synchronize];
    } failure:^{
        M_Window.userInteractionEnabled = YES;
    }];
}

- (void)updateImg {
    [self.imgVs enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.image = [UIImage imageNamed:@"icon_selected_n"];
        if (idx == self.idx - 1) {
            obj.image = [UIImage imageNamed:@"icon_selected_s"];
        }
    }];
}

@end
