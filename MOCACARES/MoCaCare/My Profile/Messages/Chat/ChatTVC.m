//
//  ChatTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ChatTVC.h"
#import "ChatLeftCell.h"
#import "ChatRightCell.h"
#import "ServiceMyProfile.h"
#import "MySocket.h"

@implementation ChatTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatLeftCell" bundle:self.nibBundle] forCellReuseIdentifier:@"ChatLeftCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatRightCell" bundle:self.nibBundle] forCellReuseIdentifier:@"ChatRightCell"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, M_Width, 15)];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketNewMsg:) name:SocketNewMsg object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - socket监听
- (void)socketNewMsg:(NSNotification *)noti {
    NSDictionary *dict = noti.object;
    NSString *fid = dict[@"fid"];
    if ([fid isEqualToString:self.chatUserId]) {
        [self requestData];
    }
}

#pragma mark - 刷新数据
- (void)requestData {
    [ServiceMyProfile getChatRecord:self.chatUserId success:^(NSArray<ModelChatMsg *> *list) {
        self.dataArr = [NSMutableArray array];
        ModelUser *user = [ModelUser defaultUser];
        [list enumerateObjectsUsingBlock:^(ModelChatMsg *obj1, NSUInteger idx1, BOOL *stop) {
            obj1.msgBelongSelf = [obj1.fid isEqualToString:user.id];
            __block BOOL check = NO;
            [self.dataArr enumerateObjectsUsingBlock:^(ModelChatMsg *obj2, NSUInteger idx2, BOOL *stop) {
                if ([obj1.id isEqualToString:obj2.id]) {
                    check = YES;
                    [self.dataArr setObject:obj1 atIndexedSubscript:idx2];
                    *stop = YES;
                }
            }];
            if (!check) {
                [self.dataArr insertObject:obj1 atIndex:0];
//                [self.dataArr addObject:obj1];
            }
        }];
        [self.tableView reloadData];
//        [self.tableView beginUpdates];
        if (self.dataArr.count > 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.dataArr.count-1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
//        [self.tableView endUpdates];
    } failure:^{
        
    }];
}

#pragma mark - <TableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModelChatMsg *model = self.dataArr[indexPath.section];
    if (model.msgBelongSelf) {
        ChatRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatRightCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    } else {
        ChatLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatLeftCell" forIndexPath:indexPath];
        cell.tvc = self;
        cell.model = model; 
        return cell;
    }
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
