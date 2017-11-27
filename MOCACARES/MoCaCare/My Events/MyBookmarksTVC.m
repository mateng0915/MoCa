//
//  MyBookmarksTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MyBookmarksTVC.h"
#import "MyBookmarksCell.h"
#import "ViewEventVC.h"
#import "ServiceMyEvents.h"
#import "MJRefresh.h"

@implementation MyBookmarksTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ModelUser accountColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyBookmarksCell" bundle:self.nibBundle] forCellReuseIdentifier:@"MyBookmarksCell"];
    // 表头
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, M_Width, 60)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @"MY BOOKMARKS";
    lbl.textColor = [MyFunction colorWithHexString:@"B0322F" alpha:1];
    lbl.textAlignment = NSTextAlignmentCenter;
    [lbl themeFontOfSize:30.0];
    self.tableView.tableHeaderView = lbl;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, M_Width, 22)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaer)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
}

#pragma mark - 数据请求
- (ModelPage *)page {
    if (!_page) {
        _page = [ModelPage firstPage];
    }
    return _page;
}
- (void)refreshHeaer { 
    self.page.page_current = 1;
    // 刷新数据
    [self requestData];
}
- (void)refreshFooter {
    self.page.page_current ++;
    [self requestData];
}
- (void)requestData {
    [ServiceMyEvents getMyEventsWithType:OperateEnevtTypeMark page:self.page success:^(NSArray<ModelMyEvent *> *list) {
        [self.tableView.mj_header endRefreshing];
        if (list.count == 0)
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        else
            [self.tableView.mj_footer endRefreshing];
        
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
        
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

#pragma mark - <TableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 根据日期可能分成多块
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyBookmarksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBookmarksCell" forIndexPath:indexPath];
    ModelMyEvent *model = self.events[indexPath.row];
    cell.model = model;
    cell.tvc = self;
    return cell;
}

#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0)
        return 60.0;
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
// 根据日期分类
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
        if (!header) {
            header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Header"];
            header.frame = CGRectMake(0, 0, M_Width, 60.0); 
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, M_Width - 30, 45.0)];
            lbl.tag = 10; 
            [lbl themeFontOfSize:20.0];
            [header addSubview:lbl];
        }
        UILabel *lblSectionTitle = [header viewWithTag:10];
        lblSectionTitle.text = @"Date";
        return header;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ModelMyEvent *model = self.events[indexPath.row];
    [ViewEventVC displayWithViewController:self
                                     event:model];
}
@end
