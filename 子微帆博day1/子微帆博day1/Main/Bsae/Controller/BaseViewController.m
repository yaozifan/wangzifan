//
//  BaseViewController.m
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeManger.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()
{
    MBProgressHUD *hud;
    AFURLConnectionOperation *operation;
    UIWindow*_showWin;
}

@end

@implementation BaseViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        //当ThemeManger类里的 主题名 set方法被调用时，接收到通知，接收到通知后，更改导航栏背景图片
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeGetImage:) name:kThemeDidChangeNotificationName object:nil];
        [self themeGetThemeImage];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        //当ThemeManger类里的 主题名 set方法被调用时，接收到通知，接收到通知后，更改导航栏背景图片
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeGetImage:) name:kThemeDidChangeNotificationName object:nil];
        }
    
    return self;
}

#pragma mark - 创建标签栏上的两个按钮(已经用不到)
- (void)getNavItemBar
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
 
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

#pragma mark - 通知的方法（更改主题－》更改背景颜色的方法）
- (void)themeGetImage:(NSNotification*)notifacation
{
    [self themeGetThemeImage];
}
- (void)themeGetThemeImage
{
    ThemeManger*manger = [ThemeManger shareInstens];
    
    UIImage *image = [manger getThemeImage:@"bg_home.jpg"];
    
    self.view .backgroundColor = [UIColor colorWithPatternImage:image];
    

}
- (void)showMBProgressHUD:(NSString*)title
{
    if (hud == nil) {
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    [hud show:YES];
    hud.labelText = title;
    
}

- (void)showMBProgressHUDMod:(NSString*)title
{
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    //阴影的类型
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = title;
    
    [hud hide:YES afterDelay:2];
}

- (void)closeHUD
{
    [hud hide:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self themeGetThemeImage];
}

- (void)showLoding:(BOOL)show
{
    UIView *showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    showView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:showView];
    
    UIActivityIndicatorView *activi = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [showView addSubview:activi];
    
    if (show) {
        showView.hidden = NO;
    }else{
        showView.hidden = YES;
    }
}

- (void)showTop:(NSString*)title show:(BOOL)showTop afnateWoking:(AFURLConnectionOperation*)operation
{
    if (_showWin == nil) {
        _showWin = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
        _showWin.backgroundColor = [UIColor blackColor];
        _showWin.windowLevel = UIWindowLevelStatusBar;//设置优先级为最高级
        _showWin.hidden = NO;
        UILabel*lable = [[UILabel alloc] initWithFrame:_showWin.bounds];
        lable.text = title;
        lable.tag = 50;
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = [UIColor clearColor];
        [_showWin addSubview:lable];
        UIProgressView*progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progress.progress = 0.0f;
        progress.frame = CGRectMake(0, 17, KScreenWidth, 5);
        progress.tag = 101;
        [_showWin addSubview:progress];
    }
    
    
    if (showTop) {
        UILabel *lable = (UILabel*)[_showWin viewWithTag:50];
        lable.text = title;

        [self performSelector:@selector(showTopWindow) withObject:nil afterDelay:.5];
    }else{
        UIProgressView *progress = (UIProgressView*)[_showWin viewWithTag:101];
        
        [progress setProgressWithUploadProgressOfOperation:operation animated:YES];
    }
    
}


- (void)showTopWindow
{
    _showWin.hidden = YES;
    _showWin = nil;
    
}

@end
