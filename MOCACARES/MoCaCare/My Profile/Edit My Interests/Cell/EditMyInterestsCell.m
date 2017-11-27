//
//  EditMyInterestsCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EditMyInterestsCell.h"
#import "SeeUserPageVC.h"
#import "UIButton+WebCache.h"
#import "Service.h"
#import "ModelMyProfile.h"

@implementation EditMyInterestsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnFollow.layer.cornerRadius = 4.0;
    self.btnHeader.userInteractionEnabled = NO; 
} 
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.btnHeader &&
        self.btnHeader.layer.cornerRadius == 0) {
        [self.contentView layoutIfNeeded];
        self.btnHeader.layer.masksToBounds = YES;
        self.btnHeader.layer.cornerRadius = self.btnHeader.bounds.size.width / 2.0;
    }
}

#pragma mark - 设置内容样式
- (void)setModel:(ModelMyInterests *)model {
    if (!model)
        return;
    _model = model;
    [self.btnHeader sd_setBackgroundImageWithURL:[Service getImageCompleteURLWithString:model.u_img] forState:UIControlStateNormal placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
    self.lblName.text = model.u_username;
    self.lblDes.text = model.u_statement;
}

#pragma mark - 按钮事件
- (IBAction)btnFollowClick:(UIButton *)sender {
    [MyFunction displayAlertWithViewController:self.tvc title:nil message:@"Are you sure you want to unfollow this account?" sure:^(UIAlertAction *action) {
//        NSLog(@"取消关注");
        sender.userInteractionEnabled = NO;
        [ServiceMyProfile followUser:self.model.uid success:^(BOOL statue) {
            sender.userInteractionEnabled = YES;
            [self.tvc requestData];
        } failure:^{
            sender.userInteractionEnabled = YES;
        }];
    } cancel:^(UIAlertAction *action) {
    
    }];
}

- (IBAction)btnHeaderClick:(UIButton *)sender {
//    NSLog(@"个人中心");
    [SeeUserPageVC displayWithViewController:self.tvc
                                      userId:self.model.fid];
}
@end
