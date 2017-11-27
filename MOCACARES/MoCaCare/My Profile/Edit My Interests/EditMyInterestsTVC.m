//
//  EditMyInterestsTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EditMyInterestsTVC.h"
#import "EditMyInterestsCell.h"
#import "SeeUserPageVC.h"

@implementation EditMyInterestsTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.searchController.active = NO;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad]; 
    [self.tableView registerNib:[UINib nibWithNibName:@"EditMyInterestsCell" bundle:self.nibBundle] forCellReuseIdentifier:@"EditMyInterestsCell"];
    // 设置表头
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, M_Width, 30)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, M_Width, 30)];
    lbl.text = @"INDIVIDUALS"; 
    [lbl themeFontOfSize:20.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:lbl];
    self.tableView.tableHeaderView = headerView;
    if (self.type == FridensTypeOrganization) {
        lbl.text = @"ORGANIZATIONS";
        // 初始化搜索栏目
        self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        self.searchController.delegate = self;
        self.searchController.searchResultsUpdater = self;
        // 搜索时，背景变暗色
        self.searchController.dimsBackgroundDuringPresentation = YES;
        // 点击搜索的时候,是否隐藏导航栏
        self.searchController.hidesNavigationBarDuringPresentation = NO;
        // 搜索框样式
        UISearchBar *searchBar = self.searchController.searchBar;
        searchBar.searchBarStyle = UISearchBarStyleMinimal;
        // 搜索框颜色
        searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
        // 输入框颜色
        UITextField *searchField = [searchBar valueForKey:@"_searchField"];
        searchField.backgroundColor = [UIColor whiteColor];
        // 必须独立放一个view里面，否则会发生偏移bug
        headerView.frame = CGRectMake(0, 0, M_Width, 30 + 44);
        UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, M_Width, 44)];
        searchView.backgroundColor = [UIColor clearColor];
        [searchBar sizeToFit];
        [searchView addSubview:searchBar];
        
        [headerView addSubview:searchView];
        self.tableView.tableHeaderView = headerView;
        
        self.definesPresentationContext = YES;
        
        // 监听键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    self.tableView.rowHeight = 70.0;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, M_Width, 22)];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 请求数据
- (void)requestData {
    [ServiceMyProfile getFriendList:self.type success:^(NSArray<ModelMyInterests *> *list) {
        self.friends = [list copy];
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

#pragma mark - <TableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
} 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditMyInterestsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditMyInterestsCell" forIndexPath:indexPath];
    ModelMyInterests *model = self.friends[indexPath.row];
    cell.model = model;
    cell.tvc = self;
    return cell;
}

#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ModelMyInterests *model = self.friends[indexPath.row];
    [SeeUserPageVC displayWithViewController:self
                                      userId:model.fid];
}

#pragma mark - <UISearchResultsUpdating>
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSString *searchStr = self.searchController.searchBar.text;
//    NSLog(@"搜索内容：%@", searchStr);
}

#pragma mark - 键盘监听(键盘消失判断是否执行搜索)
- (void)keyboardHide:(NSNotification *)notification {
    NSString *searchStr = self.searchController.searchBar.text;
    self.searchController.active = NO;
    if (M_CheckStrNil(searchStr)) {
        NSLog(@"搜索内容：%@", searchStr);
    }
    self.searchController.searchBar.text = searchStr;
}
@end
