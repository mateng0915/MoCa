//
//  DiscoverSearchVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DiscoverVC;
@interface DiscoverSearchVC : UIViewController

/// 搜索容器
@property (nonatomic, strong) DiscoverVC *discoverVC;

/** 执行搜索操作 */
- (void)searchWorld:(NSString *)key;
@end
