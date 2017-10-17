//
//  HXDrawView_S.m
//  test
//
//  Created by 孙海平 on 2017/4/19.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXDrawView_S.h"

#import "HXAnnotationMode.h"
#import "HXAnnotationBaseEntity.h"
#import "HXAnnotationLineEntity.h"
#import "HXAnnotationRectangularEntity.h"
#import "HXAnnotationRoundEntity.h"
#import "HXAnnotationArrowEntity.h"
#import "HXAnnotationCustomEntity.h"
#import "HXAnnotationRubberEntity.h"

#import "HXUndoEntity.h"

@interface HXDrawView_S ()
@property (nonatomic, strong) HXAnnotationMode * annotationMode;//注释mode
@property (nonatomic, strong) HXAnnotationBaseEntity * currentAnnotationEntity;//当前的注释实体
@property (nonatomic, strong) NSMutableArray<HXAnnotationBaseEntity *> * removeAnntationArr;//要删除注释的数组
@property (nonatomic, strong) NSMutableArray<HXUndoEntity *> * operationArr;//操作记录数组
@property (nonatomic, assign) NSInteger operationIndex;//操作记录索引
@property (nonatomic, assign) CGPoint tempSP;//记录原注释的开始点（用于撤销中）
@property (nonatomic, assign) CGPoint tempEP;//记录原注释的结束点（用于撤销中）

@property (nonatomic, assign) CGPoint tempMSP;//
@property (nonatomic, assign) CGPoint tempMEP;//

@property (nonatomic, assign) BOOL isChange;

@end

@implementation HXDrawView_S
#pragma mark get/set
- (NSMutableArray *)operationArr
{
    if (!_operationArr) {
        _operationArr = [NSMutableArray array];
    }
    return _operationArr;
}
- (NSMutableArray *)removeAnntationArr
{
    if (!_removeAnntationArr) {
        _removeAnntationArr = [NSMutableArray array];
    }
    return _removeAnntationArr;
}
- (NSMutableArray *)annotationArrM
{
    if (!_annotationArrM) {
        _annotationArrM = [NSMutableArray array];
    }
    return _annotationArrM;
}
- (void)setPid:(NSString *)pid
{
    _pid = pid;
    [self loadLocalSVG];
}
- (void)setOperationIndex:(NSInteger)operationIndex
{
    _operationIndex = operationIndex;
//    if (operationIndex < 0) {
//        //设置左按钮禁用
//        LCLog(@"设置左按钮禁用");
//        self.isChange = NO;
//        if ([_annotationDelegate respondsToSelector:@selector(drawView:changePreviousBtnstate:)]) {
//            [_annotationDelegate drawView:self changePreviousBtnstate:NO];
//        }
//    }else if (operationIndex == _operationArr.count -1){
//        //设置右按钮禁用
//        LCLog(@"设置右按钮禁用");
//        if ([_annotationDelegate respondsToSelector:@selector(drawView:changeNextBtnstate:)]) {
//            [_annotationDelegate drawView:self changeNextBtnstate:NO];
//        }
//    }
}
-(HXAnnotationMode *)annotationMode
{
    if (!_annotationMode) {
        _annotationMode = [HXAnnotationMode annotationModeShare];
    }
    return _annotationMode;
}
#pragma mark drawRect
- (void)drawRect:(CGRect)rect
{
    for (HXAnnotationBaseEntity * entity in self.annotationArrM) {
        [entity drawAnnotaiton];
    }
    if (self.currentAnnotationEntity) {
        [self.currentAnnotationEntity drawAnnotaiton];
    }
}
#pragma mark touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    UITouch * touch = touches.anyObject;

    
    CGPoint locationPoint = [touch locationInView:self];
    [self touchesBeganEventWithPoint:locationPoint];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//  LCLog(@"%lu",event.subtype);
//    LCLog(@"move ----%lu",touches.count);

    
//    LCLog(@"%lu",event.allTouches.count);
    
    if (event.allTouches.count >= 2) {

        
    }else{
        
        UITouch * touch = touches.anyObject;
        
        CGPoint locationPoint = [touch locationInView:self];
        
        if ([self.annotationDelegate respondsToSelector:@selector(canCallGesture:)]) {
            
            [self.annotationDelegate canCallGesture:NO];
        }
        
        [self touchesMovedEventWithPoint:locationPoint];
    }

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = touches.anyObject;
    
    CGPoint locationPoint = [touch locationInView:self];
    
    if (event.allTouches.count < 2){
        
        [self touchesEndedEventWithPoint:locationPoint];
    }
    
    if ([self.annotationDelegate respondsToSelector:@selector(canCallGesture:)]) {
        
        [self.annotationDelegate canCallGesture:YES];
    }
    
}



#pragma mark touchesBegan
- (void)touchesBeganEventWithPoint:(CGPoint)locationPoint
{
    self.tempSP = locationPoint;
    self.annotationMode.pid = self.pid;
    self.annotationMode.height = self.height;
    self.annotationMode.width = self.width;
    
    
    self.annotationMode.startPoint = locationPoint;
    self.annotationMode.endPoint = locationPoint;
    if (self.currentAnnotationEntity) {
//        self.currentAnnotationEntity.tempPoint = locationPoint;
        LCLog(@"设置当前实体的临时点");
    }
    if (self.annotationMode.type != HXAnnotationModeTypeDrag) {
//        if (self.currentAnnotationEntity) {
//            [self cleanCurrentAnnotationEntity];
//            LCLog(@"取消选中");
//            [self setNeedsDisplay];
//        }
    }
    switch (self.annotationMode.type) {
        case HXAnnotationModeTypeLine://线
        {
            self.currentAnnotationEntity = [[HXAnnotationLineEntity alloc]initWithMode:self.annotationMode];
            break;
        }
        case HXAnnotationModeTypeRectangular://矩形
        {
            self.currentAnnotationEntity = [[HXAnnotationRectangularEntity alloc]initWithMode:self.annotationMode];
            break;
        }
        case HXAnnotationModeTypeRound://圆
        {
            self.currentAnnotationEntity = [[HXAnnotationRoundEntity alloc]initWithMode:self.annotationMode];
            break;
        }
        case HXAnnotationModeTypeCustom://画笔
        {
            self.currentAnnotationEntity = [[HXAnnotationCustomEntity alloc]initWithMode:self.annotationMode];
            break;
        }
        case HXAnnotationModeTypeArrow://箭头
        {
            self.currentAnnotationEntity = [[HXAnnotationArrowEntity alloc]initWithMode:self.annotationMode];
            break;
        }
        case HXAnnotationModeTypeDrag:
        {
            BOOL is = NO;
            for (HXAnnotationBaseEntity * entity in self.annotationArrM) {
                if ([entity whetherInTheCurrentScopeWithPoint:locationPoint]) {
                    if (entity.nid != self.currentAnnotationEntity.nid) {
                        [self cleanCurrentAnnotationEntity];
                        LCLog(@"更换当前实体");
                    }
                    is = YES;
                    entity.tempPoint = locationPoint;
                    self.currentAnnotationEntity = entity;
                    self.tempSP = CGPointMake(entity.startPoint.x, entity.startPoint.y);
                    self.tempEP = CGPointMake(entity.endPoint.x, entity.endPoint.y);
                    
                    
                    self.tempMSP = CGPointMake(entity.tempPoint.x, entity.tempPoint.y);
                    break;
                }
            }
            if (!is) {
                [self cleanCurrentAnnotationEntity];
            }
//            [self setNeedsDisplay];
            break;
        }
        case HXAnnotationModeTypeRubber:
        {
            self.currentAnnotationEntity = [[HXAnnotationRubberEntity alloc]initWithMode:self.annotationMode];
            break;
        }
    }

}
#pragma mark touchesMoved
- (void)touchesMovedEventWithPoint:(CGPoint)locationPoint
{
    if (self.currentAnnotationEntity) {
        
        [self.currentAnnotationEntity touchesMovedWithPoint:locationPoint];
        
        if (self.annotationMode.type == HXAnnotationModeTypeDrag) {
            
            self.currentAnnotationEntity.tempPoint = locationPoint;
        }else if (self.annotationMode.type == HXAnnotationModeTypeRubber){
            
            [self deleteAnnotationWithPoint:locationPoint];
        }
    }
    [self setNeedsDisplay];
}
#pragma mark touchesEnded
- (void)touchesEndedEventWithPoint:(CGPoint)locationPoint
{
//    LCLog(@"操作 = %f",XWLengthOfTwoPoint(self.tempSP, locationPoint));
    if (self.currentAnnotationEntity) {
        if (XWLengthOfTwoPoint(self.tempSP, locationPoint) < 40) {
            [self cleanCurrentAnnotationEntity];
//            LCLog(@"无效操作 = ");
            [self setNeedsDisplay];
            return;
        }
        self.currentAnnotationEntity.tempPoint = locationPoint;
        [self.currentAnnotationEntity touchesMovedWithPoint:locationPoint];
        if (self.annotationMode.type == HXAnnotationModeTypeDrag) {
            //编辑注释代理
            if ([_annotationDelegate respondsToSelector:@selector(drawView:editorAnnotation:)])
            {
                [_annotationDelegate drawView:self editorAnnotation:self.currentAnnotationEntity];
            }
            //添加到操作记录中
            [self addOperationWithAnnotationOldSP:self.tempSP OldEP:self.tempEP OldMP:self.tempMSP orAnnotationArr:@[self.currentAnnotationEntity] UndoEntityOperationType:(HXUndoEntityOperationTypeEditor)];
            
        }else if (self.annotationMode.type == HXAnnotationModeTypeRubber){
            
            [self deleteAnnotationWithPoint:locationPoint];
            self.currentAnnotationEntity.startPoint = self.currentAnnotationEntity.endPoint = locationPoint;
            if (self.removeAnntationArr.count>0) {
                NSArray * tempArr = [NSArray arrayWithArray:self.removeAnntationArr];
                [self.removeAnntationArr removeAllObjects];
                //删除注释代理
                if ([_annotationDelegate respondsToSelector:@selector(drawView:removeAnnotation:)])
                {
                    [_annotationDelegate drawView:self removeAnnotation:tempArr];
                }
                //添加到操作记录中
                [self addOperationWithAnnotationOldSP:CGPointMake(0, 0) OldEP:CGPointMake(0, 0) OldMP:CGPointMake(0, 0) orAnnotationArr:tempArr UndoEntityOperationType:(HXUndoEntityOperationTypeRemov)];
            }
        }else{
            
            [self.annotationArrM addObject:self.currentAnnotationEntity];
            //添加注释代理
            if ([_annotationDelegate respondsToSelector:@selector(drawView:addAnnotation:)])
            {
                [_annotationDelegate drawView:self addAnnotation:@[self.currentAnnotationEntity]];
                
            }
            //添加到操作记录中
            [self addOperationWithAnnotationOldSP:self.currentAnnotationEntity.startPoint OldEP:self.currentAnnotationEntity.endPoint OldMP:self.currentAnnotationEntity.tempPoint orAnnotationArr:[NSArray arrayWithObject:self.currentAnnotationEntity] UndoEntityOperationType:(HXUndoEntityOperationTypeAdd)];
            [self cleanCurrentAnnotationEntity];
        }
    }
    [self setNeedsDisplay];
}
#pragma mark 加载本地svg
- (void)loadLocalSVG
{
//    [self.annotationArrM removeAllObjects];
//    [self.operationArr removeAllObjects];
//    NSMutableArray *SvgArr = [[LCFMDBManager share] getImageAllSVGWithImageID:self.pid];
//    for (int i= 0; i<SvgArr.count; i++) {
//        HXSVGEntity * entity = SvgArr[i];
//        if ([entity.userid isEqualToString:USERID]) {
//            
//        }
//        HXAnnotationBaseEntity * entityA;
//        switch ([entity.tp intValue]) {
//            case HXAnnotationModeTypeLine:
//            {
//                entityA = [[HXAnnotationLineEntity alloc]initWithSvgEntity:entity andWidth:self.width andHeight:self.height];
//                break;
//            }
//            case HXAnnotationModeTypeArrow:
//            {
//                entityA = [[HXAnnotationArrowEntity alloc]initWithSvgEntity:entity andWidth:self.width andHeight:self.height];
//                break;
//            }
//            case HXAnnotationModeTypeCustom:
//            {
//                entityA = [[HXAnnotationCustomEntity alloc] initWithSvgEntity:entity andWidth:self.width andHeight:self.height];
//                break;
//            }
//            case HXAnnotationModeTypeRectangular:
//            {
//                entityA = [[HXAnnotationRectangularEntity alloc] initWithSvgEntity:entity andWidth:self.width andHeight:self.height];
//                break;
//            }
//            case HXAnnotationModeTypeRound:
//            {
//                entityA = [[HXAnnotationRoundEntity alloc] initWithSvgEntity:entity andWidth:self.width andHeight:self.height];
//                break;
//            }
//        }
//        if (entityA) {
//            [self.annotationArrM addObject:entityA];
//        }
//        //添加自己的操作记录
//        if ([entityA.userid isEqualToString:USERID]) {
//
//            [self addOperationWithAnnotationOldSP:entityA.startPoint OldEP:entityA.endPoint OldMP:entityA.tempPoint orAnnotationArr:@[entityA] UndoEntityOperationType:HXUndoEntityOperationTypeAdd];
//        }
//    }
//    //设置操作索引
//    self.operationIndex = self.operationArr.count?self.operationArr.count -1 :-1;
//    [self setNeedsDisplay];
}
#pragma mark 删除注释
- (void)deleteAnnotationWithPoint:(CGPoint)point
{
    for (HXAnnotationBaseEntity * entity in self.annotationArrM) {
        if ([entity whetherInTheCurrentScopeWithPoint:point]) {
            entity.isSelected = NO;
            [self.removeAnntationArr addObject:entity];
            [self.annotationArrM removeObject:entity];
            break;
        }
    }
}
#pragma mark 清除当前注释实体
- (void)cleanCurrentAnnotationEntity
{
    self.currentAnnotationEntity.isSelectedPoint = NO;
    self.currentAnnotationEntity.isSelected = NO;
    self.currentAnnotationEntity = nil;
}
#pragma mark 撤销操作
#pragma mark 初始化操作记录数组
- (void)addOperationWithAnnotationOldSP:(CGPoint)oldSP OldEP:(CGPoint)oldEP OldMP:(CGPoint)oldMP orAnnotationArr:(NSArray<HXAnnotationBaseEntity *>*)annotationArr UndoEntityOperationType:(HXUndoEntityOperationType)operationType
{
    HXUndoEntity * undoEntity = [[HXUndoEntity alloc]init];
    undoEntity.operationType = operationType;
    undoEntity.AnnotationArr = annotationArr;
    if (operationType == HXUndoEntityOperationTypeEditor) {
        HXAnnotationBaseEntity * entity = [annotationArr firstObject];
        
        undoEntity.pointEntity.pointS = CGPointMake(entity.startPoint.x, [annotationArr firstObject].startPoint.y);
        undoEntity.pointEntity.pointE = CGPointMake(entity.endPoint.x, [annotationArr firstObject].endPoint.y);
        
        undoEntity.pointEntity.oldPointS = CGPointMake(self.tempSP.x, self.tempSP.y);
        undoEntity.pointEntity.oldPointE = CGPointMake(self.tempEP.x, self.tempEP.y);
        
        undoEntity.pointEntity.pointM = CGPointMake(entity.tempPoint.x, entity.tempPoint.y);
        undoEntity.pointEntity.oldPointM = CGPointMake(oldMP.x, oldMP.y);
    }
    [self.operationArr addObject:undoEntity];
    self.operationIndex = self.operationArr.count-1;
}
#pragma mark 上一步操作
- (void)previousAction
{
    if (self.operationIndex<0 || self.operationArr.count < 1) {
        return;
    }
    HXUndoEntity * undoEntity = self.operationArr[self.operationIndex];
    switch (undoEntity.operationType) {
        case HXUndoEntityOperationTypeAdd:
        {
            LCLog(@"执行上一步 删除%zd",undoEntity.AnnotationArr.count);
            [self removAnnotationWithAnnotationArr:undoEntity.AnnotationArr];
            break;
        }
        case HXUndoEntityOperationTypeEditor:
        {
            [self previousEditorAnnotationWithUndoEntity:undoEntity];
            break;
        }
        case HXUndoEntityOperationTypeRemov:
        {
            LCLog(@"执行上一步 添加%zd",undoEntity.AnnotationArr.count);
            [self addAnnotationWithAnnotationArr:undoEntity.AnnotationArr];
            break;
        }
    }
    self.operationIndex = self.operationIndex -1;
    if (self.operationIndex <0) {
        //设置左按钮禁用
        LCLog(@"设置左按钮禁用");
        if ([_annotationDelegate respondsToSelector:@selector(drawView:changePreviousBtnstate:)]) {
            [_annotationDelegate drawView:self changePreviousBtnstate:NO];
        }
    }
}
#pragma mark 下一步操作
- (void)nextAction
{
    
    self.operationIndex = self.operationIndex +1;
    if (self.operationIndex <0 || self.operationArr.count < 1 || self.operationIndex > self.operationArr.count-1) {
        self.operationIndex = self.operationArr.count -1;
        return;
    }
    if (self.operationIndex == self.operationArr.count -1) {
        //右按钮禁用
        LCLog(@"设置右按钮禁用");
        if ([_annotationDelegate respondsToSelector:@selector(drawView:changeNextBtnstate:)]) {
            [_annotationDelegate drawView:self changeNextBtnstate:NO];
        }
    }
    
    HXUndoEntity * undoEntity = [self.operationArr objectAtIndex:self.operationIndex];
    switch (undoEntity.operationType) {
        case HXUndoEntityOperationTypeAdd:
        {
            LCLog(@"执行下一步 添加 %zd",undoEntity.AnnotationArr.count);
            [self addAnnotationWithAnnotationArr:undoEntity.AnnotationArr];
            break;
        }
        case HXUndoEntityOperationTypeEditor:
        {
            [self nextEditorAnnotationWithUndoEntity:undoEntity];
            break;
        }
        case HXUndoEntityOperationTypeRemov:
        {
            LCLog(@"执行下一步 删除%zd",undoEntity.AnnotationArr.count);
            [self removAnnotationWithAnnotationArr:undoEntity.AnnotationArr];
            break;
        }
    }
    
}
#pragma mark 上一步移动操作
- (void)previousEditorAnnotationWithUndoEntity:(HXUndoEntity *)undoEntity
{
    if (self.currentAnnotationEntity) {
        self.currentAnnotationEntity = nil;
    }
    //取出移动前的实体对象
    HXAnnotationBaseEntity * entity = [undoEntity.AnnotationArr firstObject];
    
    
    entity.isSelected = NO;
    
    if (entity.type == HXAnnotationModeTypeCustom) {
        HXAnnotationCustomEntity * tempEntity = (HXAnnotationCustomEntity *)entity;
        entity.tempPoint = undoEntity.pointEntity.pointM;
        [tempEntity moveOneselfWithPoint:undoEntity.pointEntity.oldPointM];
    }else{
        entity.startPoint = undoEntity.pointEntity.oldPointS;
        entity.endPoint = undoEntity.pointEntity.oldPointE;
    }
    
    [self setNeedsDisplay];
    //编辑注释代理
    if ([_annotationDelegate respondsToSelector:@selector(drawView:editorAnnotation:)])
    {
        [_annotationDelegate drawView:self editorAnnotation:entity];
    }
}
#pragma mark 下一步移动操作
- (void)nextEditorAnnotationWithUndoEntity:(HXUndoEntity *)undoEntity
{
    if (self.currentAnnotationEntity) {
        self.currentAnnotationEntity = nil;
    }

    //取出移动后的实体对象
    HXAnnotationBaseEntity * entity = [undoEntity.AnnotationArr firstObject];
    entity.isSelected = NO;
    
    if (entity.type == HXAnnotationModeTypeCustom) {
        HXAnnotationCustomEntity * tempEntity = (HXAnnotationCustomEntity *)entity;
        entity.tempPoint = undoEntity.pointEntity.oldPointM;
        [tempEntity moveOneselfWithPoint:undoEntity.pointEntity.pointM];
    }else{
        entity.startPoint = undoEntity.pointEntity.pointS;
        entity.endPoint = undoEntity.pointEntity.pointE;
    }
    [self setNeedsDisplay];
    //编辑注释代理
    if ([_annotationDelegate respondsToSelector:@selector(drawView:editorAnnotation:)])
    {
        [_annotationDelegate drawView:self editorAnnotation:entity];
    }
}
#pragma mark 添加操作
- (void)addAnnotationWithAnnotationArr:(NSArray<HXAnnotationBaseEntity *> *)AnnotationArr
{
    NSInteger temp = self.annotationArrM.count;
    for (HXAnnotationBaseEntity * entity in AnnotationArr) {
        
        [self.annotationArrM addObject:entity];
    }
    if (temp != self.annotationArrM.count) {
        [self setNeedsDisplay];
    }
    //添加注释代理
    if ([_annotationDelegate respondsToSelector:@selector(drawView:addAnnotation:)])
    {
        [_annotationDelegate drawView:self addAnnotation:AnnotationArr];
    }
}
#pragma mark 删除操作
- (void)removAnnotationWithAnnotationArr:(NSArray<HXAnnotationBaseEntity *> *)AnnotationArr
{
    NSInteger temp = self.annotationArrM.count;
    for (HXAnnotationBaseEntity * entity in AnnotationArr) {
        
        [self.annotationArrM removeObject:entity];
    }
    if (temp != self.annotationArrM.count) {
        [self setNeedsDisplay];
    }
    //删除注释代理
    if ([_annotationDelegate respondsToSelector:@selector(drawView:removeAnnotation:)])
    {
        [_annotationDelegate drawView:self removeAnnotation:AnnotationArr];
    }
    
}
/**
 取消选中
 */
- (void)annotationUncheck
{
    [self touchesBeganEventWithPoint:CGPointMake(-1, -1)];
    self.annotationMode.color = [UIColor blackColor];
    
}

@end
