//
//  MySocket.m
//  MoCaCare
//
//  Created by xhb on 2017/10/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MySocket.h"
#import "GCDAsyncSocket.h"
#import "SVProgressHUD.h"

@interface MySocket() <GCDAsyncSocketDelegate>
/// 长连接
@property (nonatomic, strong) GCDAsyncSocket *socket;
@end

@implementation MySocket
/*
 * 实例化变量
 * @param gameMainVC :游戏主界面
 */
+ (instancetype)defaultSocket {
    static MySocket *socket;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socket = [MySocket new];
    });
    return socket;
}

/*
 * 连接Socket服务器
 */
+ (void)connectToService {
    MySocket *socket = [self defaultSocket];
    [socket connectToService];
}
- (void)connectToService {
    if (!self.socket)
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    if (!self.socket.isConnected) {
        // 与服务器通过三次握手建立连接
        NSError *error = nil;
        [self.socket connectToHost:SocketHost onPort:SocketPort withTimeout:60 error:&error];
        if (error) {
            [SVProgressHUD dismiss];
            [MyFunction displayAlertWithViewController:M_VC title:@"socket connect error" message:error.localizedDescription sure:^(UIAlertAction *action) {
                [self connectToService];
            }];
        }
    }
}

/*
 * 断开连接
 */
+ (void)disconnect {
    MySocket *socket = [self defaultSocket];
    [socket.socket disconnect];
}

#pragma mark - <GCDAsyncSocketDelegate>
/// 连接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    [SVProgressHUD dismiss];
    // 发送登录信息
    NSLog(@"socket服务创建成功，发送登录信息");
    NSString *uid = [ModelUser defaultUser].id;
    if (!M_CheckStrNil(uid)) {
        NSLog(@"找不到用户id,可能是游客模式,不连接socket");
        return;
    }
    NSDictionary *dict = @{@"uid": uid};
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    } else {
        [sock writeData:data withTimeout:-1 tag:SocketAutoTag];
        /// 基础监听
        [sock readDataWithTimeout:-1 tag:SocketBaseTag];
    }
}
/// 断开连接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    if (err) {
        NSLog(@"socket服务异常断开 ：%@", err.localizedDescription);
        [MyFunction displayAlertWithViewController:M_VC title:@"Server disconnect" message:@"please connect again" sure:^(UIAlertAction *action) {
            [SVProgressHUD showWithStatus:@"try connect again..."];
            [self connectToService];
        }];
    } else {
        NSLog(@"socket服务正常断开");
    }
}
/// 数据发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    //    NSLog(@"数据发送成功,数据标签【%ld】", tag);
    // 创建服务器消息监听，-1不超时
    [sock readDataWithTimeout:-1 tag:tag];
}
/// 读取数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    dispatch_async(dispatch_get_main_queue(), ^{
        /// 主线程处理
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"SocketReturn —— str:%@", str);
            NSArray<NSString *> *arr = [str componentsSeparatedByString:@"}"];
            [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *json = [NSString stringWithFormat:@"%@}", obj];
                NSData *jdata = [json dataUsingEncoding:NSUTF8StringEncoding];
                NSError *err;
                NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableContainers error:&err];
                if (!err) {
                    [self operateSocketDict:dict1];
                }
            }];
        } else {
            [self operateSocketDict:dict];
        }
    });
    /// 重置服务器消息监听，-1不超时
    [sock readDataWithTimeout:-1 tag:tag];
}

#pragma mark - 处理socket返回的数据
- (void)operateSocketDict:(NSDictionary *)dict {
    NSString *code = dict[@"code"];
    NSString *name;
    id data = dict[@"info"];
    switch (code.integerValue) {
        case 1:
            name = @"socket服务器注册成功";
            
            break;
        case 2: {
            name = @"获取聊天列表";
            [[NSNotificationCenter defaultCenter] postNotificationName:SocketNewMsg object:data];
            
            [MyFunction displayAlertStatusLabelWithMessage:data[@"msg"] duration:3];
            break;
        }
        default:
            break;
    }
    
#if DEBUG
    NSString *msg = dict[@"msg"];
    if (code.integerValue != 0)
        NSLog(@"—— SocketReturn ——\ncode:\t%@ \nname:\t%@\nmsg :\t%@ \ndata:\t%@\n———————————————", code, name, msg, data);
#endif
}
@end
