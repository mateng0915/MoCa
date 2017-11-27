//
//  NotificationsBubbleView.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "NotificationsBubbleView.h"

@implementation NotificationsBubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor clearColor];
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat arrow = 10.0;
    CGFloat r = 4.0;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 绘制气泡
    CGContextMoveToPoint(ctx, r, 0);
    // 左上圆弧
    CGContextAddArc(ctx, r, r, r, angle(270), angle(180), 1);
    CGContextAddLineToPoint(ctx, 0, h - arrow - r);
    // 左下圆弧
    CGContextAddArc(ctx, r, h - arrow - r, r, angle(180), angle(90), 1);
    // 角标
    CGContextAddLineToPoint(ctx, w - 2 * arrow - r, h - arrow);
    CGContextAddLineToPoint(ctx, w - arrow - r, h);
    CGContextAddLineToPoint(ctx, w - arrow - r, h - arrow);
    CGContextAddLineToPoint(ctx, w - r, h - arrow);
    // 右下圆弧
    CGContextAddArc(ctx, w - r, h - arrow - r, r, angle(90), angle(0), 1);
    CGContextAddLineToPoint(ctx, w, r);
    // 右上圆弧
    CGContextAddArc(ctx, w - r, r, r, angle(0), angle(-90), 1);
    CGContextAddLineToPoint(ctx, r, 0);
    // 填充颜色
    CGContextSetFillColorWithColor(ctx, [UIColor lightGrayColor].CGColor); 
    // 显示路径
    CGContextDrawPath(ctx, kCGPathFill);
}

CGFloat angle(CGFloat angle) {
    CGFloat value = angle / 180.0 * M_PI;
    return value;
}

@end
