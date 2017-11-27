//
//  SetRecommendsTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/25.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "SettingTVC.h"

@interface SetRecommendsTVC : SettingTVC

@property (weak, nonatomic) IBOutlet UILabel *lblRow0;
@property (weak, nonatomic) IBOutlet UILabel *lblRow1;
@property (weak, nonatomic) IBOutlet UILabel *lblRow2;
@property (weak, nonatomic) IBOutlet UILabel *lblRow3;

@property (weak, nonatomic) IBOutlet UIImageView *imgVRow0;
@property (weak, nonatomic) IBOutlet UIImageView *imgVRow1;
@property (weak, nonatomic) IBOutlet UIImageView *imgVRow2;
@property (weak, nonatomic) IBOutlet UIImageView *imgVRow3;

@property (nonatomic, assign) NSInteger idx;
/// 图片数组
@property (nonatomic, copy) NSArray<UIImageView *> *imgVs;
@end
