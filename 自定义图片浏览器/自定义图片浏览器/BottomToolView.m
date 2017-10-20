//
//  BottomToolView.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/17.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "BottomToolView.h"



@interface BottomToolView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * itemCollectionView;

@property (nonatomic, strong) NSArray * bottomArr;

@end


static NSString *  itemCellReuseIdentifier = @"itemCellReuseIdentifier";
@implementation BottomToolView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.itemCollectionView];
        
        [self getData];
    }
    return self;
}

- (void)getData{
    
    
    BottomToolModel * toolModel = [[BottomToolModel alloc] init];
    
    toolModel.svgType = svgsettype;
    toolModel.isSelect = NO;
    
    BottomToolModel * toolModel1 = [[BottomToolModel alloc] init];
    toolModel1.svgType = svgbrushtype;
    toolModel1.isSelect = NO;
    
    BottomToolModel * toolModel2 = [[BottomToolModel alloc] init];
    
    toolModel2.svgType = svgshapetype;
    toolModel2.isSelect = NO;
    BottomToolModel * toolModel3 = [[BottomToolModel alloc] init];
    toolModel3.svgType = svgcharactertype;
    toolModel3.isSelect = NO;
    BottomToolModel * toolModel4 = [[BottomToolModel alloc] init];
    
    toolModel4.svgType = svglasertype;
    toolModel4.isSelect = NO;
    BottomToolModel * toolModel5 = [[BottomToolModel alloc] init];
    
    toolModel5.svgType = svgannotationtype;
    toolModel5.isSelect = NO;
    
    self.bottomArr = @[toolModel,toolModel1,toolModel2,toolModel3,toolModel4,toolModel5];
 
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.itemCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(adaptWidth(44));

    }];
    
}

- (void)reloadColor{
    
    [self.itemCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bottomArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BottomToolCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCellReuseIdentifier forIndexPath:indexPath];

    cell.model = self.bottomArr[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (NSInteger i = 0; i < self.bottomArr.count; i++) {
        
         BottomToolModel * model = self.bottomArr[i];
        
        model.isSelect = NO;
        
        if (i == indexPath.row) {
            
            model.isSelect = YES;
            
        }
    }
    BottomToolModel * model1 = self.bottomArr[indexPath.row];
    
    if (self.touchIconBlock) {
        self.touchIconBlock(model1);
    }
    
    [self.itemCollectionView reloadData];
}


#pragma mark - get/set

- (UICollectionView *)itemCollectionView{
    
    if (!_itemCollectionView) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(SCREENW/6, adaptWidth(44));
        
        _itemCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _itemCollectionView.delegate = self;
        _itemCollectionView.dataSource = self;
        _itemCollectionView.backgroundColor = textblackColor;
        _itemCollectionView.alpha = 0.96;
        [_itemCollectionView registerClass:[BottomToolCollectionViewCell class] forCellWithReuseIdentifier:itemCellReuseIdentifier];
    }
    return _itemCollectionView;
}


@end
