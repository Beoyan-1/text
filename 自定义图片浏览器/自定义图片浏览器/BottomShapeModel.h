//
//  BottomShapeModel.h
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/19.
//  Copyright © 2017年 tby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXAnnotationMode.h"

@interface BottomShapeModel : NSObject

@property (nonatomic, assign) HXAnnotationModeType type;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL isSelect;


/**
 当前的图片
 */
@property (nonatomic, copy) NSString * iconNameStr;

- (instancetype)initWithShapeType:(HXAnnotationModeType)type;

@end
