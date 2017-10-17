//
//  HXSVGEntity.h
//  test
//
//  Created by 孙海平 on 16/11/28.
//  Copyright © 2016年 孙海平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXSVGEntity : NSObject
@property (copy, nonatomic)NSString * fileid;
@property (copy, nonatomic)NSString * svgid;
@property (copy, nonatomic)NSString * userid;
@property (copy, nonatomic)NSString * pid;
@property (copy, nonatomic)NSString * nid;
@property (copy, nonatomic)NSString * sid;
@property (copy, nonatomic)NSString * tp;
@property (copy, nonatomic)NSString * opr;
@property (copy, nonatomic)NSString * nt;
@property (copy, nonatomic)NSString * cl;
@property (copy, nonatomic)NSString * lw;
@property (copy, nonatomic)NSString * x;
@property (copy, nonatomic)NSString * y;
@property (copy, nonatomic)NSString * w;
@property (copy, nonatomic)NSString * h;
@property (copy, nonatomic)NSString * sx;
@property (copy, nonatomic)NSString * sy;
@property (copy, nonatomic)NSString * ex;
@property (copy, nonatomic)NSString * ey;
@property (copy, nonatomic)NSString * ps;
@property (copy, nonatomic)NSString * img;
@property (copy, nonatomic)NSString * aud;
@property (copy, nonatomic)NSString * vid;
@property (copy, nonatomic)NSString * txt;
@property (copy, nonatomic)NSString * createDate;
@property (copy, nonatomic)NSString * isSync;
@property (copy, nonatomic)NSString * showID;
@property (copy, nonatomic)NSString * groupID;

//- (instancetype)initWithResultSet:(FMResultSet *)resultSet;
- (instancetype)initWithDic:(NSDictionary *)dic;
- (NSDictionary *)getMobileSvgParameterWithOpr:(NSString *)opr;
@end
