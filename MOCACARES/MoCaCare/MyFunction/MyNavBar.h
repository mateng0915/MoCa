//
//  MyNavBar.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavBar : UIView
/// 返回按钮
@property (nonatomic, strong) UIButton *btnBack;
/// 标题
@property (nonatomic, strong) UILabel *lblTitle;
/// 分割线
@property (nonatomic, strong) UIView *vLine;
@end
