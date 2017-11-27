//
//  DataPickerVC.h
//  Demo
//
//  Created by xhb on 16/9/7.
//  Copyright © 2016年 xhb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^blockDataCompleted)(NSInteger idx, NSString *dataStr);

@interface DataPickerVC : UIViewController

/// 第一列数据（为数组）
@property (nonatomic, copy) NSArray *dataArr;

/**
 * 显示弹窗
 * @param VC :弹窗要出现的界面;
 * @param title :选择器标题;
 * @param dataArr :第一列数据源（数组）
 * @param completed :回调
 */
- (void)displayWithViewController:(UIViewController *)VC
                            title:(NSString *)title
                          dataArr:(NSArray *)dataArr
                        completed:(blockDataCompleted)completed;

@end
