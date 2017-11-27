//
//  PostEventTimeCell.m
//  MoCaCare
//
//  Created by xhb on 2017/10/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventTimeCell.h"
#import "DataPickerVC.h"
#import "TimePickerVC.h"

@interface PostEventTimeCell()
/// 数据选择器
@property (nonatomic, strong) DataPickerVC *dataPicker;
/// 时间选择器
@property (nonatomic, strong) TimePickerVC *timePicker;
/// 月份数组
@property (nonatomic, copy) NSArray<NSString *> *months;
/// 星期数组
@property (nonatomic, copy) NSArray<NSString *> *weeks;
/// 时间格式
@property (nonatomic, strong) NSDateFormatter *formatter;
@end
@implementation PostEventTimeCell

#pragma mark - 懒加载
- (DataPickerVC *)dataPicker {
    if (!_dataPicker) {
        _dataPicker = [[DataPickerVC alloc] initWithNibName:@"DataPickerVC" bundle:nil];
    }
    return _dataPicker;
}
- (TimePickerVC *)timePicker {
    if (!_timePicker) {
        _timePicker = [[TimePickerVC alloc] initWithNibName:@"TimePickerVC" bundle:nil];
    }
    return _timePicker;
}
- (NSArray<NSString *> *)months {
    if (!_months) {
        _months = @[@"Jan", @"Feb", @"Mar",
                    @"Apr", @"May", @"June",
                    @"July", @"Aug", @"Sept",
                    @"Oct", @"Nov", @"Dec"];
    }
    return _months;
}
- (NSArray<NSString *> *)weeks {
    if (!_weeks) {
        _weeks = @[@"Monday", @"Tuesday", @"Wednesday",
                   @"Thursday", @"Friday", @"Saturday",
                   @"Sunday"];
    }
    return _weeks;
}
- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [NSDateFormatter new];
        [_formatter setDateFormat:@"yyyy/MM/dd"];
    }
    return _formatter;
}
- (void)awakeFromNib {
    [super awakeFromNib]; 
    self.viewTime.layer.borderWidth = 1.0;
    self.viewTime.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewTime.layer.cornerRadius = 4.0;
    
    self.btnDayStart.layer.cornerRadius = 4.0;
    self.btnDayEnd.layer.cornerRadius = 4.0;
    self.btnDay.layer.cornerRadius = 4.0;
    self.btnHourStart.layer.cornerRadius = 4.0;
    self.btnHourEnd.layer.cornerRadius = 4.0;
    self.btnWeek.layer.cornerRadius = 4.0;
    
    [self setTitle:@"choose date" btn:self.btnDayStart];
    [self setTitle:@"choose date" btn:self.btnDayEnd];
    [self setTitle:@"choose date" btn:self.btnDay];
    [self setTitle:@"00:00" btn:self.btnHourStart];
    [self setTitle:@"00:00" btn:self.btnHourEnd];
    [self setTitle:@"Sunday" btn:self.btnWeek];
}

- (void)setTvc:(PostEventTVC *)tvc {
    [super setTvc:tvc];
    switch (self.tvc.timeModel) {
        case TimeModelOneOff:
            self.lblTimeModel.text = @"One-Off";
            break;
        case TimeModelRecurring:
            self.lblTimeModel.text = @"Recurring";
            break;
        case TimeModelToBeAdvised:
            self.lblTimeModel.text = @"To be advised";
            break;
        default:
            break;
    }
    [self setTitle:self.tvc.event.begin_time btn:self.btnDayStart];
    [self setTitle:self.tvc.event.begin_time btn:self.btnDayEnd];
    [self setTitle:self.tvc.event.begin_time btn:self.btnDay];
    [self setTitle:self.tvc.event.hour_start btn:self.btnHourStart];
    [self setTitle:self.tvc.event.hour_end btn:self.btnHourEnd];
    [self setTitle:self.tvc.event.week btn:self.btnWeek];
}


#pragma mark - 按钮事件
- (IBAction)btnTimeModelClick:(UIButton *)sender {
    [self.tvc.tableView endEditing:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *a = [UIAlertAction actionWithTitle:@"One-Off" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lblTimeModel.text = action.title;
        self.tvc.timeModel = TimeModelOneOff;
        [self.tvc.tableView reloadData];
    }];
    [alert addAction:a];
    UIAlertAction *b = [UIAlertAction actionWithTitle:@"Recurring" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lblTimeModel.text = action.title;
        self.tvc.timeModel = TimeModelRecurring;
        [self.tvc.tableView reloadData];
    }];
    [alert addAction:b];
    UIAlertAction *c = [UIAlertAction actionWithTitle:@"To be advised" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lblTimeModel.text = action.title;
        self.tvc.timeModel = TimeModelToBeAdvised;
        [self.tvc.tableView reloadData];
    }];
    [alert addAction:c];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self.tvc presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 按钮事件 OneOff
/** 设置开始日期 */
- (IBAction)btnDayStartClick:(UIButton *)sender {
    [self.tvc.tableView endEditing:YES];
//    self.tvc.event.start_time = timeStr;
//    self.tvc.event.end_time = timeStr;
    [self.timePicker displayWithViewController:self.tvc title:@"End Time" type:PickerTypeDate cmopleted:^(NSString *timeStr) {
        NSString *str = [self transDate:timeStr];
        [self setTitle:str btn:sender];
        [self setTitle:str btn:self.btnDayEnd];
        self.tvc.event.begin_time = str;
        NSLog(@"%@ - %@", timeStr, str);
    }];
}
/** 设置结束日期 */
- (IBAction)btnDayEndClick:(UIButton *)sender {
    [self.tvc.tableView endEditing:YES];
    [self.timePicker displayWithViewController:self.tvc title:@"End Time" type:PickerTypeDate cmopleted:^(NSString *timeStr) {
        NSString *str = [self transDate:timeStr];
        [self setTitle:str btn:sender];
        [self setTitle:str btn:self.btnDayStart];
        self.tvc.event.begin_time = str;
        NSLog(@"%@ - %@", timeStr, str);
    }];
}
/** 设置开始小时 */
- (IBAction)btnHourStartClick:(UIButton *)sender {
    [self.tvc.tableView endEditing:YES];
    [self.timePicker displayWithViewController:self.tvc title:@"End Time" type:PickerTypeTime cmopleted:^(NSString *timeStr) {
        NSString *str = [self transHour:timeStr];
        [self setTitle:str btn:sender];
        self.tvc.event.hour_start = str;
        NSLog(@"%@ - %@", timeStr, str);
    }];
}
/** 设置结束小时 */
- (IBAction)btnHourEndClick:(UIButton *)sender {
    [self.tvc.tableView endEditing:YES];
    [self.timePicker displayWithViewController:self.tvc title:@"End Time" type:PickerTypeTime cmopleted:^(NSString *timeStr) {
        NSString *str = [self transHour:timeStr];
        [self setTitle:str btn:sender];
        self.tvc.event.hour_end = str;
        NSLog(@"%@ - %@", timeStr, str);
    }];
}

#pragma makr - 按钮事件 Recurring
/** 设置周几 */
- (IBAction)btnWeekClick:(UIButton *)sender {
    [self.tvc.tableView endEditing:YES];
    [self.dataPicker displayWithViewController:self.tvc title:@"Weeks" dataArr:self.weeks completed:^(NSInteger idx, NSString *dataStr) {
        [self setTitle:dataStr btn:sender];
        self.tvc.event.week = dataStr;
        NSLog(@"%@", dataStr);
    }];
}
/** 设置开始日期 */
- (IBAction)btnDayClick:(UIButton *)sender {
    [self.tvc.tableView endEditing:YES];
    [self.timePicker displayWithViewController:self.tvc title:@"End Time" type:PickerTypeDate cmopleted:^(NSString *timeStr) {
        NSString *str = [self transDate:timeStr];
        [self setTitle:str btn:sender];
        self.tvc.event.begin_time = str;
        NSLog(@"%@ - %@", timeStr, str);
    }];
}
/// 转换日期字符串
- (NSString *)transDate:(NSString *)dateStr {
    NSString *week = [self getWeek:[self.formatter dateFromString:dateStr]];
    self.tvc.event.week = week;
    NSArray *dayArr = [dateStr componentsSeparatedByString:@"/"];
    int mon = [dayArr[1] intValue];
    int day = [dayArr[2] intValue];
    NSString *monStr = self.months[mon-1];
    NSString *str = [NSString stringWithFormat:@"%@,%d %@", week, day, monStr];
    return str;
}
// 获取指定日期是周几
- (NSString *)getWeek:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    int week = (int)components.weekday;
//    NSLog(@"week = %d", week);
    if (week < 0 || week >= 7) {
        return nil;
    }
    NSString *str = self.weeks[week];
    return str;
}
/// 转换小时字符串
- (NSString *)transHour:(NSString *)hour {
    NSString *str;
    NSArray *arr = [hour componentsSeparatedByString:@":"];
    int h = [arr.firstObject intValue]; 
    NSString *m = arr.lastObject;
    if (h >= 12) {
        str = [NSString stringWithFormat:@"%d:%@ PM", h-12, m];
    } else {
        str = [NSString stringWithFormat:@"%d:%@ AM", h, m];
    }
    return str;
}
/// 设置按钮标题（左右空白填充）
- (void)setTitle:(NSString *)title btn:(UIButton *)btn {
    if (!title || !btn) {
        return;
    }
    [btn setTitle:[NSString stringWithFormat:@"   %@   ", title] forState:UIControlStateNormal];
}
@end
