//
//  ThemeImageView.m
//  子微帆博day1
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManger.h"
@implementation ThemeImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //在此处接收通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}

- (void)setThemeImage:(NSString *)themeImage
{
    
    if (![_themeImage isEqualToString:themeImage]) {
        
        _themeImage = [themeImage copy];
        [self loadImage];
    }
    
}

- (void)themeDidChange:(NSNotification*)notficition{
    
    [self loadImage];
    
}

- (void)loadImage
{
    //得到管理者对象
    ThemeManger *manger = [ThemeManger shareInstens];
    UIImage *image = [manger getThemeImage:self.themeImage];
    
    UIImage*tempImage = [image  stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapWidth];
    
    if (image!=nil) {
        
        self.image = tempImage;
        
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
