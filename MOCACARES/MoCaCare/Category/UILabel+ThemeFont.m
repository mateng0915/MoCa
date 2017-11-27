//
//  UILabel+ThemeFont.m
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "UILabel+ThemeFont.h"
#import <objc/runtime.h>

@implementation UILabel (ThemeFont)


#pragma mark - 替换字体
/** 创建自定义加粗字体 */
+ (UIFont *)themeBoldFontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"Exo2-Bold" size:size];
    return font;
}
/** 创建自定义普通字体 */
+ (UIFont *)themeFontOfSize:(CGFloat)size {
//    UIFont *font = [UIFont fontWithName:@"Exo2-Regular" size:size];
    UIFont *font = [UIFont fontWithName:@"Exo2-thin" size:size];
    return font;
}
- (void)themeBoldFontOfSize:(CGFloat)size {
    self.font = [UILabel themeBoldFontOfSize:size];
}
- (void)themeFontOfSize:(CGFloat)size {
    self.font = [UILabel themeFontOfSize:size];
}

#pragma mark - 替换系统自带的始化方法来改变storyboard上的字体
+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //替换三个方法
        SEL original1 = @selector(init);
        SEL original2 = @selector(initWithFrame:);
        SEL original3 = @selector(awakeFromNib);
        
        SEL replace1 = @selector(replaceInit);
        SEL replace2 = @selector(replaceInitWithFrame:);
        SEL replace3 = @selector(replaceAwakeFromNib);
        
        [self original:original1 replace:replace1];
        [self original:original2 replace:replace2];
        [self original:original3 replace:replace3];
    }); 
}
/// 替换系统默认方法
+ (void)original:(SEL)selector_o replace:(SEL)selector_r {
    Class class = [self class];
    // 得到类的实例方法
    Method method_o = class_getInstanceMethod(class, selector_o);
    Method method_r = class_getInstanceMethod(class, selector_r);
    
    // 给类添加一个新的方法和该方法的具体实现
    // 使用 method_getImplementation 获取方法的IMP
    // 使用 method_getTypeEncoding 获取方法的Type字符串(包含参数类型和返回值类型)
    BOOL didAddMethod =
    class_addMethod(class, selector_o, method_getImplementation(method_r), method_getTypeEncoding(method_r));
    
    if (didAddMethod) {
        // 添加成功，替换类中已有方法的实现,如果该方法不存在添加该方法
        class_replaceMethod(class, selector_r, method_getImplementation(method_o), method_getTypeEncoding(method_o));
    } else {
        // 添加失败，替换方法
        method_exchangeImplementations(method_o, method_r);
    }
}

- (instancetype)replaceInit {
    id __self = [self replaceInit];
    [self replaceThemeFont];
    return __self;
    
}
- (instancetype)replaceInitWithFrame:(CGRect)rect {
    id __self = [self replaceInitWithFrame:rect];
    [self replaceThemeFont];
    return __self;
}
- (void)replaceAwakeFromNib {
    [self replaceAwakeFromNib];
    [self replaceThemeFont];
}
- (void)replaceThemeFont {
    NSString *currentFontName = self.font.fontName;
    if ([currentFontName rangeOfString:@"Exo2"].length != 0) {
//        NSLog(@"%@", currentFontName);
    }
    UIFont * font = [UIFont fontWithName:@"Exo2-light" size:self.font.pointSize];
    if (font)
        self.font = font;
}

#pragma mark - 计算label高度
- (CGFloat)autolayoutHeighWithWidth:(CGFloat)width {
    CGSize size = CGSizeMake(width, 0);
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    CGRect frame = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return frame.size.height;
}

@end
