//
//  EventCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewEventTVC.h"

@interface EventCell : UITableViewCell
/// 承载容器
@property (nonatomic, strong) ViewEventTVC *tvc;
@end
