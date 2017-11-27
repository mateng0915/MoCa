//
//  PostEventVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelEvent;
@interface PostEventVC : UIViewController

/** 实例化变量
 * @param event :活动数据模型
 */
+ (instancetype)defaultEvent:(ModelEvent *)event;
@end
