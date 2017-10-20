//
//  HXDrawView_S.h
//  test
//
//  Created by 孙海平 on 2017/4/19.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HXSubFileEntity.h"
#import "HXAnnotationBaseEntity.h"

@protocol HXDrawViewAnnotationDelegate;

@interface HXDrawView_S : UIView

@property (nonatomic, weak) id <HXDrawViewAnnotationDelegate> annotationDelegate;

//@property (nonatomic, strong)HXSubFileEntity * subFileEntity;

@property (nonatomic, strong)NSMutableArray<HXAnnotationBaseEntity *> * annotationArrM;

@property (nonatomic, strong)NSString * pid;


/**
 取消选中
 */
- (void)annotationUncheck;

/**
 上一步
 */
- (void)previousAction;

/**
 下一步
 */
- (void)nextAction;
@end

@protocol HXDrawViewAnnotationDelegate <NSObject>
@optional

/**
 添加注释代理
 @param annotationEntityArr 注释实体
 */
- (void)drawView:(HXDrawView_S *)drawView addAnnotation:(NSArray<HXAnnotationBaseEntity *>*)annotationEntityArr;
/**
 编辑注释代理
 @param annotationEntity 注释实体
 */
- (void)drawView:(HXDrawView_S *)drawView editorAnnotation:(HXAnnotationBaseEntity *)annotationEntity;
/**
 删除注释代理
 @param annotationEntityArr 注释实体
 */
- (void)drawView:(HXDrawView_S *)drawView removeAnnotation:(NSArray<HXAnnotationBaseEntity *>*)annotationEntityArr;
/**
 撤销按钮改变状态代理
 */
- (void)drawView:(HXDrawView_S *)drawView changePreviousBtnstate:(BOOL)is;

- (void)drawView:(HXDrawView_S *)drawView changeNextBtnstate:(BOOL)is;

/**
 是否可以响应手势
 */
- (void)canCallGesture:(BOOL)isCan;

@end
