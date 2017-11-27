//
//  TimePackerVC.h
//  GouMei
//
//  Created by xhb on 16/12/26.
//  Copyright © 2016年 youmijia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^blockTimeCompleted)(NSString *timeStr);
typedef NS_ENUM(NSInteger, PickerType) {
    /// 时间
    PickerTypeTime = 0,
    /// 日期
    PickerTypeDate,
    /// 都有
    PickerTypeDateAndTime
};

@interface TimePickerVC : UIViewController

/** 显示 */
- (void)displayWithViewController:(UIViewController *)VC
                            title:(NSString *)title
                             type:(PickerType)type
                        cmopleted:(blockTimeCompleted)completed;

/** 隐藏 */
- (void)dismiss;
@end
