//
//  ChatRightCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ChatRightCell.h"
#import "ModelMyProfile.h"

@implementation ChatRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewMsg.layer.cornerRadius = 4.0;
    self.lblMsg.preferredMaxLayoutWidth = M_Width - 8 * 2 - 5 * 2 - 60; // 多-1防止误差
}

#pragma mark - 设置内容
- (void)setModel:(ModelChatMsg *)model {
    if (!model)
        return;
    _model = model;
    self.lblMsg.text = model.msg; 
}
 

@end
