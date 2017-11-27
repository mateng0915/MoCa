//
//  HostedByMeCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "HostedByMeCell.h"
#import "HostedByMeTVC.h"
#import "ModelDiscover.h"
#import "Service.h"
#import "PostEventVC.h"

@implementation HostedByMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnCheck.layer.cornerRadius = 4.0;
    self.lblDes.preferredMaxLayoutWidth = M_Width - 15 - 8 * 2 - 120 - 1;
    UIImage *img_edit = [UIImage imageNamed:@"icon_edit"];
    CGFloat var = img_edit.size.width / img_edit.size.height;
    img_edit = [[MyFunction originImage:img_edit scaleToSize:CGSizeMake(20 * var, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.btnEdit setImage:img_edit forState:UIControlStateNormal];
    
}

#pragma mark - 设置内容样式
- (void)setModel:(ModelEvent *)model {
    if (!model)
        return;
    _model = model;
    [self.imgVThumb sd_setImageWithURL:[Service getImageCompleteURLWithString:model.img] placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
    self.lblTitle.text = model.title;
    self.lblDes.text = model.desrc;
    
    NSString *time = [model getTime];
    self.lblTime.text = time;
}

#pragma mark - 按钮事件
- (IBAction)btnEditClick:(UIButton *)sender {
    //    NSLog(@"Edit");
    PostEventVC *VC = [PostEventVC defaultEvent:self.model];
    [self.tvc.navigationController pushViewController:VC animated:YES];
}
- (IBAction)btnCheckClick:(UIButton *)sender {
    NSLog(@"Check");
}

@end
