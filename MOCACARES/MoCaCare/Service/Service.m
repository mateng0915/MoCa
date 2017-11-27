//
//  Service.m
//  Demo
//
//  Created by xhb on 16/8/25.
//  Copyright © 2016年 kaibuleite. All rights reserved.
//

#import "Service.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AccountLoginTVC.h"
#import "MainTabBarController.h"

@implementation Service

+ (AFHTTPSessionManager *)getManager {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    static AFHTTPSessionManager *manager;
    if (manager) {
        return manager;
    }
    manager = [AFHTTPSessionManager manager];
    // 修改超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"]; 
    
    // 传表单
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",  @"text/html", @"text/plain", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 传JSON字符串
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];//添加相应内容类型
    return manager;
}

#pragma mark POST操作
+ (void)postURLString:(NSString *)string
            parameter:(NSDictionary *)parameter
             progress:(void (^)(NSProgress *uploadProgress))uploadProgress
              success:(void (^)(NSDictionary *result))success
              failure:(FailureBlock)failure {
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [self getManager];
    /// 获取接口完整链接
    NSString *url = [self getInterfaceCompleteURLWithString:string];
    // 2.发送请求
    [manager POST:url parameters:parameter progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /// 隐藏加载动画
        [SVProgressHUD dismiss];
        /// 获取JSON处理后的字典
        NSDictionary *result = [self getResultWithResponseObject:responseObject];
        if (!result)
            [self logURL:url parameter:parameter success:YES];
        if ([self checkResult:result logSuccessMsg:NO failure:failure])
            success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription duration:1];
        NSLog(@"请求失败,错误原因：%@", error.localizedDescription);
        [self logURL:url parameter:parameter success:NO];
        failure();
    }];
}

#pragma mark 输出接口状态日志
/** 输出接口状态日志
 * @parameter string:接口地址
              parameter:参数
              success:接口是否请求成功
 */
+ (void)logURL:(NSString *)string parameter:(id)parameter success:(BOOL)success {
    if (success) {
        NSLog(@"\n--------\n接口请求成功，数据返回有问题\n接口URL :\n%@", string);
    } else {
        NSLog(@"\n--------\n接口请求失败\n接口URL :\n%@", string);
    }
    
    if (parameter != nil) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            NSLog(@"\n--------\n传的参数转换成JSON错误 :\n%@", error.localizedDescription);
        }
        if (!data) {
            NSLog(@"\n--------\n传的参数转换成JSON失败，转换成String :%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"\n--------\n传的参数 :\n%@", parameter);
        }
        
        if (![parameter isKindOfClass:[NSDictionary class]]) {
            NSLog(@"\n--------\n传的参数的数据类型不是字典 :\n%@", [parameter class]);
            return;
        }
        NSMutableString *postStr = [NSMutableString string];
        NSArray *keys = ((NSDictionary *)parameter).allKeys;
        for (NSString *key in keys) {
            [postStr appendString:key];
            [postStr appendString:@"="];
            if ([((NSDictionary *)parameter)[key] isKindOfClass:[NSString class]]) {
                [postStr appendString:((NSDictionary *)parameter)[key]];
            }
            [postStr appendString:@"&"];
        }
        if (postStr.length > 0) {
            NSLog(@"\n--------\n转换成POST参数格式 :\n%@", [postStr substringToIndex:postStr.length-1]);
        }
    }
}


#pragma mark 上传
+ (void)uploadURLString:(NSString *)string
              parameter:(NSDictionary *)parameter
               fileData:(NSData *)data
               fileType:(UploadFileType)type
               fileName:(NSString *)inputName
               progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                success:(void (^)(NSDictionary *result))success
                failure:(FailureBlock)failure {
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [self getManager];
    /// 获取接口完整链接
    NSString *url = [self getInterfaceCompleteURLWithString:string];
    // 2.上传文件
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置日期格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        // 将日期字符串加入图片名称，防止重复
        NSString *fileName = [formatter stringFromDate:[NSDate date]];
        // 裁减掉没用的字符
        fileName = [fileName stringByReplacingOccurrencesOfString:@" " withString:@""];
        fileName = [fileName stringByReplacingOccurrencesOfString:@":" withString:@""];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        /// 格式名称
        NSString *name;
        /// 文件类型
        NSString *fileType;
        if (type == UploadFileTypeImage) {
            name = @"image";
            fileType = @"image/jepg";
            if (inputName) {
                fileName = [NSString stringWithFormat:@"%@_%@.jpg", inputName, fileName];
            } else {
                fileName = [NSString stringWithFormat:@"image_%@.jpg",  fileName];
            }
        } else {
            name = @"video";
            fileType = @"video/quicktime"; 
            if (inputName) {
                fileName = [NSString stringWithFormat:@"%@_%@.mov", inputName, fileName];
            } else {
                fileName = [NSString stringWithFormat:@"%movie_%@.mov", fileName];
            }
        }
        /// 后台要求
        fileType = @"file";
        name = @"filename";
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:fileType];
    } progress:uploadProgress
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              [SVProgressHUD dismiss];
              NSDictionary *result = [self getResultWithResponseObject:responseObject];
              if (!result)
                  [self logURL:url parameter:parameter success:YES];
              if ([self checkResult:result logSuccessMsg:NO failure:failure])
                  success(result);
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [SVProgressHUD showErrorWithStatus:error.localizedDescription duration:1];
              NSLog(@"请求失败,错误原因：%@", error.localizedDescription);
              [self logURL:url parameter:parameter success:NO];
              failure();
          }
     ];
}


#pragma mark - 上传图片
+ (void)uploadImage:(NSData *)imgData
          imageName:(NSString *)imageName
            success:(void (^)(NSString *imgUrl))success
            failure:(FailureBlock)failure {
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    ModelUser *user = [ModelUser defaultUser];
    if (user.id)
        imageName = [NSString stringWithFormat:@"uid_%@_%@", user.id, imageName];

    [self uploadURLString:@"api/public/upLoadImg" parameter:nil fileData:imgData fileType:UploadFileTypeImage fileName:imageName progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result); 
        NSString *imgurl = result[@"info"];
        if (!M_CheckStrNil(imgurl)) {
            [MyFunction displayAlertLabelWithMessage:@"image upload failure"];
            failure();
        } else {
            success(imgurl);
        }
    } failure:^{
        failure();
    }];
}

#pragma mark 获取接口完整链接
/** 获取接口完整链接 */
+ (NSString *)getInterfaceCompleteURLWithString:(NSString *)string {
    if (string.length > 4) {
        NSString *header = [string substringToIndex:4];
        /// 判断链接头，如果已经是完整的链接则不需要再一次拼接
        if ([header isEqualToString:@"http"]) {
            // 连接已经是完整的,不用处理
            return string;
        }
    }
    NSString *url = [[baseAPIStr stringByAppendingString:string] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}

#pragma mark 获取图片完整链接
+ (NSURL *)getImageCompleteURLWithString:(NSString *)string {
    if (!M_CheckStrNil(string)) {
//        [MyFunction displayAlertLabelWithMessage:@"图片链接为空"];
        return nil;
    }
    if (string.length >= 4) {
        NSString *http = [string substringToIndex:4];
        if ([http isEqualToString:@"http"]) {
            // 连接已经是完整的,不用处理
            return [NSURL URLWithString:string];
        }
    }
    NSString *url = [[baseIMGStr stringByAppendingString:string] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:url];
}

#pragma mark 数据处理
/** 简单处理返回数据 */
+ (NSDictionary *)getResultWithResponseObject:(id)responseObject; {
//    NSLog(@"%@", responseObject);
//    NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    if (responseObject == nil) {
        NSLog(@"返回的结果为空");
        return nil;
    }
    if ([responseObject isKindOfClass:[NSNull class]]) {
        NSLog(@"数据为NULL");
        return nil;
    }
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"返回的数据已经是JSON,不用转换数据类型");
        return responseObject;
    }
    NSError *error =  nil;
//    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
    if (error != nil) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"\n数据处理出错：%@\n转换的结果:%@\n试着转成 String 再试一次, 转换的 String ：%@", error.localizedDescription, result, jsonString);
        if ([jsonString isEqualToString:@""] || !jsonString) {
            return nil;
        }
        error = nil;
        result = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        
        if (error != nil) {
            NSLog(@"\n数据处理出错:%@\n转换的结果:%@", error.localizedDescription, result);
            return nil;
        }
    }
    return result;
}

/** 验证数据 */
+ (BOOL)checkResult:(NSDictionary *)result
      logSuccessMsg:(BOOL)log
            failure:(FailureBlock)failure {
    /// 获取状态标识符
    NSString *code = result[@"code"];
    if ([code isKindOfClass:[NSNull class]])
        code = @"0";
    
    if (code.integerValue != 1) {
//        NSLog(@"返回标识码不是1：\n%@", result);
        NSString *msg = result[@"msg"];
        if (!M_CheckStrNil(msg))
            msg = [NSString stringWithFormat:@"data error【%@】", [msg class]];
        [MyFunction displayAlertLabelWithMessage:msg];
        
        if (code.integerValue == 2) { 
            NSLog(@"该接口需要登录下才能访问");
            [ModelUser logOut]; 
            [AccountLoginTVC display];
        }
        
        if (failure)
            failure();
        return NO;
    }
    if (log)
        [MyFunction displayAlertLabelWithMessage:result[@"msg"]];
    return YES;
}

/** 提取数据内的数组 */
+ (NSArray *)getModelArrayWithDataArray:(NSArray *)array
                         itemModelClass:(Class)className {
    if (!M_CheckArrayNil(array)) { 
//        NSLog(@"\n----------\n%@\n----------", [NSString stringWithFormat:@"无法提取Array数据：%@", array]);
        return nil;
    }
    // 这里需要与后台人员协商统一数据返回格式
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *info = array[i];
//        NSLog(@"\n%@", info);
        id model = [[className alloc] initWithDictionary:info];
        if (model)
            [list addObject:model];
//        NSLog(@"\n%@", [model values]);
    }
    return list;
}

/** 数据MD5加密 */
+ (NSString *)transMD5Code:(NSString *)inputText {
    NSString *newInpuText = md5(inputText);
    const char *cStr = [newInpuText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    NSString *md5 = [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ] lowercaseString];
    return md5;
}

/// 用静态函数防止被黑
static NSString *md5 (NSString *inputText) {
    /// 加密字段
    NSString *keyWord = @"XXX";
    return [NSString stringWithFormat:@"%@%@", inputText, keyWord];
}

/** 设置可变字典 */
+ (void)setMutableDictionary:(NSMutableDictionary *)dictionary value:(id)value key:(NSString *)key {
    if (value)
        [dictionary setValue:value forKey:key];
}
@end
