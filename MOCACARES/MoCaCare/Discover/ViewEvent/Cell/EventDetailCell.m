//
//  EventDetailCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EventDetailCell.h"
#import "SeeUserPageVC.h"
#import "ServiceDiscover.h"

@implementation EventDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblTitle.preferredMaxLayoutWidth = M_Width - 15 * 2 -1;
    self.lblDes.preferredMaxLayoutWidth = M_Width - 15 * 2 - 1;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.btnOrganizationHeader &&
        self.btnOrganizationHeader.layer.cornerRadius == 0) {
        [self.contentView layoutIfNeeded];
        self.btnOrganizationHeader.layer.masksToBounds = YES;
        self.btnOrganizationHeader.layer.cornerRadius = self.btnOrganizationHeader.bounds.size.width / 2.0;
    }
}

#pragma mark - 设置内容样式
- (void)setModel:(ModelEventDetail *)model {
    if (!model)
        return;
    _model = model;
    // 封面
    [self.imgVThumb sd_setImageWithURL:[Service getImageCompleteURLWithString:model.img] placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
    // 头像
    [self.btnOrganizationHeader sd_setBackgroundImageWithURL:[Service getImageCompleteURLWithString:model.u_img] forState:UIControlStateNormal placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
    self.lblTitle.text = model.title;
    self.lblCategory.text = model.t_name;
    self.lblDes.text = model.desrc;
    [self.btnAddress setTitle:model.add forState:UIControlStateNormal];
     
    NSString *time = [model getTime];
    [self.btnTime setTitle:time forState:UIControlStateNormal];
}

#pragma mark - 按钮事件
- (IBAction)btnTimeClick:(UIButton *)sender {
    NSLog(@"Time");
}
- (IBAction)btnAddressClick:(UIButton *)sender {
    NSLog(@"Address");
}
- (IBAction)btnOrganizationHeaderClick:(UIButton *)sender {
//    NSLog(@"个人中心");
    [SeeUserPageVC displayWithViewController:self.tvc userId:self.model.uid];
}
@end
