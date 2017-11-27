//
//  Service.h
//  XWApp
//
//  Created by xhb on 16/8/25.
//  Copyright © 2016年 youmijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "ModelUser.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#pragma mark - 正式线
/// 接口地址通用前缀
static NSString *baseAPIStr = @"http://coco.elysoft.cn/";
/// 图片地址通用前缀
static NSString *baseIMGStr = @"http://coco.elysoft.cn/";

typedef enum {
    UploadFileTypeImage = 0,
    UploadFileTypeVideo
}UploadFileType;

typedef void (^SuccessBlock)();
typedef void (^FailureBlock)();
@interface Service : NSObject

#pragma mark - POST操作
/*
 * POST操作
 * @param string :接口地址
 * @param dataInfo :参数
 * @param uploadProgress :加载回调
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)postURLString:(NSString *)string
            parameter:(NSDictionary *)dataInfo
             progress:(void (^)(NSProgress *uploadProgress))uploadProgress
              success:(void (^)(NSDictionary *result))success
              failure:(FailureBlock)failure;

#pragma mark - 上传
/*
 * 上传图片、视频 根据type决定，具体参照枚举值
 * @param string :接口地址
 * @param dataInfo :参数
 * @param data :文件主体
 * @param fileType :文件类型
 * @param fileName :文件名
 * @param uploadProgress :加载回调
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)uploadURLString:(NSString *)string
              parameter:(NSDictionary *)dataInfo
               fileData:(NSData *)data
               fileType:(UploadFileType)type
               fileName:(NSString *)inputName
               progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                success:(void (^)(NSDictionary *result))success
                failure:(FailureBlock)failure;


#pragma mark - 上传图片
/*
 * 上传图片
 * @param imgData :文件主体
 * @param imageName :文件名 
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)uploadImage:(NSData *)imgData
          imageName:(NSString *)imageName
            success:(void (^)(NSString *imgUrl))success
            failure:(FailureBlock)failure;

#pragma mark - 获取接口完整链接
/** 获取接口完整链接 */
+ (NSString *)getInterfaceCompleteURLWithString:(NSString *)string;

#pragma mark - 获取图片完整链接
/** 获取图片完整链接 */
+ (NSURL *)getImageCompleteURLWithString:(NSString *)string;

#pragma mark - 数据处理
/*
 * 简单处理返回数据 
 * @param responseObject :要处理的数据
 * @return 处理好的数据
 */
+ (NSDictionary *)getResultWithResponseObject:(id)responseObject;

/*
 * 验证数据 
 * @param result :要验证的数据
 * @param log :是否打印成功信息标识符
 * @param failure :失败回调
 */
+ (BOOL)checkResult:(NSDictionary *)result
      logSuccessMsg:(BOOL)log
            failure:(FailureBlock)failure;

/*
 * 提取数据内的数组
 * @param array :要提取的数组
 * @param className :对应数据模型的类型
 * @return 提取好的数组
 */
+ (NSArray *)getModelArrayWithDataArray:(NSArray *)array
                         itemModelClass:(Class)className;

/*
 * 数据MD5加密
 * @param inputText :要加密的字符串
 * @return 加密好的字符串
 */
+ (NSString *)transMD5Code:(NSString *)inputText;

/*
 * 设置可变字典
 * @param dictionary :要改变的可变字典
 * @param value :值
 * @param key :键
 */
+ (void)setMutableDictionary:(NSMutableDictionary *)dictionary value:(id)value key:(NSString *)key;

@end
