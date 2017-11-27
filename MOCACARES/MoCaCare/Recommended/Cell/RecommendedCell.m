//
//  RecommendedCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "RecommendedCell.h"
#import "Service.h"
#import "ModelDiscover.h"

@implementation RecommendedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblDes.preferredMaxLayoutWidth = M_Width - 15 * 2 - 1;
    self.imgVThumb.image = [MyFunction creatImageWithColor:PlaceholderColor];
}

/// 设置Cell内容
- (void)setEvent:(ModelEvent *)event {
    if (!event)
        return;
    _event = event;
    
    [self.imgVThumb sd_setImageWithURL:[Service getImageCompleteURLWithString:event.img] placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:errSecDeviceFailed];
    self.lblTitle.text = event.title;
    self.lblCategory.text = event.t_name;
    self.lblDes.text = event.desrc;
}
@end
