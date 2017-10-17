//
//  HXAnnotationLineEntity.m
//  test
//
//  Created by 孙海平 on 2017/4/26.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXAnnotationLineEntity.h"

@implementation HXAnnotationLineEntity
#pragma mark 画注释
- (void)drawAnnotaiton
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:self.endPoint];
    
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
    //绘制选中起点终点
    [self drawStartPointAndEndPoint];
}
#pragma mark 改变自身forme
- (void)changeOneselfWithPoint:(CGPoint)point
{ 
    switch (self.selectedPointType) {
        case HXSelectedPointTypeStart:
        {
            LCLog(@"已经选中开始点 %d",self.isOne);
            if (!self.isOne) {
                self.startPoint = self.endPoint;
                self.isOne = YES;
            }
            self.endPoint = point;
            break;
        }
        case HXSelectedPointTypeEnd:
        {
            LCLog(@"已经选中结束点");
            self.endPoint = point;
            break;
        }
        default:
            break;
    }
}
#pragma mark 判定是否在SVG范围
- (BOOL)whetherInTheCurrentScopeWithPoint:(CGPoint)point
{
    [self whetherInTheCurrentPointWithPoint:point];
    if (self.isSelected) {
        return [self whetherInTheOnlineWithPoint:point];
    }else{
        self.isSelected = [self whetherInTheOnlineWithPoint:point];
        return self.isSelected;
    }
    
}
#pragma mark 判定是否在关键点的范围
- (BOOL)whetherInTheOnlineWithPoint:(CGPoint)point
{
    //通过直线方程的两点式计算出一般式的ABC参数，具体可以自己拿起笔换算一下，很容易
    CGFloat A = self.endPoint.y - self.startPoint.y;
    CGFloat B = self.startPoint.x - self.endPoint.x;
    CGFloat C = self.endPoint.x * self.startPoint.y - self.startPoint.x * self.endPoint.y;
    //带入点到直线的距离公式求出点到直线的距离dis
    CGFloat dis = fabs((A * point.x + B * point.y + C) / sqrt(pow(A, 2) + pow(B, 2)));
    //如果该距离大于允许值说明则不在线段上
    if (dis > RectangularSpacing || isnan(dis)) {
        return NO;
    }else{
        //否则我们要进一步判断，投影点是否在线段上，根据公式求出投影点的X坐标jiaoX
        CGFloat D = (A * point.y - B * point.x);
        CGFloat jiaoX = -(A * C + B *D) / (pow(B, 2) + pow(A, 2));
        //判断jiaoX是否在线段上，t如果在0~1之间说明在线段上，大于1则说明不在线段且靠近端点p1，小于0则不在线段上且靠近端点p0，这里用了插值的思想
        CGFloat t = (jiaoX - self.startPoint.x) / (self.endPoint.x - self.startPoint.x);
        if (t > 1  || isnan(t)) {
            //最小距离为到p1点的距离
            dis = XWLengthOfTwoPoint(self.endPoint, point);
        }else if (t < 0){
            //最小距离为到p2点的距离
            dis = XWLengthOfTwoPoint(self.startPoint, point);
        }
        //再次判断真正的最小距离是否小于允许值，小于则该点在直线上，反之则不在
        if (dis <= RectangularSpacing) {
            return YES;
        }else{
            return NO;
        }
    }
}
@end
