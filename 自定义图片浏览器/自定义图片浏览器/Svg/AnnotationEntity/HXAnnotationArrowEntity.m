//
//  HXAnnotationArrowEntity.m
//  test
//
//  Created by 孙海平 on 2017/4/26.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXAnnotationArrowEntity.h"

@interface HXAnnotationArrowEntity ()
@property (nonatomic, strong) NSMutableArray * arrowArr;
@end

@implementation HXAnnotationArrowEntity

- (NSMutableArray *)arrowArr
{
    NSMutableArray * tempArr = [NSMutableArray array];
    CGFloat len = sqrt(( self.startPoint.x - self.endPoint.x) * ( self.startPoint.x - self.endPoint.x) + ( self.startPoint.y - self.endPoint.y) * ( self.startPoint.y - self.endPoint.y)) * 0.1;
    
    NSArray * tempArr1 = [self calculateArrowPointWithPointS:self.startPoint PointE:self.endPoint width:len * 0.8 height:len * 0.3];
    
    NSArray * tempArr2 = [self calculateArrowPointWithPointS:self.startPoint PointE:self.endPoint width:len height:len * 0.6];
    
    [tempArr addObject:tempArr1[0]];
    [tempArr addObject:tempArr1[1]];
    [tempArr addObject:tempArr1[2]];
    [tempArr addObject:tempArr1[3]];
    [tempArr addObject:tempArr2[0]];
    [tempArr addObject:tempArr2[1]];
    [tempArr addObject:tempArr2[2]];
    [tempArr addObject:tempArr2[3]];
    
    return [NSMutableArray arrayWithArray:tempArr];
}

-(NSMutableArray *)calculateArrowPointWithPointS:(CGPoint)pointS PointE:(CGPoint)pointE width:(int)width height:(int)height
{
    
    CGFloat x1 = pointS.x;
    CGFloat y1 = pointS.y;
    CGFloat x2 = pointE.x;
    CGFloat y2 = pointE.y;
    
    
    CGFloat len = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    //算出俩点的距离
    //    CGFloat len = sqrt((pointE.x - pointS.x) * (pointE.x - pointS.x) + (pointE.y - pointS.y) * (pointE.y - pointS.y));
    if (len == 0) {
        //        return = nil;
    }
    CGFloat t =(y2 - y1) / (x2 - x1);
    //算出角度
    CGFloat angle = atan(t);
    
    
    CGFloat x,y;
    CGFloat len1 = MIN(width, len - 2);
    CGFloat len2 = MIN(height, len/2 -1);
    
    if (x2 < x1) {
        x = (len1 - len) * cos(angle) + x1;
        y = (len1 - len) * sin(angle) + y1;
    } else if (x2 >= x1) {
        x = (len - len1) * cos(angle) + x1;
        y = (len - len1) * sin(angle) + y1;
    }
    
    CGFloat x3 = x + len2 * sin(angle);
    CGFloat y3 = y - len2 * cos(angle);
    
    CGFloat x4 = x - len2 * sin(angle);
    CGFloat y4 = y + len2 * cos(angle);
    
    NSMutableArray * tempArr = [NSMutableArray array];
    [tempArr addObject:[NSString stringWithFormat:@"%f",x3]];
    [tempArr addObject:[NSString stringWithFormat:@"%f",y3]];
    [tempArr addObject:[NSString stringWithFormat:@"%f",x4]];
    [tempArr addObject:[NSString stringWithFormat:@"%f",y4]];
    return tempArr;
    
}
#pragma mark 画注释
- (void)drawAnnotaiton
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:CGPointMake([self.arrowArr[0] floatValue], [self.arrowArr[1] floatValue])];
    [path addLineToPoint:CGPointMake([self.arrowArr[4] floatValue], [self.arrowArr[5] floatValue])];
    [path addLineToPoint:self.endPoint];
    [path addLineToPoint:CGPointMake([self.arrowArr[6] floatValue], [self.arrowArr[7] floatValue])];
    [path addLineToPoint:CGPointMake([self.arrowArr[2] floatValue], [self.arrowArr[3] floatValue])];
    
    [self.color setFill];
    [path fill];
    if (self.isSelected) {
        [self didSelected];
    }
}
#pragma mark 选中事件
- (void)didSelected
{
    [self drawStartPointAndEndPoint];
}
- (void)changeOneselfWithPoint:(CGPoint)point
{
    switch (self.selectedPointType) {
        case HXSelectedPointTypeStart:
        {
            LCLog(@"已经选中开始点 %d",self.isOne);
            self.startPoint = point;
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
- (BOOL)whetherInTheOnlineWithPoint:(CGPoint)point
{
    //通过直线方程的两点式计算出一般式的ABC参数，具体可以自己拿起笔换算一下，很容易
    CGFloat A = self.endPoint.y - self.startPoint.y;
    CGFloat B = self.startPoint.x - self.endPoint.x;
    CGFloat C = self.endPoint.x * self.startPoint.y - self.startPoint.x * self.endPoint.y;
    //带入点到直线的距离公式求出点到直线的距离dis
    CGFloat dis = fabs((A * point.x + B * point.y + C) / sqrt(pow(A, 2) + pow(B, 2)));
    //如果该距离大于允许值说明则不在线段上
    if (dis > RectangularSpacing*2 || isnan(dis)) {
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
