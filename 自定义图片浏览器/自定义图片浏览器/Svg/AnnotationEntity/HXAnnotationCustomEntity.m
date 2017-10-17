//
//  HXAnnotationCustomEntity.m
//  test
//
//  Created by 孙海平 on 2017/4/26.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXAnnotationCustomEntity.h"

@interface HXAnnotationCustomEntity ()


@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@end

@implementation HXAnnotationCustomEntity
- (instancetype)initWithSvgEntity:(HXSVGEntity *)svgEntity andWidth:(CGFloat)width andHeight:(CGFloat)height
{
    self = [super initWithSvgEntity:svgEntity andWidth:width andHeight:height];
    
    NSArray * pointArr = [svgEntity.ps componentsSeparatedByString:@";"];
    
    for (int i = 0; i < pointArr.count; i++) {
        NSString * pointStr = pointArr[i];
        NSArray * tempArr = [pointStr componentsSeparatedByString:@","];
        
        CGPoint point = CGPointMake([[tempArr firstObject] floatValue]*self.width/TEMPFLOAT, [[tempArr lastObject] floatValue]*self.height/TEMPFLOAT);
        [self addPointToPointArrWithPoint:point];
        [self getPointMaximumOrMinimumWihtPoint:point];
        
    }
    return self;
}
#pragma mark get/set
- (CGFloat)minX
{
    if (!_minX) {
        _minX = self.startPoint.x;
    }
    return _minX;
}
- (CGFloat)minY
{
    if (!_minY) {
        _minY = self.startPoint.y;
    }
    return _minY;
}
- (CGFloat)maxX
{
    if (!_maxX) {
        _maxX = self.startPoint.x;
    }
    return _maxX;
}
- (CGFloat)maxY
{
    if (!_maxY) {
        _maxY = self.startPoint.y;
    }
    return _maxY;
}
- (NSMutableArray *)pointArr
{
    if (!_pointArr) {
        _pointArr = [NSMutableArray array];
    }
    return _pointArr;
}
- (NSArray *)allPointArr
{
    NSMutableArray * tempArr = [NSMutableArray array];
    int tempsXP = self.startPoint.x/self.width*TEMPFLOAT;
    int tempsYP = self.startPoint.y/self.height*TEMPFLOAT;
    [tempArr addObject:[NSString stringWithFormat:@"%d,%d",tempsXP,tempsYP]];
    
    for (NSDictionary * point in _pointArr) {
        int tempPXP = [point[@"x"] floatValue]/self.width*TEMPFLOAT;
        int tempPYP = [point[@"y"] floatValue]/self.height*TEMPFLOAT;
        NSString * tempStr = [NSString stringWithFormat:@"%d,%d",tempPXP,tempPYP];
        [tempArr addObject:tempStr];
    }
    return [NSArray arrayWithArray:tempArr];
}
#pragma mark 画注释
- (void)drawAnnotaiton
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    for (NSDictionary * dic  in self.pointArr) {
        NSString * xN = [dic objectForKey:@"x"];
        NSString * yN = [dic objectForKey:@"y"];
        CGPoint point = CGPointMake([xN floatValue], [yN floatValue]);
        [path addLineToPoint:point];
    }
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
    [self drawOtherPoint];
    [self drawStartPointAndEndPoint];
}
- (CGRect)selectedStartMinRect
{
    CGFloat x = self.minX - MINRABIUS;
    CGFloat y = self.minY - MINRABIUS;
    return CGRectMake(x, y, MINRABIUS*2, MINRABIUS*2);
}
- (CGRect)selectedStartMaxRect
{
    CGFloat x = self.minX - MAXRABIUS;
    CGFloat y = self.minY - MAXRABIUS;
    return CGRectMake(x, y, MAXRABIUS*2, MAXRABIUS*2);
}
- (CGRect)selectedEndMinRect
{
    CGFloat x = self.maxX - MINRABIUS;
    CGFloat y = self.maxY - MINRABIUS;
    return CGRectMake(x, y, MINRABIUS*2, MINRABIUS*2);
}
- (CGRect)selectedEndMaxRect
{
    CGFloat x = self.maxX - MAXRABIUS;
    CGFloat y = self.maxY - MAXRABIUS;
    return CGRectMake(x, y, MAXRABIUS*2, MAXRABIUS*2);
}
- (CGRect)selectedTopMinRect
{
    CGFloat x = self.selectedEndMinRect.origin.x;
    CGFloat y = self.selectedStartMinRect.origin.y;
    return CGRectMake(x, y, MINRABIUS*2, MINRABIUS*2);
}
- (CGRect)selectedTopMaxRect
{
    CGFloat x = self.selectedEndMaxRect.origin.x;
    CGFloat y = self.selectedStartMaxRect.origin.y;
    return CGRectMake(x, y, MAXRABIUS*2, MAXRABIUS*2);
}
- (CGRect)selectedBottomMinRect
{
    CGFloat x = self.selectedStartMinRect.origin.x;
    CGFloat y = self.selectedEndMinRect.origin.y ;
    return CGRectMake(x, y, MINRABIUS*2, MINRABIUS*2);
}
- (CGRect)selectedBottomMaxRect
{
    CGFloat x = self.selectedStartMaxRect.origin.x;
    CGFloat y = self.selectedEndMaxRect.origin.y;
    return CGRectMake(x, y, MAXRABIUS*2, MAXRABIUS*2);
}

- (BOOL)whetherInTheCurrentScopeWithPoint:(CGPoint)point
{
    CGRect rect = CGRectMake(self.minX, self.minY, self.maxX-self.minX, self.maxY-self.minY);
    if (self.isSelected) {
        return CGRectContainsPoint(rect, point);
    }else{
        self.isSelected = CGRectContainsPoint(rect, point);
        self.isMoved = !self.isSelected;
        return self.isSelected;
    }
}
- (void)moveOneselfWithPoint:(CGPoint)point
{
    CGFloat a = point.x - self.tempPoint.x;
    CGFloat b = point.y - self.tempPoint.y;
    self.startPoint = CGPointMake(self.startPoint.x + a, self.startPoint.y + b);
    self.minX = self.startPoint.x;
    self.minY = self.startPoint.y;
    self.maxX = self.startPoint.x;
    self.maxY = self.startPoint.y;
    for (NSMutableDictionary * dic  in self.pointArr) {
        CGFloat tempX = [dic[@"x"] floatValue];
        CGFloat tempY = [dic[@"y"] floatValue];
        
        NSString * numX = [NSString stringWithFormat:@"%f",tempX + a];
        NSString * numY = [NSString stringWithFormat:@"%f",tempY + b];
        [dic setValue:numX forKey:@"x"];
        [dic setValue:numY forKey:@"y"];
        [self getPointMaximumOrMinimumWihtPoint:CGPointMake(tempX, tempY)];
    }
    self.endPoint = CGPointMake(self.endPoint.x + (point.x - self.tempPoint.x), self.endPoint.y + (point.y - self.tempPoint.y));
    [self getPointMaximumOrMinimumWihtPoint:self.endPoint];
}
#pragma mark 移动事件
- (void)touchesMovedWithPoint:(CGPoint)point{
    
    if (self.isSelected){
        
        if (self.isMoved) {
            [self moveOneselfWithPoint:point];
        }else{
            self.isMoved = YES;
        }
        
    }else{
        
        [self getPointMaximumOrMinimumWihtPoint:point];
        self.endPoint = point;
        [self addPointToPointArrWithPoint:point];
    }
}
- (void)getPointMaximumOrMinimumWihtPoint:(CGPoint)point
{
    self.minX = self.minX<point.x?self.minX:point.x;
    self.minY = self.minY<point.y?self.minY:point.y;
    self.maxX = self.maxX>point.x?self.maxX:point.x;
    self.maxY = self.maxY>point.y?self.maxY:point.y;
}

- (void)addPointToPointArrWithPoint:(CGPoint)point
{
    NSString * numX = [NSString stringWithFormat:@"%f",point.x];
    NSString * numY = [NSString stringWithFormat:@"%f",point.y];
    NSMutableDictionary * pointDic = [NSMutableDictionary dictionary];
    [pointDic setObject:numX forKey:@"x"];
    [pointDic setObject:numY forKey:@"y"];
    [self.pointArr addObject:pointDic];
}
@end
