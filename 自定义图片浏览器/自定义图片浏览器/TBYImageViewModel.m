//
//  TBYImageViewModel.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/16.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "TBYImageViewModel.h"
#import "TBYimageCollectionViewCell.h"


@interface TBYImageViewModel()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray * imageArr;

@end

static NSString * cellReuseIdentifier = @"cellReuseIdentifier";

@implementation TBYImageViewModel

- (void)handelCollection:(UICollectionView *)collectionView{
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[TBYimageCollectionViewCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
}


- (void)initDataWithArr:(NSArray *)arr complete:(void (^)(void))complete{
    
    
    self.imageArr = arr;
    
    if (complete) {
        
        complete();
    }
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TBYimageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    WS(weakSelf)
    
    cell.touchBlock = ^{
        
        if (weakSelf.tapBlock) {
            
            weakSelf.tapBlock();
        }
    };
    
    cell.iconImage = [UIImage imageNamed:(NSString *)self.imageArr[indexPath.row]];
    
    
    return cell;
    
}

@end
