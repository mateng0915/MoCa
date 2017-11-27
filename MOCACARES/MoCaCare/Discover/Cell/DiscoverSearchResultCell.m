//
//  DiscoverSearchResultCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "DiscoverSearchResultCell.h"
#import "Service.h"
#import "SDImageCache.h"

#define PlaceholderIMGHVarW 100.0/750
@implementation DiscoverSearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imgVThumb.image = [MyFunction originImage:[MyFunction creatImageWithColor:PlaceholderColor] scaleToSize:CGSizeMake(M_Width, M_Width * PlaceholderIMGHVarW)];
    self.lblDes.preferredMaxLayoutWidth = M_Width - 15 * 2 - AutoSwitchWidth(15) * 2 - 1;
}

/// 计算Cell高度
+ (CGFloat)cellHeightWithEvent:(ModelEvent *)event {
    CGFloat width = M_Width - 15 * 2 - AutoSwitchWidth(15) * 2;
    CGFloat height = [MyFunction getLabelSizeWithMessage:event.desrc fontSize:13 labelWidth:width].height;
    height = height > 15 ? height : 15;
    height += 8 * 5;
    height += (20 + 15);
    // 从缓存里获取图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:event.img];
    // 没有找到图片就使用默认的占位图
    if (!image) {
        image = [MyFunction creatImageWithColor:PlaceholderColor];
        height += M_Width * PlaceholderIMGHVarW;
    } else {
        CGFloat w = M_Width - 8 * 2 - AutoSwitchWidth(15) * 2;
        height += w * image.size.height / image.size.width;
    }
    return height;
}

/// 设置Cell内容
- (void)setEvent:(ModelEvent *)event {
    if (!event)
        return;
    _event = event;
    
    [self.imgVThumb sd_setImageWithURL:[Service getImageCompleteURLWithString:event.img] placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:errSecDeviceFailed];
//    self.lblDes.text = event.content;
    self.lblDes.text = event.desrc;
    self.lblTitle.text = event.title;
    self.lblCategory.text = event.t_name;
}
@end
