//
//  HXAnnotationRubberEntity.m
//  test
//
//  Created by 孙海平 on 2017/4/26.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXAnnotationRubberEntity.h"

@implementation HXAnnotationRubberEntity
#pragma mark 画注释
- (void)drawAnnotaiton
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:self.endPoint];
    [RGB_COLOR(220, 220, 220, 1) setStroke];
    [path setLineWidth:self.lineWidth];
    [path stroke];
}
#pragma mark 移动事件
- (void)touchesMovedWithPoint:(CGPoint)point
{
    self.endPoint = self.startPoint;
    self.startPoint = point;
}
@end
