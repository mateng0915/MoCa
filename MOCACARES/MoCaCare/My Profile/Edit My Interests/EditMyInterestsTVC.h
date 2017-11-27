//
//  EditMyInterestsTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceMyProfile.h"

@interface EditMyInterestsTVC : UITableViewController <UISearchControllerDelegate, UISearchResultsUpdating, UITextFieldDelegate>

/// 列表类型
@property (nonatomic, assign) FridensType type;
/// 搜索栏
@property (nonatomic, strong) UISearchController *searchController;
/// 数据源
@property (nonatomic, copy) NSArray<ModelMyInterests *> *friends;
/** 获取数据 */
- (void)requestData;
@end
