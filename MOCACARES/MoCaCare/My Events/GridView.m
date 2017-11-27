//
//  GridView.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "GridView.h"

@interface GridView()
/// 贝塞尔曲线
@property (nonatomic, strong) UIBezierPath *path;
/// 列
@property (nonatomic, assign) NSInteger column;
/// 行
@property (nonatomic, assign) NSInteger row;
/// 空白
@property (nonatomic, assign) NSInteger margin;
@end
@implementation GridView

#pragma mark - 实例化
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 绘制网格
- (void)drawGridsWithColumn:(NSInteger)column
                        row:(NSInteger)row {
    CGFloat w_cell = self.bounds.size.width / column;
    CGFloat h_cell = Cell_Height(w_cell);
    [self drawGridsWithColumn:column
                          row:row
                    rowHeight:h_cell];
}

- (void)drawGridsWithColumn:(NSInteger)column
                        row:(NSInteger)row
                  rowHeight:(CGFloat)rowHeight {
    self.column = column;
    self.row = row;
    
    self.path = [UIBezierPath bezierPath];
    self.path.lineCapStyle = kCGLineCapRound;
    self.path.lineWidth = LineWidth;
    
    CGFloat w_cell = self.bounds.size.width / column;
    CGFloat h_cell = rowHeight;
    
    /// 画横线
    for (int i = 0; i <= row; i ++) {
        [self.path moveToPoint:CGPointMake(0, i * h_cell)];
        [self.path addLineToPoint:CGPointMake(w_cell * column, i * h_cell)];
        [self setNeedsDisplay];
    }
    /// 画竖线
    for (int i = 0; i <= column; i ++) {
        [self.path moveToPoint:CGPointMake(i * w_cell, 0)];
        [self.path addLineToPoint:CGPointMake(i * w_cell, h_cell * row)];
        [self setNeedsDisplay];
    }
    self.layer.borderWidth = LineWidth;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

// 重绘
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [[UIColor groupTableViewBackgroundColor] setStroke];
    [self.path stroke];
    [self.path fill];
}

#pragma mark - 添加行程
- (void)addEvent:(NSString *)title
             tag:(NSInteger)tag
      starColumn:(CGFloat)starColumn
       endColumn:(CGFloat)endColumn
      startHours:(CGFloat)startHours
        endHours:(CGFloat)endHours
           color:(UIColor *)color
          target:(id)target
          action:(SEL)action {
    /// 行列开头做成活动唯一标示
    if ([self viewWithTag:tag]) {
        NSLog(@"已存在该活动");
        return;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.tag = tag;
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    btn.backgroundColor = color;
    [btn setTitle:@"" forState:UIControlStateNormal];
    
    CGFloat w_cell = self.bounds.size.width / self.column;
    CGFloat h_cell = Cell_Height(w_cell);
    
    CGFloat w_btn = w_cell;
    
    if (endHours == startHours)
        startHours -= 1;
    if (endColumn == starColumn)
        endColumn ++;
    
    CGFloat h_btn = 2 * h_cell * (endHours - startHours);
    
    btn.frame = CGRectMake(w_cell * starColumn, (startHours - 1) * 2 * h_cell, w_btn * (endColumn - starColumn), h_btn);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:btn.bounds];
    lbl.text = title;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.numberOfLines = 0;;
    [lbl themeFontOfSize:10];
    [btn addSubview:lbl];
} 
@end
