//
//  TBYImageViewController.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/12.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "TBYImageViewController.h"
#import "TBYimageCollectionViewCell.h"
#import "TBYImageViewModel.h"
#import "TopToolView.h"
#import "BottomToolView.h"
#import "BottomToolSetView.h"

@interface TBYImageViewController ()

@property (nonatomic, strong) UICollectionView * imageCollectionView;

@property (nonatomic, strong) TBYImageViewModel * viewModel;

@property (nonatomic, strong) TopToolView * topToolView;

@property (nonatomic, strong) UIView * bottomToolView;

@property (nonatomic, strong) BottomToolView * bottomView;

@property (nonatomic, strong) BottomToolSetView * setView;

@property (nonatomic, assign) BOOL isShowTool;

@property (nonatomic, assign) NSInteger currentRow;

@end

@implementation TBYImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentRow = 0;
    self.isShowTool = YES;
    [self initView];
    [self layout];
    [self getData];
    
}

- (void)initView{
    
    self.view.backgroundColor = textblackColor;
    
    [self.view addSubview:self.imageCollectionView];
    
    [self.view addSubview:self.topToolView];
    
    [self.bottomToolView addSubview:self.bottomView];
    
    [self.viewModel handelCollection:self.imageCollectionView];
    
    [self.bottomToolView addSubview:self.setView];
    
    [self.view addSubview:self.bottomToolView];
    
}

- (void)getData{
    
    WS(weakSelf)
    
    [self.viewModel initDataWithArr:self.imageArr complete:^{
        
        [weakSelf.imageCollectionView reloadData];
    }];
    
}

- (void)layout{
    [self.topToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(adaptWidth(62));
        
    }];
    
    
    
    [self.imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self.view);
        
    }];
    
    
    [self.setView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self.bottomToolView);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.height.mas_equalTo(0.1);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.bottomToolView);
        make.height.mas_equalTo(adaptWidth(44));
    }];
    
    [self.bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
  
}



#pragma mark - get/set

- (UICollectionView *)imageCollectionView{
    
    if (!_imageCollectionView) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        flowLayout.itemSize = CGSizeMake(SCREENW, SCREENH);

        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _imageCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _imageCollectionView.pagingEnabled = YES;
      
        _imageCollectionView.showsVerticalScrollIndicator = NO;
        _imageCollectionView.showsVerticalScrollIndicator = NO;
        _imageCollectionView.scrollEnabled = NO;
    }
    
    return _imageCollectionView;
}

- (NSArray *)imageArr{
    
    if (!_imageArr) {
        
        _imageArr = @[@"MWPhotoBrowser1",@"MWPhotoBrowser2",@"MWPhotoBrowser3",@"1233",@"1234",@"1235",@"qwer"];
    }
    return _imageArr;
}

- (TBYImageViewModel *)viewModel{
    
    if (!_viewModel) {
        
        _viewModel = [[TBYImageViewModel alloc] init];
        WS(weakSelf)
        _viewModel.tapBlock = ^{
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!weakSelf.topToolView.hidden) {
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        [weakSelf.topToolView mas_remakeConstraints:^(MASConstraintMaker *make) {
                             make.left.right.top.equalTo(weakSelf.view);
                            make.height.mas_equalTo(0);
                            
                        }];
                        weakSelf.topToolView.alpha = 0;
                        [weakSelf.topToolView layoutSubviews];
                        
                        [weakSelf.bottomToolView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.bottom.equalTo(weakSelf.view);
                            make.height.mas_equalTo(0.1);
                        }];
                        
                        weakSelf.bottomToolView.hidden = YES;
                        weakSelf.topToolView.hidden = YES;
                        
                    } completion:^(BOOL finished) {
                        
                        
                    }];

                }else{
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        [weakSelf.topToolView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.top.equalTo(weakSelf.view);
                            make.height.mas_equalTo(adaptWidth(62));
                            
                        }];
                        weakSelf.topToolView.alpha = 0.8;
                        [weakSelf.topToolView layoutSubviews];
                        weakSelf.bottomToolView.hidden = NO;
                        weakSelf.topToolView.hidden = NO;
                        [weakSelf.bottomToolView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.bottom.equalTo(weakSelf.view);
                        }];
                        
                    } completion:^(BOOL finished) {
                        
                        
                    }];
  
                }
                
            });
            
        };
    }
    
    return _viewModel;
}

- (TopToolView *)topToolView{
    
    if (!_topToolView) {
        _topToolView = [[TopToolView alloc] init];
        _topToolView.backgroundColor = textblackColor;
        _topToolView.alpha = 0.96;
        WS(weakSelf)
        _topToolView.rightBlock = ^{
            
            weakSelf.currentRow++;
            
            NSIndexPath * index = [NSIndexPath indexPathForRow:weakSelf.currentRow inSection:0];
            
            [weakSelf.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        };
        
        _topToolView.leftBlock = ^{
            
            weakSelf.currentRow--;
            
            NSIndexPath * index = [NSIndexPath indexPathForRow:weakSelf.currentRow inSection:0];
            
            [weakSelf.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            
        };
        
        _topToolView.cancleBlock = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        
    }
    return _topToolView;
}

- (BottomToolView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[BottomToolView alloc] init];
        
        WS(weakSelf);
        _bottomView.touchIconBlock = ^(BottomToolModel *model) {
            
            weakSelf.setView.model = model;
            
            weakSelf.setView.hidden = NO;
            
            [UIView animateWithDuration:0.3 animations:^{
               
                [weakSelf.setView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.right.top.equalTo(weakSelf.bottomToolView);
                    make.bottom.equalTo(weakSelf.bottomView.mas_top);
                    
                }];
                
            }];
        };
        
    }
    
    return _bottomView;
}

- (BottomToolSetView *)setView{
    
    if (!_setView) {
        
        _setView = [[BottomToolSetView alloc] init];
        
        _setView.hidden = YES;
        
        WS(weakSelf)
        
        _setView.reloadBlock = ^{
            
            [weakSelf.bottomView reloadColor];
        };
    }
    return _setView;
}

- (UIView *)bottomToolView{
    
    if (!_bottomToolView) {
        
        _bottomToolView  = [[UIView alloc] init];
        
    }
    return _bottomToolView;
}

@end
