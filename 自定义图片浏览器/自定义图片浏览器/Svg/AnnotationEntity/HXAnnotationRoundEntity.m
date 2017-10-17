//
//  HXAnnotationRoundEntity.m
//  test
//
//  Created by 孙海平 on 2017/4/20.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXAnnotationRoundEntity.h"

@implementation HXAnnotationRoundEntity
- (CGRect)rect
{
    return CGRectMake(self.startPoint.x, self.startPoint.y, self.endPoint.x - self.startPoint.x, self.endPoint.y - self.startPoint.y);
}

#pragma mark 画注释
- (void)drawAnnotaiton
{
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:self.rect];
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
#pragma mark 计算点击小范围
- (CGRect)calculateMinScope
{    
    CGRect maxRect = [self calculateMaxScope];
    CGFloat tempW = maxRect.size.width/2;
    CGFloat tempH = maxRect.size.height/2;
    CGRect tempMaxRect = CGRectMake(maxRect.origin.x, maxRect.origin.y, tempW, tempH);
    CGFloat tempX = CGRectGetMidX(tempMaxRect);
    CGFloat tempY = CGRectGetMidY(tempMaxRect);
    return CGRectMake(tempX, tempY, tempW, tempH);
}

@end
