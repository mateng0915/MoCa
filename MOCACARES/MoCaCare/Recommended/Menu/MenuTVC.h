//
//  MenuTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuVC.h"

@class ModelEventCategory;
@interface MenuTVC : UITableViewController

/// 数据源
@property (nonatomic, copy) NSArray<ModelEventCategory *> *categorys;
/// 回调
@property (nonatomic, copy) blockSelectMenu blockMenu;

/// 当前选中的类别(多选)
@property (nonatomic, strong) NSMutableArray<ModelEventCategory *> *selectedCategorys;

 
@end
