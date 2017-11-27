//
//  UILabel+ThemeFont.h
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ThemeFont)

/** 创建自定义加粗字体 */
+ (UIFont *)themeBoldFontOfSize:(CGFloat)size;
/** 创建自定义普通字体 */
+ (UIFont *)themeFontOfSize:(CGFloat)size;

/** 设置自定义粗体 */
- (void)themeBoldFontOfSize:(CGFloat)size;
/** 设置自定义普通字体 */
- (void)themeFontOfSize:(CGFloat)size;

/** 计算label高度 */
- (CGFloat)autolayoutHeighWithWidth:(CGFloat)width;
@end
