//
//  BaseNavController.m
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManger.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
@interface BaseNavController ()

@end

@implementation BaseNavController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        //当ThemeManger类里的 主题名 set方法被调用时，接收到通知，接收到通知后，更改导航栏背景图片
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeGetImage:) name:kThemeDidChangeNotificationName object:nil];
    }
    
    return self;
}
#pragma mark- 接收到通知后的方法
- (void)themeGetImage:(NSNotification*)notficaTion
{
    [self getThemeImage];
}

- (void)getThemeImage
{
    ThemeManger *manger = [ThemeManger shareInstens];
    
    UIImage*image = [manger getThemeImage:@"mask_titlebar64.png"];
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    UIColor *color = [manger getThemeColor:@"Mask_Title_color"];
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName:color
                                               };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getThemeImage];
    
}

 -(void)creatNavButton
{
    //左侧按钮
    _button1 =[[ThemeImageButton alloc]initWithFrame:CGRectMake(10, 25, 80, 33)];
    
    _button1.stateNormalImage = @"group_btn_all_on_title.png";
    //button上的图片向左移动X个单位
    _button1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [_button1 setTitle:@"设置" forState:UIControlStateNormal];
    
    _button1.titleLabel.font = [UIFont systemFontOfSize:15];
    
    _button1.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    _button1.backThemeImage = @"button_title.png";
    
    [_button1 addTarget:self action:@selector(leftBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button1];


    //右侧按钮
    _button2 =[[ThemeImageButton alloc]initWithFrame:CGRectMake(KScreenWidth-50, 25, 40, 33)];
    
    _button2.stateNormalImage = @"button_icon_plus.png";
    
    _button2.backThemeImage = @"button_m.png";
    
    [_button2 addTarget:self action:@selector(rightBarAction) forControlEvents:UIControlEventTouchUpInside];
 
    [self.view addSubview:_button2];

}

- (void)leftBarAction
{
    MMDrawerController *mmd = self.mm_drawerController;
    
    [mmd openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)rightBarAction
{
    //或者从aplication中获得
    
    MMDrawerController *mmd = self.mm_drawerController;
    
    [mmd openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
