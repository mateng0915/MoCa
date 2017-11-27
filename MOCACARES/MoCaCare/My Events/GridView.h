//
//  GridView.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 线宽
#define LineWidth 1.0
#define GridMargin 4
#define Cell_Height(width) (width * 2.0 / 5.0)

typedef void (^DrawHeaderCompleted)(UIView *header, NSArray<UILabel *> *lbls);
@interface GridView : UIView  

/*
 * 绘制网格
 * @param column :列
 * @param row :行
 */
- (void)drawGridsWithColumn:(NSInteger)column
                        row:(NSInteger)row;
/*
 * 绘制单行网格
 * @param column :列
 * @param row :行
 * @param rowHeight :行高
 */
- (void)drawGridsWithColumn:(NSInteger)column
                        row:(NSInteger)row
                  rowHeight:(CGFloat)rowHeight;

/*
 * 添加事件标签
 * @param title :事件标题
 * @param tag :时间标识
 * @param starColumn :所在列数
 * @param endColumn :所在列数
 * @param startHours :开始时间
 * @param endHours :结束时间
 * @param color :提示颜色
 * @param target :按钮事件管理者
 * @param action :按钮事件
 */
- (void)addEvent:(NSString *)title
             tag:(NSInteger)tag
      starColumn:(CGFloat)starColumn
       endColumn:(CGFloat)endColumn
      startHours:(CGFloat)startHours
        endHours:(CGFloat)endHours
           color:(UIColor *)color
          target:(id)target
          action:(SEL)action;
@end
