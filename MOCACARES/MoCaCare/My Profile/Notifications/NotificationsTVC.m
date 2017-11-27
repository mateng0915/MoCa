//
//  NotificationsTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "NotificationsTVC.h"
#import "NotificationsCell.h"

@implementation NotificationsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"NotificationsCell" bundle:self.nibBundle] forCellReuseIdentifier:@"NotificationsCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
//    self.dataArr = @[@1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1];
}

#pragma mark - <TableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationsCell" forIndexPath:indexPath];
    cell.tvc = self;
    
    return cell;
}
#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 4.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 4.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
