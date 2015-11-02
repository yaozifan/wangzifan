//
//  AppDelegate.m
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MainTabBarController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "BaseModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
        
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    MainTabBarController *tab = [[MainTabBarController alloc]init];
    
    [self.window makeKeyAndVisible];
    //设置左中右控制器
    LeftViewController* left = [[LeftViewController alloc]init];
    RightViewController *right = [[RightViewController alloc]init];
    
    //创建MMDrawerController.h控制器
    MMDrawerController *mmDraw = [[MMDrawerController alloc]initWithCenterViewController:tab leftDrawerViewController:left rightDrawerViewController:right];
    
    //设置手势有效区域
    [mmDraw setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmDraw setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置动画类型
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    
    [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];

    
    //设置左边右边宽度
    
    [mmDraw setMaximumRightDrawerWidth:66.6];
    [mmDraw setMaximumLeftDrawerWidth:150.0];
    
    //设置动画效果，当侧边栏打开或关闭的时候调用block代码块
    [mmDraw setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
                 drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            
            block(drawerController,drawerSide,percentVisible);
            
        }
        
    }];


    self.window.rootViewController = mmDraw;
    //创建一个微博对象,他的代理对象是AppDelegate 初始化完毕后，将这个对象给sinaweibo属性
    SinaWeibo *sina = [[SinaWeibo alloc]initWithAppKey:kAppKey
                                            appSecret:kAppSecret
                                       appRedirectURI:kAppRedirectURI andDelegate:self];
    
    self.sinaweibo = sina;
    
    // AppKey：个人AppKey  appSecret：个人appSecret  appRedirectURI：授权跳转回调地址
    
    //打开系统内置的plist文件，或者说是得到一个plist单例（这个单例可能会已经记载了登录信息）
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"ZIFanSinaWeiboAuthData"];
    
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sina.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sina.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sina.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//登陆成功后实现的代理方法
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self storeAuthData];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DidLogIn" object:nil];
    
}
- (void)storeAuthData
{
    SinaWeibo *sinaweibo = _sinaweibo;
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"ZIFanSinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ZIFanSinaWeiboAuthData"];
}
//退出登录后实现的代理方法
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo;
{
    [self removeAuthData];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DidLogOut" object:nil];
}




@end
