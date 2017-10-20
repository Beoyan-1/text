//
//  BottomToolSetView.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/18.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "BottomToolSetView.h"
#import "ColorCollectionViewCell.h"
#import "ShapeCollectionViewCell.h"
#import "UIImage+LCCategory.h"
#import "ToolRoundView.h"
#import "UIImage+LCCategory.h"

@interface BottomToolSetView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * shapeCollectionView;

@property (nonatomic, strong) UICollectionView * colorCollectionView;

@property (nonatomic, strong) UIView * firstView;

@property (nonatomic, strong) UIView * secondeView;

@property (nonatomic, strong) UIView * shapeView;

/**
 存颜色的数组
 */
@property (nonatomic, strong) NSArray * colorArr;

/**
 存形状的数组
 */
@property (nonatomic, strong) NSArray * shapeArr;

/**
 线段宽度
 */
@property (nonatomic, strong) UISlider * widthSlider;

/**
 小
 */
@property (nonatomic, strong) UILabel * minLable;

/**
 大
 */
@property (nonatomic, strong) UILabel * maxLabel;

/**
 描述文字
 */
@property (nonatomic, strong) UILabel * descLabel;

/**
 圆
 */
@property (nonatomic, strong) ToolRoundView * roundView;

/**
 分割线
 */
@property (nonatomic, strong) UIImageView * lineView;

/**
 左侧撤销按钮
 */
@property (nonatomic, strong) UIButton * leftRevocationBtn;

/**
 右侧撤销按钮
 */
@property (nonatomic, strong) UIButton * rightRevocationBtn;

@end


static NSString * colorCellReuseIdentifier = @"colorCellReuseIdentifier";

static NSString * shapeCellReuseIdentifier = @"shapeCellReuseIdentifier";

@implementation BottomToolSetView



- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.firstView];
        
        [self.firstView addSubview:self.colorCollectionView];
        
        [self.firstView addSubview:self.shapeView];
        
        [self.shapeView addSubview:self.shapeCollectionView];
        
        [self.shapeView addSubview:self.lineView];
        
        [self.shapeView addSubview:self.leftRevocationBtn];
        
        [self.shapeView addSubview:self.rightRevocationBtn];
        
        [self.secondeView addSubview:self.widthSlider];
        
        [self.secondeView addSubview:self.minLable];
        
        [self.secondeView addSubview:self.maxLabel];
        
        [self.secondeView addSubview:self.descLabel];
        
        [self.secondeView addSubview:self.roundView];
        
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
    
    [_minLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerY.equalTo(self.secondeView.mas_centerY);
        
        make.left.equalTo(self.secondeView.mas_left).with.offset(12);
        
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [_maxLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.secondeView.mas_centerY);

        make.left.equalTo(self.widthSlider.mas_right).with.offset(10);

        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    
    
    [_widthSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.minLable.mas_right).with.offset(10);
        
        make.top.bottom.equalTo(self.secondeView);
        
        make.width.mas_equalTo(adaptWidth(186));
        
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.maxLabel.mas_right).with.offset(35);
        
        make.centerY.equalTo(self.secondeView.mas_centerY);
        
    }];
    
    [_roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.secondeView.mas_right).with.offset(-12);
        make.size.mas_equalTo(CGSizeMake(adaptWidth(30), adaptWidth(30)));
        make.centerY.equalTo(self.secondeView.mas_centerY);
        
    }];
    
    
    [self.colorCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self.firstView);
    }];
   
    
    [self.shapeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self.firstView);
    }];
    
    [self.shapeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.equalTo(self.shapeView);
        
        make.width.mas_equalTo(SCREENW * 2 /3);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shapeCollectionView.mas_right);
        make.centerY.equalTo(self.shapeView.mas_centerY);
    }];
    
    [self.leftRevocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.shapeCollectionView.mas_right);
        
        make.centerY.equalTo(self.shapeView);
        make.top.bottom.equalTo(self.shapeView);
    }];
    
    [self.rightRevocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.leftRevocationBtn.mas_right);
        
        make.right.equalTo(self.shapeView.mas_right);
        
        make.top.bottom.equalTo(self.shapeView);
        
        make.width.equalTo(self.leftRevocationBtn.mas_width);
    }];
    
}

#pragma mark - Clicks


- (void)sliderChangValue:(UISlider *)slider{
    
    [HXAnnotationMode annotationModeShare].lineWidth = slider.value;
    
    [self.roundView setNeedsDisplay];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == self.colorCollectionView) {
        
        return self.colorArr.count;
        
    }else{
        
        return self.shapeArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView == self.colorCollectionView) {
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
    }else{
        
        ShapeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:shapeCellReuseIdentifier forIndexPath:indexPath];
    
        BottomShapeModel * model = self.shapeArr[indexPath.row];
        
        HXAnnotationMode * annModel = [HXAnnotationMode annotationModeShare];
        
        if (annModel.type == model.type) {
            
            model.isSelect = YES;
            
        }else{
            
            model.isSelect = NO;
        }
        
         cell.shapeModel = model;
        
        return cell;
    }
    
}

#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.colorCollectionView) {
        
        BottomColorModel * model = self.colorArr[indexPath.row];
        
        HXAnnotationMode * annModel = [HXAnnotationMode annotationModeShare];
        
        annModel.colorType = model.colorType;
        
        [self.colorCollectionView reloadData];
        
        if (self.reloadBlock) {
            
            self.reloadBlock();
        }
        
        [self.roundView setNeedsDisplay];
        
    }else{
        
        BottomShapeModel * model = self.shapeArr[indexPath.row];
        
        HXAnnotationMode * annModel = [HXAnnotationMode annotationModeShare];
        
        annModel.type = model.type;
        
        [self.shapeCollectionView reloadData];
        
    }
    
}

#pragma mark - get/set

- (UIView *)firstView{
    
    if (!_firstView) {
        _firstView = [[UIView alloc] init];
        _firstView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    }
    
    return _firstView;
}

- (UIView *)secondeView{
    
    if (!_secondeView) {
        _secondeView = [[UIView alloc] init];
        _secondeView.backgroundColor = kUIColorFromRGBAndAlpha(0x1b1b1b, 0.84);
    }
    
    return _secondeView;
}

- (void)setModel:(BottomToolModel *)model{
    
    switch (model.svgType) {
            
        case svgsettype:{           //设置
            
            self.shapeView.hidden = YES;
            
            self.colorCollectionView.hidden = NO;
            
            self.secondeView.hidden = NO;
            
           break;
        }
        case svgbrushtype:{         //画笔
            
            self.shapeView.hidden = NO;
            
            self.colorCollectionView.hidden = YES;
            
            self.secondeView.hidden = YES;
            
            BottomShapeModel * model1 = [[BottomShapeModel alloc] initWithShapeType:HXAnnotationModeTypeLine];
            
            BottomShapeModel * model2 = [[BottomShapeModel alloc] initWithShapeType:HXAnnotationModeTypeCustom];
            
            HXAnnotationMode * annModel = [HXAnnotationMode annotationModeShare];
            
            annModel.type = HXAnnotationModeTypeLine;
            
            self.shapeArr = @[model1,model2];
            
            [self.shapeCollectionView reloadData];
            
            break;
        }
        case svgshapetype:{         //形状
            
            self.shapeView.hidden = NO;
            
            self.colorCollectionView.hidden = YES;
            
            self.secondeView.hidden = YES;
            
            BottomShapeModel * model1 = [[BottomShapeModel alloc] initWithShapeType:HXAnnotationModeTypeRectangular];
            
            BottomShapeModel * model2 = [[BottomShapeModel alloc] initWithShapeType:HXAnnotationModeTypeRound];
            
            BottomShapeModel * model3 = [[BottomShapeModel alloc] initWithShapeType:HXAnnotationModeTypeArrow];
            
            self.shapeArr = @[model1,model2,model3];
            
            HXAnnotationMode * annModel = [HXAnnotationMode annotationModeShare];
            
            annModel.type = HXAnnotationModeTypeRectangular;
            
            [self.shapeCollectionView reloadData];
            
            break;
        }
        case svgcharactertype:{     //文字
            
            
            
            
            break;
        }
        case svglasertype:{         //激光笔
            
            
            
            
            break;
        }
        case svgannotationtype:{    //
            
            
            
            
            break;
        }
            
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
        
        flowLayout.itemSize = CGSizeMake(SCREENW /6, adaptWidth(42));
        _shapeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _shapeCollectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        _shapeCollectionView.delegate = self;
        _shapeCollectionView.dataSource = self;
        [_shapeCollectionView registerClass:[ShapeCollectionViewCell class] forCellWithReuseIdentifier:shapeCellReuseIdentifier];
    }
    return _shapeCollectionView;
}

- (UIView *)shapeView{
    
    if (!_shapeView) {
        
        _shapeView = [[UIView alloc] init];
        
        _shapeView.backgroundColor = kUIColorFromRGBAndAlpha(0x1b1b1b, 0.84);
    }
    return _shapeView;
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
        
        _colorArr = @[colorModel1,colorModel2,colorModel3,colorModel4,
                      colorModel5,colorModel6,colorModel7,colorModel8,colorModel9];
        
    }
    
    return _colorArr;
}

- (UISlider *)widthSlider{
    
    if (!_widthSlider) {
        _widthSlider = [[UISlider alloc] initWithFrame:CGRectZero];
        _widthSlider.minimumValue = 1.0;
        _widthSlider.maximumValue = 20.0;

        [_widthSlider addTarget:self action:@selector(sliderChangValue:) forControlEvents:UIControlEventValueChanged];
        
        _widthSlider.minimumTrackTintColor = kUIColorFromRGB(0x5e5e5e);
        _widthSlider.maximumTrackTintColor = kUIColorFromRGB(0x5e5e5e);
        _widthSlider.value = [HXAnnotationMode annotationModeShare].lineWidth;
       
        [_widthSlider setThumbImage:[UIImage imageNamed:@"Cooperation_SettingIn_Btn_Img-1"] forState:UIControlStateNormal];
    }
    
    return _widthSlider;
}

- (UILabel *)minLable{
    if (!_minLable) {
        _minLable = [[UILabel alloc] init];
        _minLable.textColor = [UIColor whiteColor];
        _minLable.text = @"小";
        _minLable.backgroundColor = [UIColor clearColor];
        _minLable.font = APPFont13;
    }
    return _minLable;
}

- (UILabel *)maxLabel{
    
    if (!_maxLabel) {
        _maxLabel = [[UILabel alloc] init];
        _maxLabel.text = @"大";
        _maxLabel.textColor = [UIColor whiteColor];
        _maxLabel.backgroundColor = [UIColor clearColor];
        _maxLabel.font = APPFont13;
    }
    return _maxLabel;
}

- (UILabel *)descLabel{
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"画笔粗细";
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.font = APPFont13;
        _descLabel.textColor = [UIColor whiteColor];
    }
    return _descLabel;
}

- (ToolRoundView *)roundView{
    
    if (!_roundView) {
        _roundView = [[ToolRoundView alloc] init];
        _roundView.backgroundColor = [UIColor clearColor];
    }
    
    return _roundView;
}

- (UIButton *)leftRevocationBtn{
    
    if (!_leftRevocationBtn) {
        _leftRevocationBtn = [[UIButton alloc] init];
        [_leftRevocationBtn setImage:[UIImage imageNamed:@"Cooperation_Undo_btn"] forState:UIControlStateNormal];
    }
    
    return _leftRevocationBtn;
}

- (UIButton *)rightRevocationBtn{
    
    if (!_rightRevocationBtn) {
        _rightRevocationBtn = [[UIButton alloc] init];
        [_rightRevocationBtn setImage:[UIImage imageNamed:@"Cooperation_Redo_btn"] forState:UIControlStateNormal];
    }
    return _rightRevocationBtn;
}

- (UIImageView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIImageView alloc] init];
        _lineView.image = [UIImage imageNamed:@"Cooperation_Line_img"];
        
    }
    return _lineView;
}








@end
