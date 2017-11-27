//
//  DiscoverCVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "DiscoverCVC.h"
#import "DiscoverTopTypeCVC.h"
#import "DiscoverCVCFlowLayout.h"
#import "DiscoverTypeCell.h"
#import "DiscoverWhatNewCell.h"
#import "DiscoverActivityCell.h"
#import "DiscoverSearchResultCell.h"
#import "ViewEventVC.h"
#import "ServiceDiscover.h"
#import "MJRefresh.h"

@interface DiscoverCVC () <UICollectionViewDelegateFlowLayout>
/// 界面控制器
@property (nonatomic, strong) DiscoverTopTypeCVC *topTypeCVC;
@end

@implementation DiscoverCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 去除顶部预留空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    // 注册Cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TopType"];
    [self registerCellNibName:@"DiscoverWhatNewCell"];
    [self registerCellNibName:@"DiscoverActivityCell"];
    [self registerCellNibName:@"DiscoverSearchResultCell"];
    // 初始化CVC
    [self initTopTypeCVC];
    
    [self requestCategoryId:nil
                     search:nil
                clearEvents:YES];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaer)];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
}
- (void)registerCellNibName:(NSString *)name {
    [self.collectionView registerNib:[UINib nibWithNibName:name bundle:self.nibBundle] forCellWithReuseIdentifier:name];
}
- (void)setShowSearchResult:(BOOL)showSearchResult {
    _showSearchResult = showSearchResult;
    [self.collectionView reloadData];
}

#pragma mark - 数据请求
- (ModelPage *)page {
    if (!_page) {
        _page = [ModelPage firstPage];
    }
    return _page;
}
- (void)refreshHeaer { 
    self.page.page_current = 1;
    // 刷新数据
    [self requestCategoryId:self.currentCategoryId
                     search:self.currentSearchStr
                clearEvents:NO];
    // 刷新类别
    [self.topTypeCVC requestData];
}
- (void)refreshFooter {
    self.page.page_current ++;
    [self requestCategoryId:self.currentCategoryId
                     search:self.currentSearchStr
                clearEvents:NO];
}
- (void)requestCategoryId:(NSString *)cid
                   search:(NSString *)search
              clearEvents:(BOOL)clear {
    if (clear) {
        self.events = [NSMutableArray array];
        [self.collectionView reloadData];
    } 
    self.currentCategoryId = M_CheckStrNil(cid);
    self.currentSearchStr = M_CheckStrNil(search);
    NSLog(@"筛选条件：Category：%@， keyword：%@", self.currentCategoryId, self.currentSearchStr);
    [ServiceDiscover getEventList:self.page categoryId:cid search:search success:^(NSArray<ModelEvent *> *list) {
        [self.collectionView.mj_header endRefreshing];
        if (list.count == 0)
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        else
            [self.collectionView.mj_footer endRefreshing];
        
        [list enumerateObjectsUsingBlock:^(ModelEvent *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            __block BOOL check = NO;
            [self.events enumerateObjectsUsingBlock:^(ModelEvent *obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                if ([obj1.id isEqualToString:obj2.id]) {
                    check = YES;
                    [self.events setObject:obj1 atIndexedSubscript:idx2];
                    *stop2 = YES;
                }
            }];
            if (!check)
                [self.events addObject:obj1];
        }];
        
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
    } failure:^{
        
    }];
}

#pragma mark - 初始化CVC
- (void)initTopTypeCVC {
    self.topTypeCVC = [[DiscoverTopTypeCVC alloc] initWithCollectionViewLayout:[[DiscoverCVCFlowLayout alloc] initWithScrollDirection:UICollectionViewScrollDirectionHorizontal]];
    [self addChildViewController:self.topTypeCVC];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        if (self.showSearchResult)
            return 0;
        return 1;
    } else {
        return self.events.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return [self cellTypeForItemAtIndexPath:indexPath];
    else if (indexPath.section == 1)
        return [self cellWhatNewForItemAtIndexPath:indexPath];
    else
        return [self cellActivityForItemAtIndexPath:indexPath];
}

#pragma mark - Cell
- (UICollectionViewCell *)cellTypeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TopType" forIndexPath:indexPath];
    if (cell.contentView.subviews.count == 0) {
        self.topTypeCVC.collectionView.frame = cell.bounds;
        [cell.contentView addSubview:self.topTypeCVC.collectionView];
    }
    return cell;
}
- (DiscoverWhatNewCell *)cellWhatNewForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverWhatNewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"DiscoverWhatNewCell" forIndexPath:indexPath]; 
    return cell;
}
- (UICollectionViewCell *)cellActivityForItemAtIndexPath:(NSIndexPath *)indexPath {
    ModelEvent *event = self.events[indexPath.row];
    if (!self.showSearchResult) {
        DiscoverActivityCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"DiscoverActivityCell" forIndexPath:indexPath]; 
        cell.event = event;
        return cell;
    } else {
        DiscoverSearchResultCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"DiscoverSearchResultCell" forIndexPath:indexPath];
        cell.event = event; 
        return cell;
    }
}

#pragma amrk - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    if (!self.showSearchResult) {
        size = [DiscoverCVCFlowLayout sizeForItemAtIndexPath:indexPath];
    } else {
        size = [DiscoverCVCFlowLayout sizeForSearchResultItemAtIndexPath:indexPath searchResults:self.events];
    }
    return size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets insets = [DiscoverCVCFlowLayout insetForSectionAtIndex:section];
    return insets;
} 

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES]; 
    if (indexPath.section == 2) {
        ModelEvent *model = self.events[indexPath.row];
        [ViewEventVC displayWithViewController:self
                                         event:model];
    }
}

@end
