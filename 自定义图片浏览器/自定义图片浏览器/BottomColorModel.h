//
//  BottomColorModel.h
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/19.
//  Copyright © 2017年 tby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXAnnotationMode.h"

@interface BottomColorModel : NSObject

@property (nonatomic, assign) HXAnnotationColorType colorType;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL isSelect;


/**
 当前的颜色
 */
@property (nonatomic, strong) UIColor * color;

- (instancetype)initWithColorType:(HXAnnotationColorType)colorType;

@end
