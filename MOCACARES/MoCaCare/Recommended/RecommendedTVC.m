//
//  RecommendedTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "RecommendedTVC.h"
#import "RecommendedCell.h"
#import "ViewEventVC.h"
#import "ServiceRecommended.h"
#import "ServiceDiscover.h"
#import "MJRefresh.h"

@implementation RecommendedTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendedCell" bundle:self.nibBundle] forCellReuseIdentifier:@"RecommendedCell"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, M_Width, 22)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaer)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    [self requestData];
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
    [ServiceRecommended getRecommendedList:self.categorys page:self.page success:^(NSArray<ModelEvent *> *list) {
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
    RecommendedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendedCell" forIndexPath:indexPath];
    ModelEvent *model = self.events[indexPath.row];
    cell.event = model;
    return cell;
}

#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ModelEvent *model = self.events[indexPath.row];
    [ViewEventVC displayWithViewController:self
                                     event:model];
}

@end
