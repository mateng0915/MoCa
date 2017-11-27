//
//  DiscoverSearchTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverSearchTVC : UITableViewController
/// 查询记录
@property (nonatomic, copy) NSArray *searchRecord;
/// 搜索框
@property (nonatomic, strong) UISearchController *searchController;

@end
