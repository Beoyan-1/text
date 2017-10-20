//
//  ViewController.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/12.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+LCCategory.h"
#import "TBYImageViewController.h"
#import "UIImage+LCCategory.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *sa;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
////        self.navigationController.navigationBar.translucent = NO;
//    }
    
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
//    self.sa.maximumTrackTintColor  = redBackgroundColor;
   
    [self.sa setMinimumTrackImage:[UIImage imageNamed:@"Cooperation_SettingIn_Line_Img"] forState:UIControlStateNormal];
    
    [self.sa setMaximumTrackImage:[UIImage imageNamed:@"Cooperation_SettingIn_Line_Img"] forState:UIControlStateNormal];
//    self.sa.minimumValueImage = [UIImage imageNamed:@"Cooperation_Line_img"];
   
//    self.sa.maximumTrackTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Cooperation_Line_img"]];
    
    UIImageView * image = [[UIImageView alloc] init];
    image.frame = CGRectMake(0, 0, 100, 100);
            UIImage * minImage = [UIImage imageWithString:@"小" imageSize:CGSizeMake(adaptWidth(20), adaptWidth(20)) backColor:canNotPressColor wordColor:[UIColor whiteColor] wordFont:[UIFont systemFontOfSize:6]];
    UIImage * imaf = [UIImage imageWithString:@"小" imageSize:CGSizeMake(100, 100) backColor:canNotPressColor wordColor:[UIColor whiteColor] wordFont:APPFont20];
    self.sa.value = 0.5;
    image.image = imaf;
    [self.sa setMinimumValueImage:minImage];

    
    [self.view addSubview:image];
}
- (IBAction)btn:(id)sender {
    
    TBYImageViewController * vc = [[TBYImageViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
