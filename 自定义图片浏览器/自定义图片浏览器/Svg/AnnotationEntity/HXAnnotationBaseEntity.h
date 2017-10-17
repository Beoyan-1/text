//
//  HXAnnotationBaseEntity.h
//  test
//
//  Created by 孙海平 on 2017/4/19.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXAnnotationMode.h"
#import "HXSVGEntity.h"

#define RectangularSpacing 8 //大范围与小范围间距
#define MINRABIUS self.lineWidth*1.3
#define MAXRABIUS self.lineWidth*1.6
#define TEMPFLOAT 10000


static inline CGFloat XWLengthOfTwoPoint(CGPoint point1, CGPoint point2){
    return sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2));
}
typedef enum {
    HXSelectedPointTypeStart=0,//开始点
    HXSelectedPointTypeEnd,//结束点
    HXSelectedPointTypeTop,//与开始平行点
    HXSelectedPointTypeBottom,//与结束平行点
} HXSelectedPointType;

@interface HXAnnotationBaseEntity : NSObject

/**
 判断是否要移动
 */
@property (nonatomic, assign) BOOL isMoved;

/**
 文件本身ID
 */
@property (nonatomic, strong) NSString * pid;

/**
 唯一ID
 */
@property (nonatomic, strong) NSString * nid;

/**
 SVG类型
 */
@property (nonatomic, assign) HXAnnotationModeType type;

/**
 线段宽度
 */
@property (nonatomic, strong) NSString * lwP;

/**
 建立人ID
 */
@property (nonatomic, strong) NSString * userid;

@property (nonatomic, strong) NSArray * allPointArr;

//@property (nonatomic, strong) NSArray * httpContentArr;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UIColor * color;

/**
 线段宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 开始点
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 结束点
 */
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) CGRect rect;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isSelectedPoint;

@property (nonatomic, assign) CGPoint tempPoint;

@property (nonatomic, assign) BOOL isOne;

@property (nonatomic, assign) HXSelectedPointType selectedPointType;

@property (nonatomic, assign, readonly) CGRect selectedStartMinRect;
@property (nonatomic, assign, readonly) CGRect selectedStartMaxRect;
@property (nonatomic, assign, readonly) CGRect selectedEndMinRect;
@property (nonatomic, assign, readonly) CGRect selectedEndMaxRect;
@property (nonatomic, assign, readonly) CGRect selectedTopMinRect;
@property (nonatomic, assign, readonly) CGRect selectedTopMaxRect;
@property (nonatomic, assign, readonly) CGRect selectedBottomMinRect;
@property (nonatomic, assign, readonly) CGRect selectedBottomMaxRect;

@property (nonatomic, assign, readonly) CGRect didSelectedStartMaxRect;
@property (nonatomic, assign, readonly) CGRect didSelectedEndMaxRect;
@property (nonatomic, assign, readonly) CGRect didSelectedTopMaxRect;
@property (nonatomic, assign, readonly) CGRect didSelectedBottomMaxRect;

@property (nonatomic, strong, readonly) UIColor * selectedColor;
@property (nonatomic, assign, readonly) CGFloat selectedLineWidth;


- (instancetype)initWithMode:(HXAnnotationMode *)mode;
- (instancetype)initWithAnnotationEntity:(HXAnnotationBaseEntity *)entity;
- (instancetype)initWithSvgEntity:(HXSVGEntity *)svgEntity andWidth:(CGFloat)width andHeight:(CGFloat)height;
/**
 判断点击点是否在范围内

 @param point 当前点击的点
 @return 返回YES/NO
 */
- (BOOL)whetherInTheCurrentScopeWithPoint:(CGPoint)point;
/**
 判断点击点是否在关键点上

 @param point 返回YES/NO
 */
- (void)whetherInTheCurrentPointWithPoint:(CGPoint)point;
/**
 移动自身

 @param point 当前点
 */
- (void)moveOneselfWithPoint:(CGPoint)point;

- (void)changeOneselfWithPoint:(CGPoint)point;

#pragma mark touch事件
- (void)touchesMovedWithPoint:(CGPoint)point;
- (void)touchesEndedWithPoing:(CGPoint)point;
#pragma mark 画注释
/**
 画注释
 */
- (void)drawAnnotaiton;
#pragma mark 选中
/**
 选中
 */
- (void)didSelected;
#pragma mark 绘制选中起点终点
/**
 绘制选中起点终点
 */
- (void)drawStartPointAndEndPoint;
#pragma mark 绘制选中其他关键点
/**
 绘制选中其他关键点
 */
- (void)drawOtherPoint;
#pragma mark 计算点击大范围
/**
 计算点击大范围
 */
- (CGRect)calculateMaxScope;
#pragma mark 计算点击小范围
/**
 计算点击小范围
 */
- (CGRect)calculateMinScope;

@end
