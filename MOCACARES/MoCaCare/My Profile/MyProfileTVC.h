//
//  MyProfileTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DXBadgeButton;
@interface MyProfileTVC : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,
    UIAlertViewDelegate>
/// 头像
@property (weak, nonatomic) IBOutlet UIImageView *imgVPortrait;
/// 名称
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/// 身份
@property (weak, nonatomic) IBOutlet UILabel *lblIdentity;
/// 个人描述
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
/// 下方分割线
@property (weak, nonatomic) IBOutlet UIView *viewLine;
/// 标注——消息
@property (weak, nonatomic) IBOutlet DXBadgeButton *badgeNotifications;
/// 标注——信息
@property (weak, nonatomic) IBOutlet DXBadgeButton *badgeMessages;

/** 数据请求 */
- (void)requestData;
@end
