//
//  SeeUserPageVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "SeeUserPageVC.h"
#import "SeeUserPageTVC.h"

@interface SeeUserPageVC()
/// 内容控制器
@property (nonatomic, weak) SeeUserPageTVC *tvc;
@end
@implementation SeeUserPageVC

+ (void)displayWithViewController:(UIViewController *)VC
                           userId:(NSString *)userId {
    SeeUserPageVC *See = [UIStoryboard storyboardWithName:@"SeeUserPage" bundle:VC.nibBundle].instantiateInitialViewController;
    See.userId = userId;
    [VC.navigationController pushViewController:See animated:YES];
}

#pragma mark - 视图加载
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // ShowBtnEvents(NO);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ModelUser accountColor];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SeeUserPageTVCSegue"]) {
        self.tvc = segue.destinationViewController;
        self.tvc.userId = self.userId; 
    }
}

@end
