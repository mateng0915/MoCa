//
//  ChatVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ChatVC.h"
#import "ChatTVC.h"
#import "ServiceMyProfile.h"

@interface ChatVC() <UITextFieldDelegate>
/// 输入框起始底部坐标
@property (nonatomic, assign) CGFloat originBottomTextFiled;
/// 聊天记录
@property (nonatomic, weak) ChatTVC *chatTVC;
@end
@implementation ChatVC

+ (void)displayWithViewController:(UIViewController *)VC
                       chatUserId:(NSString *)chatUserId
                         chatName:(NSString *)chatName {
    ChatVC *Chat = [UIStoryboard storyboardWithName:@"Chat" bundle:VC.nibBundle].instantiateInitialViewController;
    Chat.chatUserId = chatUserId;
    Chat.chatName = chatName;
    [VC.navigationController pushViewController:Chat animated:YES];
}

#pragma mark - 视图加载
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ShowBtnEvents(NO);
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    ShowBtnEvents(YES);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    self.btnBack.tintColor = [UIColor darkTextColor];
    [self.btnBack setImage:[MyFunction createItemImageWithName:@"icon_back"] forState:UIControlStateNormal];
    self.lblChatUserName.text = self.chatName;
    self.textField.layer.cornerRadius = 4.0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ChatTVCSegue"]) {
        self.chatTVC = segue.destinationViewController;
        self.chatTVC.chatUserId = self.chatUserId;
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 按钮事件
- (IBAction)btnBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnOhterMsgClick:(UIButton *)sender {
    NSLog(@"other");
}
- (IBAction)btnSendMsgClick:(UIButton *)sender {
//    NSLog(@"send");
    [self.textField resignFirstResponder];
    ModelChatMsg *model = [ModelChatMsg new];
    model.fid = [ModelUser defaultUser].id;
    model.sid = self.chatUserId;
    model.msg = self.textField.text;
    
    sender.userInteractionEnabled = NO;
    [ServiceMyProfile sendChatMsg:model success:^{
        sender.userInteractionEnabled = YES;
        self.textField.text = @"";
        [self.chatTVC requestData];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}

#pragma mark - 键盘监听
- (void)keyboardWillShow:(NSNotification *)notification {
    /// 全局变量保证输入框的初始位置，便于计算
    if (self.originBottomTextFiled == 0) {
        CGPoint point = [self.viewInput convertRect:self.view.bounds toView:self.view].origin;
        self.originBottomTextFiled = point.y + self.viewInput.bounds.size.height;
    }
    // 显示完成的键盘占位信息
    CGRect end = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 除去键盘的剩余空间
    CGFloat overHeight = M_Height - end.size.height;
    //判断遮挡问题
    CGFloat keyboardChangeHeight = overHeight - self.originBottomTextFiled;
    if (keyboardChangeHeight > 0)
        return;
    //    NSLog(@"%.2f", keyboardChangeHeight);
    // 键盘动画时间
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0,  keyboardChangeHeight);
            [self.view layoutIfNeeded];
        }];
    });
}

- (void)keyboardWillHide:(NSNotification *)notification {
    // 键盘动画时间
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformIdentity;
            [self.view layoutIfNeeded];
        }];
    });
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
    [self btnSendMsgClick:nil];
    return YES;
}
@end
