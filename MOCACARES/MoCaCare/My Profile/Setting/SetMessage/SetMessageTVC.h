//
//  SetMessageTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/25.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "SettingTVC.h"

@interface SetMessageTVC : SettingTVC

@property (weak, nonatomic) IBOutlet UILabel *lblRow0;

@property (weak, nonatomic) IBOutlet UIImageView *imgVRow0; 

@property (nonatomic, assign) NSInteger idx;

/// 图片数组
@property (nonatomic, copy) NSArray<UIImageView *> *imgVs; 
@end
