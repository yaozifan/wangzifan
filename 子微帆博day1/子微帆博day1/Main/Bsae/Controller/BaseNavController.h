//
//  BaseNavController.h
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageButton.h"

@interface BaseNavController : UINavigationController
@property (nonatomic,strong)ThemeImageButton* button1;
@property (nonatomic,strong)ThemeImageButton* button2;
- (void)creatNavButton;


@end
