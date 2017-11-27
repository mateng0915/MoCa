//
//  ModelDiscover.m
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ModelDiscover.h"

@implementation ModelDiscover

@end

#pragma mark - 活动类别
@implementation ModelEventCategory

@end

#pragma mark - 活动
@implementation ModelEvent
- (void)setTime_type:(TimeModel)time_type {
    NSInteger value = [@(time_type) integerValue];
    if (value == 1) {
        _time_type = TimeModelOneOff;
    } else if (value == 2) {
        _time_type = TimeModelRecurring;
    } else if (value == 3) {
        _time_type = TimeModelToBeAdvised;
    } else {
        NSLog(@"时间模式错误");
        _time_type = TimeModelToBeAdvised;
    }
}

- (NSString *)getTime {
    NSString *str;
    if (self.time_type == TimeModelOneOff) {
        str = [NSString stringWithFormat:@"%@ %@-%@", self.begin_time, self.hour_start, self.hour_end];
    } else if (self.time_type == TimeModelRecurring) {
        str = [NSString stringWithFormat:@"Every %@ %@-%@ Until %@", self.week, self.hour_start, self.hour_end, self.begin_time];
    } else {
        str = @"To be advised";
    }
    return str;
}
@end

#pragma mark - 活动详情
@implementation ModelEventDetail

@end

#pragma mark - 评论
@implementation ModelComment

@end
