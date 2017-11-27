//
//  ChatLeftCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ChatLeftCell.h"
#import "SeeUserPageVC.h"
#import "ModelMyProfile.h"
#import "Service.h"
#import "UIButton+WebCache.h"

@implementation ChatLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewMsg.layer.cornerRadius = 4.0;
    self.lblMsg.preferredMaxLayoutWidth = M_Width - 8 * 3 - 5 * 2 - 60 * 2 - 1; // 多-1防止误差
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
    self.lblMsg.text = model.msg;
    [self.btnHeader sd_setBackgroundImageWithURL:[Service getImageCompleteURLWithString:model.f_img] forState:UIControlStateNormal placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
}

#pragma mark - 按钮
- (IBAction)btnHeaderClick:(UIButton *)sender {
//    NSLog(@"点击头像");
    [SeeUserPageVC displayWithViewController:self.tvc
                                      userId:self.model.fid];
}
@end
