//
//  CalendarVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridView.h"

@interface CalendarVC : UIViewController <UIScrollViewDelegate>

/// 主体
@property (nonatomic, strong) UIScrollView *scorllVew;
/// 网格
@property (nonatomic, strong) GridView *grid;
/// 网格头上方
@property (nonatomic, strong) UIView *columnHeader;
/// 网格头左侧
@property (nonatomic, strong) UIView *rowHeader;
/// 顶部活动时间标签
@property (nonatomic, strong) NSMutableArray<UILabel *> *timeLbls;

/** 设置顶部的日期 */
- (void)setDays:(NSArray<NSString *> *)days;
/** 数据请求 */
- (void)requestData;
@end
