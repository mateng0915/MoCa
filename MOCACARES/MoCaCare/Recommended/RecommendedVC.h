//
//  RecommendedVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelEventCategory;
@interface RecommendedVC : UIViewController
/// 按钮——菜单
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;


/// 数据源
@property (nonatomic, copy) NSArray<ModelEventCategory *> *categorys;
/// 当前选中的类别(多选)
@property (nonatomic, strong) NSMutableArray<ModelEventCategory *> *selectedCategorys;

/** 显示菜单 */
- (IBAction)btnMenuClick:(UIButton *)sender;
@end
