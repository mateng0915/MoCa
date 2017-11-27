//
//  MyFunction.m
//  Demo
//
//  Created by xhb on 16/3/14.
//  Copyright © 2016年 xhb. All rights reserved.
//

#import "MyFunction.h"

@implementation MyFunction

#pragma mark -- 缩放图片
+ (UIImage *)originImage:(UIImage *)image
             scaleToSize:(CGSize)size {
    // 创建一个bitmap的context, 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

#pragma mark -- 计算Label大小
+ (CGRect)getMessageSizeWithLabel:(UILabel *)label
                          message:(NSString *)message {
    label.numberOfLines = 0;
    CGSize size = CGSizeMake(label.bounds.size.width, 0);
    NSDictionary *attribute = @{NSFontAttributeName: label.font};
    CGRect frame = [message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return frame;
}
+ (CGSize)getLabelSizeWithMessage:(NSString *)message
                         fontSize:(CGFloat)size
                       labelWidth:(CGFloat)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
//    label.font = [UIFont systemFontOfSize:size];
    label.font = [UILabel themeFontOfSize:size];
    CGRect rect = [self getMessageSizeWithLabel:label message:message];
    return rect.size;
}

#pragma mark -- 提示窗
+ (UILabel *)createLabel:(NSString *)message {
//    UILabel *label = [[UIApplication sharedApplication].keyWindow viewWithTag:6666];
    UILabel *label = [[UILabel alloc] init];
    label.tag = 6666;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5;
    label.alpha = 1;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:label];
    label.frame = CGRectMake(0, 0, M_Width-60, 0);
    // 计算message的大小
    CGRect frame = [self getMessageSizeWithLabel:label
                                         message:message];
    // 内容两边加点空隙比较美观
    frame.size.width += 20;
    // 防止小数的原因造成控件太小换不了行
    frame.size.height += 16;
    if (frame.size.width >= M_Width-60) {
        frame.size.width = M_Width-60;
    }
    label.frame = frame;
    label.text = message;
    label.center = CGPointMake(M_Width/2.0, M_Height/2.0);
    return label;
}

+ (void)displayAlertStatusLabelWithMessage:(NSString *)message
                                  duration:(CGFloat)duration {
    UILabel *label = [self createLabel:message];
    label.layer.cornerRadius = 0;
    label.frame = CGRectMake(0, -20, M_Width, 20);
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 1;
    label.window.windowLevel = UIWindowLevelAlert;
    [UIView animateWithDuration:0.5 animations:^{
        label.frame = CGRectMake(0, 0, M_Width, 20);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                label.frame = CGRectMake(0, -20, M_Width, 20);
            } completion:^(BOOL finished) {
                label.window.windowLevel = UIWindowLevelNormal;
                [label removeFromSuperview];
            }];
        });
    }];
}

+ (void)displayAlertLabelWithMessage:(NSString *)message
                            duration:(CGFloat)duration {
    UILabel *label = [self createLabel:message];
    [UIView animateWithDuration:1 animations:^{
        label.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}
+ (void)displayAlertLabelWithMessage:(NSString *)message {
    [self displayAlertLabelWithMessage:message duration:3];
} 
+ (void)displayAlertWithViewController:(UIViewController *)VC
                                 title:(NSString *)title
                               message:(NSString *)message
                                  sure:(void (^)(UIAlertAction *action))sure {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleCancel handler:sure];
    [alertController addAction:sureAc];
    [VC presentViewController:alertController animated:YES completion:nil];
}

+ (void)displayAlertWithViewController:(UIViewController *)VC
                                 title:(NSString *)title
                               message:(NSString *)message
                                  sure:(void (^)(UIAlertAction *action))sure
                                cancel:(void (^)(UIAlertAction *action))cancel {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:sure];
    [alertController addAction:sureAc];
    UIAlertAction *cancelAc = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:cancel];
    [alertController addAction:cancelAc];
    [VC presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- 计算单行文本的合理字体大小
+ (CGFloat)getFontSizeWithMessage:(NSString *)msg
                         viewSize:(CGSize)viewSize
                          maxFont:(CGFloat)maxFont {
    CGSize size = [MyFunction getLabelSizeWithMessage:msg fontSize:maxFont labelWidth:MAXFLOAT];
    if (size.width > viewSize.width) {
        maxFont --;
        return [self getFontSizeWithMessage:msg viewSize:viewSize maxFont:maxFont];
    }
//    NSLog(@"最终决定字号：%.2f", maxFont);
    return maxFont;
}

#pragma mark -- 生产纯色图片
+ (UIImage *)creatImageWithColor:(UIColor *)viewColor {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    view.backgroundColor = viewColor;
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
 
#pragma mark -- 设置NavigationController样式
+ (UIImageView *)findUnderHairlineWithNavigationControllerView:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findUnderHairlineWithNavigationControllerView:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
+ (void)hiddenUnderHairlineWithNavigationController:(UINavigationController *)NVC {
    [self findUnderHairlineWithNavigationControllerView:NVC.view].hidden = YES;
}

#pragma mark -- 修改图片大小做成导航图标
+ (UIImage *)createItemImageWithName:(NSString *)name {
    UIImage *img = [UIImage imageNamed:name];
    CGFloat var = img.size.width / img.size.height;
    // nav和tab上的图片一般为30，宽度自适应
    CGFloat h = 30;
    CGFloat w = h * var;
    img = [self originImage:img scaleToSize:CGSizeMake(w, h)];
    return img;
}

#pragma mark -- 根据16进制生成对应颜色
+ (UIColor *)colorWithHexString:(NSString *)hexStr
                          alpha:(CGFloat)alpha {
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // 去掉16进制中开头的无用字符
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] < 6) {
        NSLog(@"颜色数值有误，返回透明");
        return [UIColor clearColor];
    }
    
    // 截取范围
    NSRange range = NSMakeRange(0, 2);
    // r
    NSString *rString = [cString substringWithRange:range];
    // g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    // b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // 扫描字符串并转换成10进制
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:alpha];
}

@end
