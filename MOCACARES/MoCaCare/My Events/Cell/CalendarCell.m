//
//  CalendarCell.m
//  MoCaCare
//
//  Created by xhb on 2017/10/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "CalendarCell.h"
#import "ViewEventVC.h"
#import "ServiceMyEvents.h"

@implementation CalendarCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.grid) {
        self.backgroundColor = [UIColor whiteColor];
        /// 绘制网格视图
        /// 列（7天）
        NSInteger column = 7;
        /// 行（24小时,分上、下午）
        NSInteger row = 24 * 2;
        CGFloat w = self.bounds.size.width - GridMargin * 2;
        CGFloat w_cell = w / column;
        CGFloat h_cell = Cell_Height(w_cell);
        CGFloat h = h_cell * row;
        
        // 绘制网格背景
        self.grid = [[GridView alloc] initWithFrame:CGRectMake(GridMargin, 0, w, h)];
        [self.grid drawGridsWithColumn:column
                                   row:row];
        [self addSubview:self.grid];
    }
}

#pragma mark - 懒加载常量
- (NSDictionary *)shortWeek {
    if (!_shortWeek) {
        _shortWeek = @{@"Monday" : @"1",
                       @"Tuesday" : @"2",
                       @"Wednesday" : @"3",
                       @"Thursday" : @"4",
                       @"Friday" : @"5",
                       @"Saturday" : @"6",
                       @"Sunday" : @"0"};
    }
    return _shortWeek;
}
- (NSDictionary *)shortMonth {
    if (!_shortMonth) {
        _shortMonth = @{@"Jan" : @"1",
                        @"Feb" : @"2",
                        @"Mar" : @"3",
                        @"Apr" : @"4",
                        @"May" : @"5",
                        @"June" : @"6",
                        @"July" : @"7",
                        @"Aug" : @"8",
                        @"Sept" : @"9",
                        @"Oct" : @"10",
                        @"Nov" : @"11",
                        @"Dec" : @"12"};
    }
    return _shortMonth;
}
- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [NSDateFormatter new];
        [_formatter setDateFormat:@"yyyy/MM/dd"];
    }
    return _formatter;
}
#pragma mark - 设置内容
- (void)setEvents:(NSArray<ModelMyEvent *> *)events {
    if (!events)
        return;
    _events = events;
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    [self.grid.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [events enumerateObjectsUsingBlock:^(ModelMyEvent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mDic setObject:obj forKey:obj.aid];
        [self addEventInDay:obj];
    }];
//    NSLog(@"%@", self.week);
    self.eventsDict = [mDic copy];
}
// 把活动加入网格
- (void)addEventInDay:(ModelMyEvent *)event {
    if (event.time_type == TimeModelToBeAdvised) {
        return;
    } else {
        if (![self checkEventTime:event]) {
            return;
        }
        NSLog(@"%@\n", [event getTime]); 
        CGFloat hour_start = [self transHour:event.hour_start];
        CGFloat hour_end = [self transHour:event.hour_end];
        CGFloat column = [[self.shortWeek valueForKey:event.week] floatValue];
        [self.grid addEvent:event.title tag:event.aid.integerValue starColumn:column endColumn:column startHours:hour_start endHours:hour_end color:RandomColor target:self action:@selector(clickEvent:)];
    }
}
/// 转换小时字段
- (CGFloat)transHour:(NSString *)hour {
    NSArray<NSString *> *arr = [hour componentsSeparatedByString:@":"];
    CGFloat h = [arr.firstObject floatValue];
    
    NSArray<NSString *> *arr2 = [arr.lastObject componentsSeparatedByString:@" "];
    CGFloat m = [arr2.firstObject integerValue] / 60.0;
    h += m;
    NSRange range = [hour rangeOfString:@"AM"];
    if (range.length != 0) {
        return h;
    } else {
        return h + 12;
    }
}
/// 检测是否超过时间
- (BOOL)checkEventTime:(ModelMyEvent *)event {
    NSArray<NSString *> *arr = [event.begin_time componentsSeparatedByString:@","];
    NSArray<NSString *> *arr2 = [arr.lastObject componentsSeparatedByString:@" "];
    
    int event_day = [arr2.firstObject intValue];
    int event_month =[self.shortMonth[arr2.lastObject] intValue];
    
    NSString *week_firstDay = self.week.firstObject;
    arr = [[week_firstDay substringToIndex:10] componentsSeparatedByString:@"/"];
    int first_month = [arr[1] intValue];
    int first_day = [arr[2] intValue];
    
    NSString *week_lastDay = self.week.lastObject;
    arr = [[week_lastDay substringToIndex:10] componentsSeparatedByString:@"/"];
    int last_month = [arr[1] intValue];
    int last_day = [arr[2] intValue];
    
    BOOL flag = NO;
    if (event.time_type == TimeModelOneOff) {
        if (event_month >= first_month &&
            event_month <= last_month &&
            event_day >= first_day &&
            event_day <= last_day) {
            NSLog(@"活动【%@】满足条件,在%d月%d提示", event.title, event_month, event_day);
            flag = YES;
        }
        
    } else if (event.time_type == TimeModelRecurring) {
        if (event_month > first_month) {
            NSLog(@"活动【%@】满足条件,在%d月前提示", event.title, event_month);
            flag = YES;
        } else if (event_month == first_month &&
                   event_day >= first_day) {
            NSLog(@"活动【%@】满足条件,在%d月%d前提示", event.title, event_month, event_day);
            flag = YES;
        }
        
    }
    if (flag) {
        NSLog(@"%d/%d\t%d/%d\t%d/%d", first_month, first_day, event_month, event_day, last_month, last_day);
    }
    return flag;
}

#pragma mark - 进入活动详情
- (void)clickEvent:(UIButton *)sender {
    ModelMyEvent *model = self.eventsDict[[@(sender.tag) description]];
//    NSLog(@"clickEvent");
    // 用tag代替eventid
    [ViewEventVC displayWithViewController:self.cvc
                                     event:model];
}
@end
