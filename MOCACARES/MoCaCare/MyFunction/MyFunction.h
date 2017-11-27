//
//  MyFunction.h
//  Demo
//
//  Created by xhb on 16/3/14.
//  Copyright © 2016年 xhb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/// 界面切换模式
typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionTypePush = 0,
    TransitionTypePop,
    TransitionTypePopRoot
};

typedef NS_ENUM(NSInteger, GradientColorDirection) {
    GradientColorDirectionUp = 0,
    GradientColorDirectionDwon,
    GradientColorDirectionLeft,
    GradientColorDirectionRight
};

@interface MyFunction : NSObject

#pragma mark -- 缩放图片
/** 
 * 缩放图片
 * @param image :原图
 * @param size :缩放大小
 * @return 缩放后的图片
 */
+ (UIImage *)originImage:(UIImage *)image
             scaleToSize:(CGSize)size;

#pragma mark -- 计算Label大小 
/** 
 * 根据Label的字号、大小计算内容大小
 * @param message :内容
 * @param size :textView字号
 * @param width :label宽度
 * @return label的大小
 */
+ (CGSize)getLabelSizeWithMessage:(NSString *)message
                         fontSize:(CGFloat)size
                       labelWidth:(CGFloat)width;

#pragma mark -- 提示窗
/**
 * 提示窗状态栏
 * @param message :提示内容
 * @param duration 显示时长
 */
+ (void)displayAlertStatusLabelWithMessage:(NSString *)message
                                  duration:(CGFloat)duration;
/**
 * 提示窗Label
 * @param message :提示内容
 * @param duration 显示时长
 */
+ (void)displayAlertLabelWithMessage:(NSString *)message
                            duration:(CGFloat)duration;
/**
 * 提示窗Label
 * @param message :提示内容 显示3s
 */
+ (void)displayAlertLabelWithMessage:(NSString *)message; 

/**
 * 提示窗UIAlertController(提示用，只有一个确定按钮)
 * @param VC :显示的视图控制器
 * @param title :提示标题
 * @param message :提示内容
 * @param sure :确定按钮回调
 */
+ (void)displayAlertWithViewController:(UIViewController *)VC
                                 title:(NSString *)title
                               message:(NSString *)message
                                  sure:(void (^)(UIAlertAction *action))sure;
/**
 * 提示窗UIAlertController(操作用，有确定、取消按钮)
 * @param VC :显示的视图控制器
 * @param title :提示标题
 * @param message :提示内容
 * @param sure :确定按钮回调
 * @param cancel :取消按钮回调
 */
+ (void)displayAlertWithViewController:(UIViewController *)VC
                                 title:(NSString *)title
                               message:(NSString *)message
                                  sure:(void (^)(UIAlertAction *action))sure
                                cancel:(void (^)(UIAlertAction *action))cancel;

#pragma mark -- 计算单行文本的合理字体大小
/**
 * 计算单行文本的合理字体大小
 * @param msg :文本内容
 * @param viewSize :容器大小
 * @param maxFont :用户自定义最大字号
 * @return 字体大小
 */
+ (CGFloat)getFontSizeWithMessage:(NSString *)msg
                        viewSize:(CGSize)viewSize
                          maxFont:(CGFloat)maxFont;

#pragma mark -- 生成纯色图片
/**
 * 生成纯色图片
 * @param color :图片颜色
 * @return 纯色图片
 */
+ (UIImage *)creatImageWithColor:(UIColor *)color;
 
#pragma mark -- 设置NavigationController样式
+ (void)hiddenUnderHairlineWithNavigationController:(UINavigationController *)NVC;

#pragma mark -- 修改图片大小做成导航图标
/**
 * 修改图片大小做成导航图标
 * @param name :原图片名称
 */
+ (UIImage *)createItemImageWithName:(NSString *)name;

#pragma mark -- 根据16进制生成对应颜色
/** 
 * 根据16进制生成对应颜色
 * @param hexStr :十六进制字符串
 * @param alpha :颜色透明度
 * @return 颜色对象
 */
+ (UIColor *)colorWithHexString:(NSString *)hexStr
                          alpha:(CGFloat)alpha;
 
@end
 
