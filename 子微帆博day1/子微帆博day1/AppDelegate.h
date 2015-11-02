//
//  AppDelegate.h
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) SinaWeibo *sinaweibo;


@end

