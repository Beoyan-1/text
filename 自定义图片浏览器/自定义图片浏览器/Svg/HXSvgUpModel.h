//
//  HXSvgUpModel.h
//  HXHY
//
//  Created by 佟博研 on 2017/9/14.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXSvgUpModel : NSObject


/**
 文件ID
 */
@property (nonatomic, strong) NSString * fileID;

/**
 文件页数
 */
@property (nonatomic, strong) NSString * page;

/**
 json字符串
 */
@property (nonatomic, strong) NSArray * content;


@end
