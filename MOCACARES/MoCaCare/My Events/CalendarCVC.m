//
//  CalendarCVC.m
//  MoCaCare
//
//  Created by xhb on 2017/10/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "CalendarCVC.h" 
#import "CalendarVC.h"
#import "CalendarCell.h"
#import "CalendarVC.h"
#import "ServiceMyEvents.h"
#import "MJRefresh.h"

@interface CalendarCVC()
/// 父控制器
@property (nonatomic, weak) CalendarVC *parentVC;
@end
@implementation CalendarCVC
 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"CalendarCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;

    // 父控制器
    if ([self.parentViewController isKindOfClass:[CalendarVC class]]) {
        self.parentVC = (CalendarVC *)self.parentViewController;
    }
    // 设置日期
    NSDate *today = [NSDate date];
    self.weeks = [NSMutableArray array];
    // 前后2周
    for (int i = 0; i < 5; i ++) {
        [self.weeks addObject:[self getNextWeekWithDate:today next:i]];
    }
//    NSLog(@"%@", self.weeks); 
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view layoutIfNeeded];
    CGFloat w = self.view.bounds.size.width / 8.0;
    self.collectionView.frame = CGRectMake(M_Width, 0, self.view.bounds.size.width - w, self.view.bounds.size.height);
}

#pragma mark - 数据请求
- (ModelPage *)page {
    if (!_page) {
        _page = [ModelPage firstPage];
    }
    return _page;
}
- (void)requestData {
    [ServiceMyEvents getMyEventsWithType:OperateEnevtTypeJoin page:self.page success:^(NSArray<ModelMyEvent *> *list) {
        [self.collectionView.mj_header endRefreshing];
        if (list.count == 0)
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        else
            [self.collectionView.mj_footer endRefreshing];
        
        if (!self.events)
            self.events = [NSMutableArray array];
        [list enumerateObjectsUsingBlock:^(ModelMyEvent *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            __block BOOL check = NO;
            [self.events enumerateObjectsUsingBlock:^(ModelMyEvent *obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                if ([obj1.aid isEqualToString:obj2.aid]) {
                    check = YES;
                    [self.events setObject:obj1 atIndexedSubscript:idx2];
                    *stop2 = YES;
                }
            }];
            if (!check)
                [self.events addObject:obj1];
        }];
        
        [self.collectionView reloadData];
    } failure:^{
        
    }];
}

#pragma mark - 日历操作
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy/MM/dd"];
    }
    return _dateFormatter;
}
- (NSArray<NSString *> *)getCurrentWeekWithDate:(NSDate *)date {
    NSInteger firstday = [self firstDaysInThisMonth:date];
    NSString *dayStr = [self.dateFormatter stringFromDate:date];
    NSArray *dayArr = [dayStr componentsSeparatedByString:@"/"];
    int day = [dayArr[2] intValue];
    int week = (day + firstday) % 7 - 1;
    
    NSMutableArray<NSString *> *days = [NSMutableArray array];
    NSArray *arr = @[@"Sun", @"Mon", @"Thes", @"Wed", @"Thur", @"Fri", @"Sat"];
//    arr = @[@"7", @"1", @"2", @"3", @"4", @"5", @"6"];
    
    for (int i = -week; i < 7 - week; i ++) {
        NSDate *newDate = [NSDate dateWithTimeInterval:i * 60 * 60 * 24 sinceDate:date];
        NSString *str = [self.dateFormatter stringFromDate:newDate];
        str = [NSString stringWithFormat:@"%@\n(%@)", str, arr[week + i]];
        [days addObject:str];
    }
//    NSLog(@"%@", days);
    return days;
}
/** 获取前后几周的的信息
 * @param date :指定开始日期
 * @param next :指定具体是前后几周 （>0为后， <0为前）
 */
- (NSArray<NSString *> *)getNextWeekWithDate:(NSDate *)date next:(NSInteger)next {
    /// 利用时间戳
    NSDate *nextDate = [NSDate dateWithTimeInterval:next * 7 * 60 * 60 * 24 sinceDate:date];
    return [self getCurrentWeekWithDate:nextDate];
}
// 计算指定月数的总天数
- (NSInteger)totalDaysInThisMonth:(NSDate *)date {
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}
// 第一天是周几
- (NSInteger)firstDaysInThisMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.weeks.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
    
    NSArray<NSString *> *week = self.weeks[indexPath.section];
    cell.cvc = self;
    cell.week = week;
    cell.events = self.events;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self scrollViewDidEndDecelerating:collectionView];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.bounds.size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [self.collectionView indexPathsForVisibleItems].firstObject;
    NSArray<NSString *> *week = self.weeks[indexPath.section];
    [self.parentVC.timeLbls enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (week.count > idx) {
            NSString *str = [week[idx] substringFromIndex:5];
            obj.text = str;
        }
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIViewController *VC = self.parentViewController;
    if ([self.parentViewController isKindOfClass:[CalendarVC class]]) {
        if ([VC respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [VC performSelectorOnMainThread:@selector(scrollViewDidScroll:) withObject:self.collectionView.superview waitUntilDone:NO];
        }
    }
}
 
@end
