//
//  MainTabBarController.m
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavController.h"
#import "Common.h"
#import "ThemeImageButton.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"
#import "ThemeLable.h"
@interface MainTabBarController ()<SinaWeiboRequestDelegate>
{
    ThemeImageView *_selectImage;
    ThemeImageView *countImage;
    ThemeLable *countLable;
}
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavController];
    
    [self creatTabbarButton];
    
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timeAction) userInfo:nil repeats:YES ];
}


- (void)creatTabbarButton
{
    //移除自带的uitabBarButton
    //警告 ： 调用顺序不要变
    for (UIView*view in self.view.subviews)
    {
        //通过字符串获得类对象
        Class cls = NSClassFromString(@"UITabBarButton");
        
        if ([view isKindOfClass:cls])
        {
          
            [view removeFromSuperview];
        }

    }
    
    //创建背景图片
    
    ThemeImageView *bgImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 49)];
    
    [bgImageView setThemeImage:@"mask_navbar.png"];
    
    [self.tabBar addSubview:bgImageView];
    
    NSArray *imageNames = @[
                            @"home_tab_icon_1.png",
                            @"home_tab_icon_2.png",
                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png",
                            @"home_tab_icon_5.png"
                            ];
    
    CGFloat flotWidth = KScreenWidth/5;
    
    for (int i =0 ; i < imageNames.count; i++)
    {
        
        ThemeImageButton *btn = [[ThemeImageButton alloc]initWithFrame:CGRectMake(i*flotWidth, 0, flotWidth, 49)];
        
        btn.tag = i;
        
        [btn setStateNormalImage:imageNames[i]];
        
        [btn addTarget:self action:@selector(selecControllerAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:btn];
        
    }
    
    //选中图片
    _selectImage = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/5, 49)];
    
    [_selectImage setThemeImage:@"home_bottom_tab_arrow.png"];
    
    [self.tabBar addSubview:_selectImage];

}

- (void)timeAction
{
    //请求数据
    AppDelegate *delegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    
    SinaWeibo *weibo = delegate.sinaweibo;
    
    [weibo requestWithURL:@"remind/unread_count.json"
                   params:nil
               httpMethod:@"GET"
                 delegate:self];
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSNumber *number = result[@"status"];
    NSInteger count = [number integerValue];
    CGFloat floatx = KScreenWidth/4;
    if (countImage == nil )
    {
        countImage = [[ThemeImageView alloc]initWithFrame:CGRectMake(floatx-25, 0, 30, 30)];
        [countImage setThemeImage:@"number_notify_9"];
        [self.tabBar addSubview:countImage];
        
        countLable = [[ThemeLable alloc]initWithFrame:countImage.bounds];
        [countLable setThemeName:@"Timeline_Notice_color"];
        countLable.textAlignment = NSTextAlignmentCenter;
        countLable.backgroundColor = [UIColor clearColor];
        countLable.font = [UIFont systemFontOfSize:12];
        [countImage addSubview:countLable];
    }
    if (count>0)
    {
        countImage.hidden = NO;
        if (count>99)
        {
            count = 99;
        }
        countLable.text = [NSString stringWithFormat:@"%li",count];
        }
    else
    {
        countImage.hidden = YES;
    }
}


- (void)selecControllerAction:(UIButton *)btn
{
    //标签栏的属性，当前显示的控制器的索引值
    self.selectedIndex = btn.tag;
    
    _selectImage.center = btn.center;
}


- (void)creatNavController
{
    //五个视图控制器加入标签栏的控制器数组中
    NSArray*array = @[@"Home",@"Message",@"Profile",@"Discover",@"More"];
    
    NSMutableArray *navArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    for (int i = 0; i<5; i++) {
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:array[i] bundle:[NSBundle mainBundle]];
        
        BaseNavController *nav = [story instantiateInitialViewController];
        
        [navArray addObject:nav];
        
    }
    self.viewControllers = navArray;
}
@end
