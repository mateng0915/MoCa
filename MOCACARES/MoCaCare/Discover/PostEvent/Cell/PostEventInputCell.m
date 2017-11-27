//
//  PostEventInputCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventInputCell.h"

@implementation PostEventInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTvc:(PostEventTVC *)tvc {
    [super setTvc:tvc];
    self.textFieldEventName.text = self.tvc.event.title;
    self.textFiledLocation.text = self.tvc.event.add;
    self.textFiledDes.text = self.tvc.event.desrc;
}

#pragma mark - 键盘监听
- (void)keyboardWillHide:(NSNotification *)notification { 
    if (self.textFieldEventName &&
        M_CheckStrNil(self.textFieldEventName.text)) {
        self.tvc.event.title = self.textFieldEventName.text;
    }
    if (self.textFiledLocation &&
        M_CheckStrNil(self.textFiledLocation.text)) {
        self.tvc.event.add = self.textFiledLocation.text;
    }
    if (self.textFiledDes &&
        M_CheckStrNil(self.textFiledDes.text)) {
        self.tvc.event.desrc = self.textFiledDes.text;
    }
}
@end
