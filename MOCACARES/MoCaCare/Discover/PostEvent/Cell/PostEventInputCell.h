//
//  PostEventInputCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventCell.h"

@interface PostEventInputCell : PostEventCell

#pragma mark - 活动名
/// 活动名
@property (weak, nonatomic) IBOutlet UITextField *textFieldEventName;

#pragma mark - 活动地址
/// 活动地址
@property (weak, nonatomic) IBOutlet UITextField *textFiledLocation;

#pragma mark - 活动描述
/// 活动描述
@property (weak, nonatomic) IBOutlet UITextField *textFiledDes;


@end
