//
//  MyBookmarksCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MyBookmarksCell.h"
#import "MyBookmarksTVC.h"
#import "ServiceMyEvents.h"

@implementation MyBookmarksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnBookmarked.layer.cornerRadius = 4.0;
    self.lblDes.preferredMaxLayoutWidth = M_Width - 15 - 8 * 2 - 120 - 1;
    self.btnBookmarked.backgroundColor = MarkYColor;
}

#pragma mark - 设置内容样式
- (void)setModel:(ModelMyEvent *)model {
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
- (IBAction)btnBookmarkedClick:(UIButton *)sender {
//    NSLog(@"Bookmarked");
    sender.userInteractionEnabled = NO;
    [ServiceMyEvents setEventWithId:self.model.id type:OperateEnevtTypeMark success:^(BOOL statue) {
        sender.userInteractionEnabled = YES;
        self.tvc.events = [NSMutableArray array];
        [self.tvc.tableView reloadData];
        [self.tvc requestData];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}
 
@end
