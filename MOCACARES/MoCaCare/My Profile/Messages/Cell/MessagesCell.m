//
//  MessagesCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MessagesCell.h"
#import "SeeUserPageVC.h"
#import "ModelMyProfile.h"
#import "Service.h"
#import "UIButton+WebCache.h"
#import "DXBadgeButton.h"

@implementation MessagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.badgeMsg.didClickBlock = ^(DXBadgeButton *badgeButton) {
        badgeButton.hidden = YES;
    };
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
#pragma mark - 设置内容
- (void)setModel:(ModelChatMsg *)model {
    if (!model)
        return;
    _model = model;
    self.lblName.text = model.name;
    self.lblDes.text = model.statement;
    self.lblSignDay.text = [model.u_time substringWithRange:NSMakeRange(5, 11)];
    [self.btnHeader sd_setBackgroundImageWithURL:[Service getImageCompleteURLWithString:model.img] forState:UIControlStateNormal placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed]; 
    self.badgeMsg.badgeString = model.no_read;
    self.badgeMsg.hidden = model.is_read.integerValue == 1 || model.no_read.integerValue == 0;
}

#pragma mark - 按钮事件
- (IBAction)btnHeaderClick:(UIButton *)sender {
//    NSLog(@"点击头像");
    [SeeUserPageVC displayWithViewController:self.tvc
                                      userId:self.model.uid];
}
@end
