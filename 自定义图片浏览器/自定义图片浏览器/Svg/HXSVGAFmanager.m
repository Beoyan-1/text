//
//  HXSVGAFmanager.m
//  HXHY
//
//  Created by 佟博研 on 2017/9/14.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXSVGAFmanager.h"
#import "UIColor+LCCategory.h"


static NSString * svgUrl = @"stg/v1/svgs";

@interface HXSVGAFmanager()

//@property (nonatomic, strong) HXAFNManager * netManager;

@end


@implementation HXSVGAFmanager



//
//
//
//
//- (void)addSVGWithSvgModelArr:(NSArray *)modelArr
//                      Success:(SuccessBlock)success
//                      Failure:(FailureBlock)failure{
//
//    NSString * url = [NSString stringWithFormat:@"%@%@",BaseURL,svgUrl];
//
//    NSMutableArray * patamentArr = [NSMutableArray array];
//
//    for (HXSvgUpModel * model in modelArr) {
//
//        NSDictionary * patament = @{@"svglist":[self conversionAnnotationParameterWithAnnotationEntityArr:model.content WithOpr:@"1"],
//                                    @"fileid":model.fileID,
//                                    @"page":model.page};
//        [patamentArr addObject:patament];
//    }
//
//    NSDictionary * patamentDic = @{@"svgbody":patamentArr};
//
//    [self.netManager requestWithPath:url method:HttpRequestPost paramenters:patamentDic prepareExecute:nil progress:nil success:^(NSDictionary *object) {
//
//
//
//    } failure:^(NSString *error) {
//
//
//
//
//    }];
//
//}














//- (NSArray *)conversionAnnotationParameterWithAnnotationEntityArr:(NSArray <HXAnnotationBaseEntity *>*)annotationEntityArr WithOpr:(NSString *)opr{
//
//    NSMutableArray * tempArr = [NSMutableArray array];
//
//    for (HXAnnotationBaseEntity * annotationEntity in annotationEntityArr) {
//        NSDictionary * dic = @{@"opr":opr,
//                               @"nid":annotationEntity.nid,
//                               @"pid":annotationEntity.pid,
//                               @"cl":[UIColor toStrByUIColor:annotationEntity.color],
//                               @"lw":annotationEntity.lwP,
//                               @"tp":[NSString stringWithFormat:@"%zd",annotationEntity.type],
//                               @"ps":[annotationEntity.allPointArr componentsJoinedByString:@";"],
//                               };
//
//        NSString * jsonStr = [dic yy_modelToJSONString];
//
//        NSDictionary * dataDic = @{@"svgcontent":jsonStr,
//                                   @"nid":annotationEntity.nid};
//        [tempArr addObject:dataDic];
//    }
//    return tempArr;
//}

//- (HXAFNManager *)netManager{
//
//
//    if (!_netManager) {
//
//        _netManager = [HXAFNManager share];
//
//    }
//    return _netManager;
//}


@end
