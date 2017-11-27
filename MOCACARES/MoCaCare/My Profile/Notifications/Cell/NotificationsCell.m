//
//  NotificationsCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "NotificationsCell.h"
#import "SeeUserPageVC.h"

@implementation NotificationsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblDes.preferredMaxLayoutWidth = M_Width - 8 * 3 - 50;
    self.lblNotification.preferredMaxLayoutWidth = M_Width - 8 * 3 - 50 - 5 * 2;
    [self.btnHeader setBackgroundImage:[MyFunction creatImageWithColor:PlaceholderColor] forState:UIControlStateNormal];
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

- (IBAction)btnHeaderClick:(UIButton *)sender {
    NSLog(@"点击头像");
    [SeeUserPageVC displayWithViewController:self.tvc userId:@"1"];
}
@end
