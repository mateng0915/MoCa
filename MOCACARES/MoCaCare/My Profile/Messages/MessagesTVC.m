//
//  MessagesTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MessagesTVC.h"
#import "MessagesCell.h" 
#import "ChatVC.h"
#import "ServiceMyProfile.h"

@implementation MessagesTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessagesCell" bundle:self.nibBundle] forCellReuseIdentifier:@"MessagesCell"];
    self.tableView.rowHeight = 60.0;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, M_Width, 22)];
    
    [self requestData];
}

#pragma mark - 数据请求 
- (void)requestData {
    [ServiceMyProfile getMessages:^(NSArray<ModelChatMsg *> *list) {
        self.msgs = [list copy];
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

#pragma mark - <TableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessagesCell" forIndexPath:indexPath];
    ModelChatMsg *model = self.msgs[indexPath.row];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ModelChatMsg *model = self.msgs[indexPath.row];
    [ChatVC displayWithViewController:self
                           chatUserId:model.uid
                             chatName:model.name];
}
@end
