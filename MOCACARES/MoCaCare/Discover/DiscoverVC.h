//
//  DiscoverVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverVC : UIViewController

/// 搜索框父视图
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
/// 主视图
@property (weak, nonatomic) IBOutlet UIView *viewContent;
/// 搜索栏
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
/// 搜索内容
@property (nonatomic, copy) NSString *searchString;

/** 激活搜索栏 */
- (IBAction)btnSearchClick:(UIButton *)sender;
@end
