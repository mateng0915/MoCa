//
//  AccountEditPasswordVC.h
//  MoCaCare
//
//  Created by xhb on 2017/10/12.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EditPasswortType) {
    /// 正在修改密码界面
    EditPassword = 0,
    /// 修改完成
    EditPasswordCompleted
};

@interface AccountEditPasswordVC : UIViewController


/** 实例化 */
+ (instancetype)defalutType:(EditPasswortType)type;
@end
