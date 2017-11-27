//
//  DiscoverActivityCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "DiscoverActivityCell.h"
#import "Service.h"
#import "ModelDiscover.h"

@implementation DiscoverActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgVThumb.image = [MyFunction creatImageWithColor:PlaceholderColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.imgVThumb.layer.cornerRadius == 0) {
        [self layoutIfNeeded];
        self.imgVThumb.layer.masksToBounds = YES;
        self.imgVThumb.layer.cornerRadius = AutoSwitchWidth(15); 
    }
}

/// 设置Cell内容
- (void)setEvent:(ModelEvent *)event {
    if (!event)
        return;
    _event = event;
    
    [self.imgVThumb sd_setImageWithURL:[Service getImageCompleteURLWithString:event.img] placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:errSecDeviceFailed];
    self.lblTitle.text = event.title;
    self.lblCategory.text = event.t_name;
}
@end
