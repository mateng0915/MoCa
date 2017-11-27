//
//  SeeUserPageInfoCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "SeeUserPageInfoCell.h"
#import "ChatVC.h"
#import "ServiceMyProfile.h"

@implementation SeeUserPageInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblOccupation.preferredMaxLayoutWidth = M_Width - 8 * 2 - 1;
    self.lblDes.preferredMaxLayoutWidth = M_Width - 8 * 2 - 1;
    self.btnFollow.layer.cornerRadius = 4.0;
    self.btnMessage.layer.cornerRadius = 4.0;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.imgVHeader &&
        self.imgVHeader.layer.cornerRadius == 0) {
        [self.contentView layoutIfNeeded];
        self.imgVHeader.layer.masksToBounds = YES;
        self.imgVHeader.layer.cornerRadius = self.imgVHeader.bounds.size.width / 2.0;
    } 
}

#pragma mark - 设置内容
- (void)setTvc:(SeeUserPageTVC *)tvc {
    if (!tvc)
        return;
    _tvc = tvc;
    ModelUserZone *model = tvc.zone;
    [self.imgVHeader sd_setImageWithURL:[Service getImageCompleteURLWithString:model.user.img] placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
    self.lblUsername.text = model.user.username;
    self.lblOccupation.text = model.user.occupation;
    self.btnFollow.backgroundColor = model.is_friend.integerValue == 1 ? FollowYColor : FollowNColor;
    self.lblDes.text = model.user.statement;
}

#pragma mark - 按钮事件
- (IBAction)btnFollowClick:(UIButton *)sender {
//    NSLog(@"Follow");
    sender.userInteractionEnabled = NO;
    [ServiceMyProfile followUser:self.tvc.userId success:^(BOOL statue) {
        sender.userInteractionEnabled = YES;
        self.tvc.zone.is_friend = [@(statue) description];
        [self.tvc.tableView reloadData];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}

- (IBAction)btnMessageClick:(UIButton *)sender {
//    NSLog(@"Message");
    [ChatVC displayWithViewController:self.tvc
                           chatUserId:self.tvc.userId
                             chatName:self.tvc.zone.user.username];
}
@end
