//
//  BottomToolSetView.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/18.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "BottomToolSetView.h"
#import "ColorCollectionViewCell.h"

@interface BottomToolSetView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * shapeCollectionView;

@property (nonatomic, strong) UICollectionView * colorCollectionView;

@property (nonatomic, strong) UIView * firstView;

@property (nonatomic, strong) UIView * secondeView;

@property (nonatomic, strong) NSArray * colorArr;

@end


static NSString * colorCellReuseIdentifier = @"colorCellReuseIdentifier";
@implementation BottomToolSetView



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.firstView];
        [self.firstView addSubview:self.colorCollectionView];
        [self addSubview:self.secondeView];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(adaptWidth(42));
    }];
    
    [_secondeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(adaptWidth(35));
        
        make.left.right.top.equalTo(self);
        
        make.bottom.equalTo(self.firstView.mas_top);
        
    }];
    
    [self.colorCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self.firstView);
    }];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == self.colorCollectionView) {
        return self.colorArr.count;
    }
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ColorCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:colorCellReuseIdentifier forIndexPath:indexPath];
    
    BottomColorModel * model = self.colorArr[indexPath.row];
    
    HXAnnotationMode * annModel = [HXAnnotationMode annotationModeShare];
    
    if (annModel.colorType == model.colorType) {
        
        model.isSelect = YES;
        
    }else{
        
        model.isSelect = NO;
    }
    
    cell.colorModel = model;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.colorCollectionView) {
        
        BottomColorModel * model = self.colorArr[indexPath.row];
        
        HXAnnotationMode * annModel = [HXAnnotationMode annotationModeShare];
        
        annModel.colorType = model.colorType;
        
        [self.colorCollectionView reloadData];
        
    }
    
}

#pragma mark - get/set

- (UIView *)firstView{
    
    if (!_firstView) {
        _firstView = [[UIView alloc] init];
        _firstView.backgroundColor =  [UIColor clearColor];
        
        
    }
    
    return _firstView;
}

- (UIView *)secondeView{
    
    if (!_secondeView) {
        _secondeView = [[UIView alloc] init];
        _secondeView.backgroundColor = kUIColorFromRGBAndAlpha(0x1b1b1b, 0.9);
        _secondeView.alpha = 0.9;
    }
    
    return _secondeView;
}

- (void)setModel:(BottomToolModel *)model{
    
    switch (model.svgType) {
            
        case svgsettype:
            
            
            
            break;
            
        default:
            break;
    }
    
    
}

-(UICollectionView *)colorCollectionView{
    
    if (!_colorCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        flowLayout.itemSize = CGSizeMake(SCREENW/9, adaptWidth(42));
        
        _colorCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _colorCollectionView.backgroundColor = kUIColorFromRGBAndAlpha(0x1b1b1b, 0.84);
        [_colorCollectionView registerClass:[ColorCollectionViewCell class] forCellWithReuseIdentifier:colorCellReuseIdentifier];
        _colorCollectionView.dataSource = self;
        _colorCollectionView.delegate = self;
    }
    
    return _colorCollectionView;
}

- (UICollectionView *)shapeCollectionView{
    
    if (!_shapeCollectionView) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        flowLayout.itemSize = CGSizeMake(SCREENW/4, adaptWidth(42));
        _shapeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _shapeCollectionView.delegate = self;
    }
    return _shapeCollectionView;
}

- (NSArray *)colorArr{
    
    if (!_colorArr) {
       
        BottomColorModel * colorModel1 = [[BottomColorModel alloc] initWithColorType:HXRedColorType];
        
         BottomColorModel * colorModel2 = [[BottomColorModel alloc] initWithColorType:HXOrangeColorType];
        
         BottomColorModel * colorModel3 = [[BottomColorModel alloc] initWithColorType:HXYellorColorType];
        
         BottomColorModel * colorModel4 = [[BottomColorModel alloc] initWithColorType:HXGreenColorType];
        
         BottomColorModel * colorModel5 = [[BottomColorModel alloc] initWithColorType:HXBlueColorType];
         BottomColorModel * colorModel6 = [[BottomColorModel alloc] initWithColorType:HXPurpleColorType];
         BottomColorModel * colorModel7 = [[BottomColorModel alloc] initWithColorType:HXWhiteColorType];
         BottomColorModel * colorModel8 = [[BottomColorModel alloc] initWithColorType:HXGrayColorType];
         BottomColorModel * colorModel9 = [[BottomColorModel alloc] initWithColorType:HXBlackColorType];
        
        _colorArr = @[colorModel1,colorModel2,colorModel3,colorModel4,colorModel5,colorModel6,colorModel7,colorModel8,colorModel9];
        
    }
    
    return _colorArr;
}


@end
