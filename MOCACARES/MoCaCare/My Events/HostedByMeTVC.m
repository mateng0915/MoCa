//
//  HostedByMeTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "HostedByMeTVC.h"
#import "HostedByMeCell.h"
#import "ViewEventVC.h"
#import "ServiceMyEvents.h"
#import "MJRefresh.h"

@implementation HostedByMeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ModelUser accountColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
    [self.tableView registerNib:[UINib nibWithNibName:@"HostedByMeCell" bundle:self.nibBundle] forCellReuseIdentifier:@"HostedByMeCell"];
    // 表头
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, M_Width, 60)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @"HOSTED BY ME";
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
    [ServiceMyEvents getMyPostEvents:self.page success:^(NSArray<ModelEvent *> *list) {
        [self.tableView.mj_header endRefreshing];
        if (list.count == 0)
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        else
            [self.tableView.mj_footer endRefreshing];
        
        if (!self.events)
            self.events = [NSMutableArray array];
        [list enumerateObjectsUsingBlock:^(ModelEvent *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            __block BOOL check = NO;
            [self.events enumerateObjectsUsingBlock:^(ModelEvent *obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                if ([obj1.id isEqualToString:obj2.id]) {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HostedByMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostedByMeCell" forIndexPath:indexPath];
    ModelEvent *model = self.events[indexPath.row];
    cell.model = model;
    cell.tvc = self;
    return cell;
}

#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    /// 活动时间
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ModelEvent *model = self.events[indexPath.row];
    [ViewEventVC displayWithViewController:self
                                     event:model];
}

@end
