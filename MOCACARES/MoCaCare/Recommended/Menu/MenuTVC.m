//
//  MenuTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MenuTVC.h"
#import "ModelDiscover.h"

@implementation MenuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = ThemeColorRed;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    /// 设置表头
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MenuWidth, 64 + 30)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, MenuWidth, 64 + 10)];
    lbl.text = @"FILTER";
    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    [lbl themeFontOfSize:30.0];
    [headerView addSubview:lbl];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - <TableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categorys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell.tag != 666) {
        cell.tag = 666; 
        [cell.textLabel themeFontOfSize:15.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    ModelEventCategory *model = self.categorys[indexPath.row];
    if ([self selectedThisCategory:model]) {
        cell.contentView.backgroundColor = ThemeColorDarkRed;
    } else {
        cell.contentView.backgroundColor = ThemeColorRed;
    }
    cell.textLabel.text = model.name;
    return cell;
}

#pragma mark - <TableViewDataSource>
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ModelEventCategory *model = self.categorys[indexPath.row];
    if ([self selectedThisCategory:model]) {
        [self.selectedCategorys removeObject:model];
    } else { 
        [self.selectedCategorys addObject:model];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (self.blockMenu)
        self.blockMenu(self.selectedCategorys);
}
#pragma mark - 是否选中改类型标签
- (BOOL)selectedThisCategory:(ModelEventCategory *)category {
    for (ModelEventCategory *model in self.selectedCategorys) {
        if ([model.id isEqualToString:category.id])
            return YES;
    }
    return NO;
}

@end
