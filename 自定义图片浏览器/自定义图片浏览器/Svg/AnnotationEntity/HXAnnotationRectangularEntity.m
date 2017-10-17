//
//  HXAnnotationRectangularEntity.m
//  test
//
//  Created by 孙海平 on 2017/4/20.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXAnnotationRectangularEntity.h"

#import "HXAnnotationMode.h"



@interface HXAnnotationRectangularEntity ()


@end

@implementation HXAnnotationRectangularEntity

- (CGRect)rect
{
    return CGRectMake(self.startPoint.x, self.startPoint.y, self.endPoint.x - self.startPoint.x, self.endPoint.y - self.startPoint.y);
}
#pragma mark 计算点击小范围
- (CGRect)calculateMinScope
{
    CGRect maxRect = [self calculateMaxScope];
    CGFloat x = maxRect.origin.x +RectangularSpacing*2;
    CGFloat y = maxRect.origin.y +RectangularSpacing*2;
    CGFloat w = maxRect.size.width - RectangularSpacing*4;
    CGFloat h = maxRect.size.height - RectangularSpacing*4;
    CGRect temp =CGRectMake(x, y, w, h);
    return temp;
}
#pragma mark 画注释
- (void)drawAnnotaiton
{
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:self.rect];
    [self.color setStroke];
    [path setLineWidth:self.lineWidth];
    [path stroke];
    if (self.isSelected) {
        [self didSelected];
    }
}
#pragma mark 选中事件
- (void)didSelected
{
    [self drawOtherPoint];
    [self drawStartPointAndEndPoint];
}
@end
