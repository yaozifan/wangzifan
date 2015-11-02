//
//  BaseViewController.h
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperation.h"
#import "UIProgressView+AFNetworking.h"
#import "AFURLConnectionOperation.h"

@interface BaseViewController : UIViewController
- (void)showMBProgressHUD:(NSString*)title;
- (void)closeHUD;
- (void)showMBProgressHUDMod:(NSString*)title;
- (void)showLoding:(BOOL)show;
- (void)showTop:(NSString*)title show:(BOOL)showTop afnateWoking:(AFURLConnectionOperation*)operation;
@end
