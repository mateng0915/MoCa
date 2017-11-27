//
//  DiscoverTopTypeCVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverTopTypeCVC : UICollectionViewController <UICollectionViewDelegateFlowLayout>
/// 活动类别
@property (nonatomic, copy) NSArray *categorys;

/** 数据请求 */
- (void)requestData;
@end
