//
//  SeeUserPageVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeeUserPageVC : UIViewController

/// 用户id
@property (nonatomic, copy) NSString *userId;

/*
 * 显示用户详情
 * @param VC :上一页
 * @param userId :用户id
 */
+ (void)displayWithViewController:(UIViewController *)VC
                           userId:(NSString *)userId;
@end
