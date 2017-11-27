//
//  SettingTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/25.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTVC : UITableViewController
          
@property (weak, nonatomic) IBOutlet UILabel *lblRecommends;
@property (weak, nonatomic) IBOutlet UILabel *lblNotification;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblLogout;

/// 表头
@property (nonatomic, strong) UILabel *header;
/** 设置标签圆角和边框 */
- (void)setLableStyle:(UILabel *)lbl;
@end
