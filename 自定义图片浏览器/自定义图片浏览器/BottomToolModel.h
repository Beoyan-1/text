//
//  BottomToolModel.h
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/18.
//  Copyright © 2017年 tby. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXAnnotationMode.h"

typedef enum : NSUInteger {
    svgsettype,         //设置
    svgbrushtype,       //画笔
    svgshapetype,       //形状
    svgcharactertype,   //文字
    svglasertype,       //激光笔
    svgannotationtype,  //注释
} SVGENUM;


@interface BottomToolModel : NSObject


/**
 图标名字
 */
@property (nonatomic, copy) NSString * iconImage;

/**
 描述文字
 */
@property (nonatomic, copy) NSString * descStr;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL isSelect;

/**
 svg 颜色
 */
@property (nonatomic, strong) UIColor * selectColor;

/**
 注释按钮的类型
 */
@property (nonatomic, assign) SVGENUM svgType;

@end
