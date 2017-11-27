//
//  ChatVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatVC : UIViewController
/// 返回按钮
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
/// 聊天对象用户名
@property (weak, nonatomic) IBOutlet UILabel *lblChatUserName;
/// 聊天输入框容器
@property (weak, nonatomic) IBOutlet UIView *viewInput;
/// 聊天输入框
@property (weak, nonatomic) IBOutlet UITextField *textField;

/// 聊天对象id
@property (nonatomic, copy) NSString *chatUserId;
/// 聊天对象昵称
@property (nonatomic, copy) NSString *chatName;
/*
 * 显示聊天窗口
 * @param VC :上一页
 * @param chatUserId :聊天对象id
 * @param chatName :聊天对象昵称
 */
+ (void)displayWithViewController:(UIViewController *)VC
                       chatUserId:(NSString *)chatUserId
                         chatName:(NSString *)chatName;

/** 返回上一页 */
- (IBAction)btnBackClick:(UIButton *)sender;
/** 选择其他消息类型（图片、表情） */
- (IBAction)btnOhterMsgClick:(UIButton *)sender;
/** 发送消息 */
- (IBAction)btnSendMsgClick:(UIButton *)sender;
@end
