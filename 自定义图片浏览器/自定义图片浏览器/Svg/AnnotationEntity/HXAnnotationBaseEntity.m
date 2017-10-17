//
//  HXAnnotationBaseEntity.m
//  test
//
//  Created by 孙海平 on 2017/4/19.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXAnnotationBaseEntity.h"
#import "UIColor+LCCategory.h"
@implementation HXAnnotationBaseEntity
#pragma mark init
- (instancetype)initWithMode:(HXAnnotationMode *)mode
{
    if (self == [super init]) {
        _type = mode.type;
        _color = mode.color;
        _lineWidth = mode.lineWidth;
        _startPoint = mode.startPoint;
        _endPoint = mode.endPoint;
        _height = mode.height;
        _width = mode.width;
        _pid = mode.pid;
        CFUUIDRef uuidRef =CFUUIDCreate(NULL);
        CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        _nid = (__bridge NSString *)(uuidStringRef);
//        _userid = USERID;
    }
    return self;
}
- (instancetype)initWithSvgEntity:(HXSVGEntity *)svgEntity andWidth:(CGFloat)width andHeight:(CGFloat)height
{
    if (self == [super init]) {
        _pid = svgEntity.pid;
        _nid = svgEntity.nid;
        _type = [svgEntity.tp intValue];
        _color = [UIColor colorWithHexString:svgEntity.cl];
        _width = width;
        _height = height;
        _lineWidth = [svgEntity.lw floatValue]*width;
        _userid = svgEntity.userid;
        
        NSArray * pointArr = [svgEntity.ps componentsSeparatedByString:@";"];
        NSString * pointStrS = [pointArr firstObject];
        NSArray * pointStrSarr = [pointStrS componentsSeparatedByString:@","];
        NSString * pointStrE = [pointArr lastObject];
        NSArray * pointStrEarr = [pointStrE componentsSeparatedByString:@","];;
        self.startPoint = CGPointMake([[pointStrSarr firstObject] floatValue]/TEMPFLOAT*_width, [[pointStrSarr lastObject] floatValue]/TEMPFLOAT*_height);
        self.endPoint = CGPointMake([[pointStrEarr firstObject] floatValue]/TEMPFLOAT*_width, [[pointStrEarr lastObject] floatValue]/TEMPFLOAT*_height);
    }
    return self;
}
- (instancetype)initWithAnnotationEntity:(HXAnnotationBaseEntity *)entity
{
    if (self == [super init]) {
        _pid = entity.pid;
        _nid = entity.nid;
        _type = entity.type;
        _color = entity.color;
        _width = entity.width;
        _height = entity.height;
        _lineWidth = entity.lineWidth;
        _userid = entity.userid;
        _startPoint = entity.startPoint;
        _endPoint = entity.endPoint;
        _isSelected = entity.isSelected;
        _isSelectedPoint = entity.isSelectedPoint;
        
    }
    return self;
}
#pragma mark 线宽比例
- (NSString *)lwP
{
    return [NSString stringWithFormat:@"%f",self.lineWidth/self.width];
}
#pragma mark 所有点集合
- (NSArray *)allPointArr
{
    //起点比例
    CGFloat tempSX = _startPoint.x;
    CGFloat tempSY = _startPoint.y;
    int tempSXP = tempSX/self.width*TEMPFLOAT;
    int tempSYP = tempSY/self.height*TEMPFLOAT;
    //终点比例
    CGFloat tempEX = _endPoint.x;
    CGFloat tempEY = _endPoint.y;
    int tempEXP = tempEX/self.width*TEMPFLOAT;
    int tempEYP = tempEY/self.height*TEMPFLOAT;
    
    NSString * tempSP = [NSString stringWithFormat:@"%d,%d",tempSXP,tempSYP];
    NSString * tempEP = [NSString stringWithFormat:@"%d,%d",tempEXP,tempEYP];
    return @[tempSP,tempEP];
}
/**************************   绘制  ***************************/
#pragma mark 绘制选中点的rect
- (CGRect)selectedStartMinRect
{
    CGFloat x = _startPoint.x - MINRABIUS;
    CGFloat y = _startPoint.y - MINRABIUS;
    return CGRectMake(x, y, MINRABIUS*2, MINRABIUS*2);
}
- (CGRect)selectedStartMaxRect
{
    CGFloat x = _startPoint.x - MAXRABIUS;
    CGFloat y = _startPoint.y - MAXRABIUS;
    return CGRectMake(x, y, MAXRABIUS*2, MAXRABIUS*2);
}
- (CGRect)selectedEndMinRect
{
    CGFloat x = _endPoint.x - MINRABIUS;
    CGFloat y = _endPoint.y - MINRABIUS;
    return CGRectMake(x, y, MINRABIUS*2, MINRABIUS*2);
}
- (CGRect)selectedEndMaxRect
{
    CGFloat x = _endPoint.x - MAXRABIUS;
    CGFloat y = _endPoint.y - MAXRABIUS;
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
- (UIColor *)selectedColor
{
    return RGB_COLOR(0, 0, 255, 0.7);
}
- (CGFloat)selectedLineWidth
{
    return 1;
}
#pragma mark 绘制选中起点终点
- (void)drawStartPointAndEndPoint
{
    UIBezierPath * startMinPath = [UIBezierPath bezierPathWithOvalInRect:self.selectedStartMinRect];
    [self.selectedColor setFill];
    [startMinPath setLineWidth:self.selectedLineWidth];
    [startMinPath fill];
    
    UIBezierPath * startMaxPath = [UIBezierPath bezierPathWithOvalInRect:self.selectedStartMaxRect];
    [self.selectedColor setStroke];
    [startMaxPath setLineWidth:self.selectedLineWidth];
    [startMaxPath stroke];
    
    UIBezierPath * endMinPath = [UIBezierPath bezierPathWithOvalInRect:self.selectedEndMinRect];
    [self.selectedColor setFill];
    [endMinPath setLineWidth:self.selectedLineWidth];
    [endMinPath fill];
    
    UIBezierPath * endMaxPath = [UIBezierPath bezierPathWithOvalInRect:self.selectedEndMaxRect];
    [self.selectedColor setStroke];
    [endMaxPath setLineWidth:self.selectedLineWidth];
    [endMaxPath stroke];
}
#pragma mark 绘制选中其他关键点
- (void)drawOtherPoint
{
    UIBezierPath * topMinPath = [UIBezierPath bezierPathWithOvalInRect:self.selectedTopMinRect];
    [self.selectedColor setFill];
    [topMinPath setLineWidth:self.selectedLineWidth];
    [topMinPath fill];
    
    UIBezierPath * topMaxPath = [UIBezierPath bezierPathWithOvalInRect:self.selectedTopMaxRect];
    [self.selectedColor setStroke];
    [topMaxPath setLineWidth:self.selectedLineWidth];
    [topMaxPath stroke];
    
    UIBezierPath * bottomMinPath = [UIBezierPath bezierPathWithOvalInRect:self.selectedBottomMinRect];
    [self.selectedColor setFill];
    [bottomMinPath setLineWidth:self.selectedLineWidth];
    [bottomMinPath fill];
    
    UIBezierPath * bottomMaxPath = [UIBezierPath bezierPathWithOvalInRect:self.selectedBottomMaxRect];
    [self.selectedColor setStroke];
    [bottomMaxPath setLineWidth:self.selectedLineWidth];
    [bottomMaxPath stroke];
    
}
/**************************   判断点击范围  ***************************/
#pragma mark 用于判断点击点是否在rect内
- (CGRect)didSelectedStartMaxRect
{
    return CGRectMake(self.selectedStartMaxRect.origin.x - RectangularSpacing, self.selectedStartMaxRect.origin.y -RectangularSpacing, self.selectedStartMaxRect.size.width +RectangularSpacing*2, self.selectedStartMaxRect.size.height+RectangularSpacing*2);
}
- (CGRect)didSelectedEndMaxRect
{
    return CGRectMake(self.selectedEndMaxRect.origin.x - RectangularSpacing, self.selectedEndMaxRect.origin.y -RectangularSpacing, self.selectedEndMaxRect.size.width +RectangularSpacing*2, self.selectedEndMaxRect.size.height+RectangularSpacing*2);
}
- (CGRect)didSelectedTopMaxRect
{
    return CGRectMake(self.selectedTopMaxRect.origin.x - RectangularSpacing, self.selectedTopMaxRect.origin.y -RectangularSpacing, self.selectedTopMaxRect.size.width +RectangularSpacing*2, self.selectedTopMaxRect.size.height+RectangularSpacing*2);
}
- (CGRect)didSelectedBottomMaxRect
{
    return CGRectMake(self.selectedBottomMaxRect.origin.x - RectangularSpacing, self.selectedBottomMaxRect.origin.y -RectangularSpacing, self.selectedBottomMaxRect.size.width +RectangularSpacing*2, self.selectedBottomMaxRect.size.height+RectangularSpacing*2);
}
#pragma mark 判定是否在关键点的范围
- (void)whetherInTheCurrentPointWithPoint:(CGPoint)point;
{
    self.isSelectedPoint = YES;
    self.isOne = NO;
    if (CGRectContainsPoint(self.didSelectedStartMaxRect, point)) {
        self.selectedPointType = HXSelectedPointTypeStart;
    }else if (CGRectContainsPoint(self.didSelectedEndMaxRect, point)){
        self.selectedPointType = HXSelectedPointTypeEnd;
    }else if (CGRectContainsPoint(self.didSelectedTopMaxRect, point)){
        self.selectedPointType = HXSelectedPointTypeTop;
    }else if (CGRectContainsPoint(self.didSelectedBottomMaxRect, point)){
        self.selectedPointType = HXSelectedPointTypeBottom;
    }else{
        self.isSelectedPoint = NO;
    }
    LCLog(@"选中点 = %d",self.isSelectedPoint);
}
#pragma mark 判定是否在SVG范围
- (BOOL)whetherInTheCurrentScopeWithPoint:(CGPoint)point
{
    [self whetherInTheCurrentPointWithPoint:point];
    //大范围
    CGRect maxRect = [self calculateMaxScope];
    //小范围
    CGRect minRect = [self calculateMinScope];
    //判断是否已经被选中
    if (self.isSelected) {
        //判断是否被选中
        return CGRectContainsPoint(maxRect, point);
    }else{
        //判断是否被选中
        if ((CGRectContainsPoint(maxRect, point)) && !(CGRectContainsPoint(minRect, point)))
        {   //判断是否选中
            self.isSelected = YES;
            self.isMoved = NO;
        }else{
            self.isSelected = NO;
        }
        return self.isSelected;
    }
}
#pragma mark 计算点击大范围
- (CGRect)calculateMaxScope
{
    CGRect maxRect;
    if (self.startPoint.x<self.endPoint.x &&
        self.startPoint.y<self.endPoint.y) {//右下
        //大范围
        CGFloat tempMaxX = self.startPoint.x - RectangularSpacing;
        CGFloat tempMaxY = self.startPoint.y - RectangularSpacing;
        maxRect = CGRectMake(tempMaxX, tempMaxY, self.rect.size.width + RectangularSpacing*2, self.rect.size.height + RectangularSpacing*2);
    }else if (self.startPoint.x<self.endPoint.x &&
              self.startPoint.y>self.endPoint.y){//右上
        CGFloat tempMaxX = self.startPoint.x - RectangularSpacing;
        CGFloat tempMaxY = self.endPoint.y - RectangularSpacing;
        CGFloat tempMaxW = (self.endPoint.x - self.startPoint.x) + RectangularSpacing*2;
        CGFloat tempMaxH = (self.startPoint.y - self.endPoint.y) +RectangularSpacing*2;
        maxRect = CGRectMake(tempMaxX, tempMaxY, tempMaxW,tempMaxH);
    }else if (self.startPoint.x>self.endPoint.x &&
              self.startPoint.y<self.endPoint.y){//左下
        CGFloat tempMaxX = self.endPoint.x - RectangularSpacing;
        CGFloat tempMaxY = self.startPoint.y - RectangularSpacing;
        CGFloat tempMaxW = (self.startPoint.x - self.endPoint.x) + RectangularSpacing*2;
        CGFloat tempMaxH = (self.endPoint.y - self.startPoint.y) +RectangularSpacing*2;
        maxRect = CGRectMake(tempMaxX, tempMaxY, tempMaxW,tempMaxH);
    }else if (self.startPoint.x>self.endPoint.x &&
              self.startPoint.y>self.endPoint.y){//左上
        CGFloat tempMaxX = self.endPoint.x - RectangularSpacing;
        CGFloat tempMaxY = self.endPoint.y - RectangularSpacing;
        CGFloat tempMaxW = (self.startPoint.x - self.endPoint.x) + RectangularSpacing*2;
        CGFloat tempMaxH = (self.startPoint.y - self.endPoint.y) +RectangularSpacing*2;
        maxRect = CGRectMake(tempMaxX, tempMaxY, tempMaxW,tempMaxH);
    }
    return maxRect;
}
/**************************   事件  ***************************/
#pragma mark 移动事件
- (void)touchesMovedWithPoint:(CGPoint)point
{
    if (self.isSelectedPoint) {
        LCLog(@"已经选中点");
        [self changeOneselfWithPoint:point];
    }else if (self.isSelected){
        if (_isMoved) {
            [self moveOneselfWithPoint:point];
        }else{
            _isMoved = YES;
        }
    }else{
        self.endPoint = point;
    }
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
        case HXSelectedPointTypeTop:
        {
            if (!self.isOne) {
                self.startPoint = CGPointMake(self.startPoint.x, self.endPoint.y);
                self.isOne = YES;
            }
            self.endPoint = point;
            LCLog(@"已经选中top点");
            break;
        }
        case HXSelectedPointTypeBottom:
        {
            if (!self.isOne) {
                self.startPoint = CGPointMake(self.endPoint.x, self.startPoint.y);
                self.isOne = YES;
            }
            self.endPoint = point;
            LCLog(@"已经选中bottom点");
            break;
        }
    }
}
#pragma mark 移动注释
- (void)moveOneselfWithPoint:(CGPoint)point
{
    
    self.startPoint = CGPointMake(self.startPoint.x + (point.x - self.tempPoint.x), self.startPoint.y + (point.y - self.tempPoint.y));
    self.endPoint = CGPointMake(self.endPoint.x + (point.x - self.tempPoint.x), self.endPoint.y + (point.y - self.tempPoint.y));
}
@end
