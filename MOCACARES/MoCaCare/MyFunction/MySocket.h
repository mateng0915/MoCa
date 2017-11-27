//
//  MySocket.h
//  MoCaCare
//
//  Created by xhb on 2017/10/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 需要引入
 * CFNetwork.framework
 * Security.framework
 */

#define SocketHost @"47.74.179.161"
#define SocketPort 8282
#define SocketAutoTag 1000
#define SocketBaseTag 2000

/// Notification
#define SocketHeartbeat @"SocketHeartbeat"
#define SocketRegister @"SocketRegister"
#define SocketNewMsg @"SocketNewMsg"

@interface MySocket : NSObject

/*
 * 实例化变量 
 */
+ (instancetype)defaultSocket;

/*
 * 连接Socket服务器
 */
+ (void)connectToService;

/*
 * 断开连接
 */
+ (void)disconnect;
@end
