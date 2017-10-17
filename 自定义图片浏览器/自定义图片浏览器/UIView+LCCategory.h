//
//  UIView+LCCategory.h
//  test
//
//  Created by 孙海平 on 16/5/20.
//  Copyright © 2016年 孙海平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCCategory)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/



/**
 设置圆角
 */
- (void)setRoundedCorners;

@end
