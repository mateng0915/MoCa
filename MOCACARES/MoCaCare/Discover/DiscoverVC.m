//
//  DiscoverVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "DiscoverVC.h"
#import "DiscoverCVC.h"
#import "DiscoverCVCFlowLayout.h"
#import "DiscoverSearchVC.h"

@interface DiscoverVC ()
/// 内容控制器
@property (nonatomic, strong) DiscoverCVC *discoverCVC;
@end

@implementation DiscoverVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [ModelUser accountColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setSearchString:(NSString *)searchString {
    _searchString = M_CheckStrNil(searchString);
    self.searchBar.text = _searchString;
    if (_searchString) {
        self.discoverCVC.showSearchResult = YES;
    } else {
        self.discoverCVC.showSearchResult = NO;
    }
    [self.discoverCVC requestCategoryId:self.discoverCVC.currentCategoryId
                                 search:searchString
                            clearEvents:YES];
}

#pragma mark - 初始化控件布局
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!self.discoverCVC) { 
        self.discoverCVC = [[DiscoverCVC alloc] initWithCollectionViewLayout:[[DiscoverCVCFlowLayout alloc] initWithScrollDirection:UICollectionViewScrollDirectionVertical]];
        [self addChildViewController:self.discoverCVC];
        [self.viewContent layoutIfNeeded];
        self.discoverCVC.collectionView.frame = self.viewContent.bounds;
        [self.viewContent addSubview:self.discoverCVC.collectionView];
    }
}

#pragma mark - 按钮
- (IBAction)btnSearchClick:(UIButton *)sender {
//    NSLog(@"搜索");
    DiscoverSearchVC *VC = [[UIStoryboard storyboardWithName:@"Discover" bundle:self.nibBundle] instantiateViewControllerWithIdentifier:@"DiscoverSearchVC"];
    VC.discoverVC = self;
    [self.navigationController pushViewController:VC animated:NO];
}
@end
