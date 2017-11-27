//
//  MenuVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MenuWidth M_Width * 2.0 / 5.0

@class ModelEventCategory;
typedef void (^blockSelectMenu)(NSArray<ModelEventCategory *> *selectedCategorys);
@interface MenuVC : UIViewController

/*
 * 显示侧边菜单
 * @param VC :要显示的菜单
 * @param categorys :类别
 * @param selectedCategorys :选中的类别
 * @param selected :选中的选项（之后改成数据模型）
 */
- (void)displayWithViewController:(UIViewController *)VC
                        categorys:(NSArray<ModelEventCategory *> *)categorys
                selectedCategorys:(NSArray<ModelEventCategory *> *)selectedCategorys
                       selectMenu:(blockSelectMenu)selected;
/** 隐藏侧边菜单 */
- (void)dismiss;
@end
