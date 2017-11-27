//
//  MyBookmarksCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyBookmarksTVC, ModelMyEvent;
@interface MyBookmarksCell : UITableViewCell
/// 封面
@property (weak, nonatomic) IBOutlet UIImageView *imgVThumb;
/// 活动标题
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/// 活动简述
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
/// 活动时间
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
/// 预定按钮
@property (weak, nonatomic) IBOutlet UIButton *btnBookmarked;

/// 承载控制器
@property (nonatomic, strong) MyBookmarksTVC *tvc;
/// 事件数据模型
@property (nonatomic, weak) ModelMyEvent *model;

/** 预定、取消该活动 */
- (IBAction)btnBookmarkedClick:(UIButton *)sender; 
@end
