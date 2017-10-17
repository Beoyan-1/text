//
//  TBYImageViewModel.h
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/16.
//  Copyright © 2017年 tby. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^tapBlock)(void);

@interface TBYImageViewModel : NSObject

@property (nonatomic, copy) tapBlock tapBlock;

- (void)handelCollection:(UICollectionView *)collectionView;

- (void)initDataWithArr:(NSArray *)arr complete:(void (^)(void))complete;


@end
