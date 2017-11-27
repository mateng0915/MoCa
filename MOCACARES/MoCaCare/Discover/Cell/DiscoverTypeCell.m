//
//  DiscoverTypeCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "DiscoverTypeCell.h"

@implementation DiscoverTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedBackgroundView = [UITableViewCell new].selectedBackgroundView; 
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.imgVType.layer.cornerRadius == 0) {
        [self layoutIfNeeded];
        self.imgVType.layer.masksToBounds = YES;
        self.imgVType.layer.cornerRadius = self.imgVType.bounds.size.width / 2.0;
    }
}

@end
