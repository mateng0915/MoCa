//
//  DiscoverSearchTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "DiscoverSearchTVC.h"
#import "DiscoverSearchVC.h"

@interface DiscoverSearchTVC () <UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>
@end

@implementation DiscoverSearchTVC

- (void)viewDidLoad {
    [super viewDidLoad]; 
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.searchRecord = [self searchRecord];
    // 初始化搜索栏目
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    // 搜索时，背景变暗色
    self.searchController.dimsBackgroundDuringPresentation = NO;
    // 点击搜索的时候,是否隐藏导航栏
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    // 搜索框样式
    UISearchBar *searchBar = self.searchController.searchBar;
    searchBar.delegate = self;
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    // 搜索框颜色
    searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
    // 输入框颜色
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = [UIColor whiteColor];
    [searchField becomeFirstResponder];
    self.definesPresentationContext = YES;
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - <TableCiewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchRecord.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    cell.textLabel.text = self.searchRecord[indexPath.row];
    return cell;
}

#pragma mark - <TableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;
    [self backWithSearchWorld:str];
}

#pragma mark - <UISearchBarDelegate>
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"取消搜索");
    [self backWithSearchWorld:nil];
}
#pragma mark - <UISearchResultsUpdating>
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSString *searchStr = self.searchController.searchBar.text;
//    NSLog(@"搜索内容：%@", searchStr);
}

#pragma mark - 键盘监听(键盘消失判断是否执行搜索)
- (void)keyboardWillHide:(NSNotification *)notification {
    NSString *searchStr = self.searchController.searchBar.text;
    self.searchController.active = NO;
    if (M_CheckStrNil(searchStr)) {
        NSLog(@"搜索内容：%@", searchStr);
        [self updateSearchRecord:searchStr];
        [self backWithSearchWorld:searchStr];
        self.searchController.searchBar.text = searchStr;
    }
}
#pragma mark - 返回主页
- (void)backWithSearchWorld:(NSString *)key {
    UIViewController *VC = self.parentViewController;
    if ([VC respondsToSelector:@selector(searchWorld:)]) {
        [VC performSelectorOnMainThread:@selector(searchWorld:) withObject:key waitUntilDone:NO];
    }
}

#pragma mark - 搜索记录相关
- (NSArray<NSString *> *)searchRecord {
    NSArray<NSString *> *arr = [M_UserDefault valueForKey:@"SearchRecord"];
    return arr;
}
- (void)updateSearchRecord:(NSString *)str {
    if (!M_CheckStrNil(str))
        return;
    NSMutableArray<NSString *> *record = [[self searchRecord] mutableCopy];
    for (NSString *r in record) {
        if ([r isEqualToString:str]) 
            return;
    }
    if (record.count >= 5)
        [record removeLastObject];
    if (!record)
        record = [NSMutableArray array];
    [record insertObject:str atIndex:0];
    [M_UserDefault setValue:record forKey:@"SearchRecord"];
}
@end
