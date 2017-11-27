//
//  PostEventCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostEventTVC.h"

@interface PostEventCell : UITableViewCell
/// 控制器
@property (nonatomic, weak) PostEventTVC *tvc; 


/** 监听键盘 */
- (void)keyboardWillHide:(NSNotification *)notification;
@end
