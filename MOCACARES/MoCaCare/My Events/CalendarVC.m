//
//  CalendarVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "CalendarVC.h"
#import "CalendarCVC.h"
#import "ViewEventVC.h"

@interface CalendarVC()
@property (nonatomic, strong) CalendarCVC *cvc;
@end
@implementation CalendarVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [ModelUser accountColor];
    self.scorllVew = [[UIScrollView alloc] init];
    self.scorllVew.backgroundColor = [UIColor clearColor];
    self.scorllVew.delegate = self;
    self.scorllVew.showsVerticalScrollIndicator = NO;
    self.scorllVew.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scorllVew];
    
    // 表头
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, M_Width, 60)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @"MY CALENDAR";
    lbl.textColor = [MyFunction colorWithHexString:@"B0322F" alpha:1];
    lbl.textAlignment = NSTextAlignmentCenter;
    [lbl themeFontOfSize:30.0];
    [self.scorllVew addSubview:lbl]; 
    self.cvc = [[CalendarCVC alloc] initWithNibName:@"CalendarCVC" bundle:self.nibBundle];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!self.cvc.parentViewController) {
        self.scorllVew.frame = self.view.bounds;
        [self addChildViewController:self.cvc];
        [self addColumnHeader];
        [self addRowHeader];
        [self addGrid];
    }
}

#pragma mark - 数据请求
- (void)requestData {
    [self.cvc requestData];
}

#pragma mark - 添加上方表头
- (void)addColumnHeader {
    /// 绘制网格视图
    NSInteger column = 8;
    CGFloat w = M_Width - GridMargin * 2;
    CGFloat w_cell = w / column;
    CGFloat h_cell = Cell_Height(w_cell);
    
    /// 设置置顶行
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 60, M_Width, 40)];
    header.backgroundColor = [UIColor whiteColor];
    
    CGFloat h_header = header.bounds.size.height;
    //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSArray *arr = @[@"Sun", @"Mon", @"Thes", @"Wed", @"Thur", @"Fri", @"Sat"];
    NSMutableArray<UILabel *> *lbls = [NSMutableArray array];
    for (int i = 0; i < column; i ++) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(i * w_cell + GridMargin, 0, w_cell, i == 0 ? h_header : h_header / 2.0)];
        lbl.text = @"GMT+08";
        [lbl themeFontOfSize:8.0];
        lbl.numberOfLines = 2;
        lbl.textAlignment = NSTextAlignmentCenter;
        [header addSubview:lbl];
        if (i != 0) {
            lbl.text = arr[i - 1];
            [lbls addCheckObject:lbl];
        }
    }
    self.timeLbls = [lbls mutableCopy];
    GridView *gridHeader = [[GridView alloc] initWithFrame:CGRectMake(w_cell + GridMargin, h_header / 2.0, w_cell * (column - 1), h_header / 2.0 - GridMargin)];
    [gridHeader drawGridsWithColumn:column - 1
                                row:1
                          rowHeight:h_cell];
    [header addSubview:gridHeader];
    [self.view addSubview:header];
    self.columnHeader = header;
}

#pragma mark - 添加左方表头
- (void)addRowHeader {
    /// 绘制网格视图
    NSInteger column = 8;
    NSInteger row = 24;
    CGFloat w = M_Width - GridMargin * 2;
    CGFloat w_cell = w / column;
    CGFloat h_cell = Cell_Height(w_cell);
    
    /// 添加左侧时间标签头
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 60, w_cell, h_cell * row * 2 + self.columnHeader.bounds.size.height)];
    header.backgroundColor = [UIColor clearColor];
    self.rowHeader = [[UIView alloc] initWithFrame:CGRectMake(0, self.columnHeader.bounds.size.height, w_cell, h_cell * row * 2)];
    self.rowHeader.backgroundColor = [UIColor whiteColor];
    [header addSubview:self.rowHeader];
    
    self.scorllVew.contentSize = CGSizeMake(0, header.frame.origin.y + header.bounds.size.height);
    
    CGRect frame = CGRectMake(GridMargin, 0, w_cell - GridMargin, h_cell * 2 + 1);
    for (int i = 0; i < row; i ++ ) {
        frame.origin.y = i * h_cell * 2;
        if (i == row - 1)
            frame.size.height -= 1;
        UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
        lbl.numberOfLines = 2;
        [lbl themeFontOfSize:10.0];
        lbl.layer.borderWidth = LineWidth;
        lbl.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = [NSString stringWithFormat:@"%@ %d", i < 12 ? @"AM" : @"PM", i % 12 + 1];
        [self.rowHeader addSubview:lbl];
    }
    header.clipsToBounds = YES;
    [self.view addSubview:header];
    [self.view bringSubviewToFront:self.columnHeader];
}

#pragma mark - 添加表格主体
- (void)addGrid {
    CGFloat w = (M_Width - 2 * GridMargin) / 8.0;
    self.cvc.collectionView.frame = CGRectMake(w, 60 + self.columnHeader.bounds.size.height, M_Width - w, self.rowHeader.bounds.size.height);
    [self.scorllVew addSubview:self.cvc.collectionView];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat ofy = scrollView.contentOffset.y;
    
    CGRect frame = CGRectZero;
//    NSLog(@"%.f", ofy);
    frame = self.rowHeader.frame;
    frame.origin.y = self.columnHeader.bounds.size.height - ofy;
    self.rowHeader.frame = frame;
    if (ofy > 60)
        ofy = 60;
    
    frame = self.rowHeader.superview.frame;
    frame.origin.y = 60 - ofy;
    self.rowHeader.superview.frame = frame;
    
    frame = self.columnHeader.frame;
    frame.origin.y = 60 - ofy;
    self.columnHeader.frame = frame;
    
    CGPoint ofs = self.cvc.collectionView.contentOffset;
    ofs.y = ofy;
    self.cvc.collectionView.contentOffset = ofs;
}

#pragma mark - 修改顶部日期
- (void)setDays:(NSArray<NSString *> *)days {
    [self.timeLbls enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (days.count > idx) {
            obj.text = days[idx];
        }
    }];
}
@end
