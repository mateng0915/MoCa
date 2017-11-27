//
//  ViewEventTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ViewEventTVC.h"
#import "EventDetailCell.h"
#import "EventOperateCell.h"
#import "EventCommentCell.h"
#import "ServiceMyEvents.h"
#import "ServiceDiscover.h"
 
@implementation ViewEventTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
    
    [self requestEventDetail];
    [self requestCommentList];
}

#pragma mark - 数据请求
- (void)requestEventDetail {
    [ServiceDiscover getEventDetail:self.eventId success:^(ModelEventDetail *event) {
        self.model = event; 
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^{
        
    }];
}
- (void)requestCommentList {
    [ServiceDiscover getCommentListWithEventId:self.eventId success:^(NSArray<ModelComment *> *list) {
        self.commentList = [list copy];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^{
        
    }];
}

#pragma mark - <TableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 3;
    else if (section == 1)
        return 1;
    else
        return 1 + self.commentList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventCell *cell;
    if (indexPath.section == 0) {
        cell = [self detailCellForRowAtIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        cell = [self operateCellForRowAtIndexPath:indexPath];
    } else {
        cell = [self commentCellForRowAtIndexPath:indexPath];
    }
    cell.tvc = self;
    return cell;
}
- (EventDetailCell *)detailCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ider;
    if (indexPath.row == 0) {
        ider = @"ThumbTitleCell"; 
    } else if (indexPath.row == 1) {
        ider = @"TimeAddressCell";
    } else {
        ider = @"DesCell";
    }
    EventDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ider forIndexPath:indexPath];
    cell.model = self.model;
    return cell;
}
- (EventOperateCell *)operateCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventOperateCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"OperateCell" forIndexPath:indexPath];
    cell.model = self.model;
    return cell;
}
- (EventCommentCell *)commentCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventCommentCell *cell;
    if (indexPath.row == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"LeaveCommentCell" forIndexPath:indexPath];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentsCell" forIndexPath:indexPath];
        ModelComment *model = self.commentList[indexPath.row - 1];
        cell.model = model;
    }
    return cell;
}

#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2)
        return 22.0;
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
