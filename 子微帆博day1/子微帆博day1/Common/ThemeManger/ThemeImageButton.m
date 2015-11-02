//
//  ThemeImageButton.m
//  子微帆博day1
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ThemeImageButton.h"
#import "ThemeManger.h"
@implementation ThemeImageButton

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //在此处接收通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
        
    }
    return self;
}

//收到通知后设置图片
- (void)themeDidChange:(NSNotification*)notficition{
    
    [self loadImage];
    
}


//调用set方法时也设置图片
- (void)setStateHeightImage:(NSString *)stateHeightImage
{
    if (_stateHeightImage!= stateHeightImage) {
        
        _stateHeightImage = [stateHeightImage copy];
        ThemeManger *manger = [ThemeManger shareInstens];
        
        UIImage *heightImage = [manger getThemeImage:_stateHeightImage];
        
        if (heightImage!= nil) {
            [self setImage:heightImage forState:UIControlStateHighlighted];
        }
    }
    
}

- (void)setBackThemeImage:(NSString *)backThemeImage
{
    if (_backThemeImage!=backThemeImage) {
        
        _backThemeImage = [backThemeImage copy];
        
        ThemeManger *manger = [ThemeManger shareInstens];
        
        UIImage *backImage = [manger getThemeImage:backThemeImage];
        if (backImage!=nil) {
            [self setBackgroundImage:backImage forState:UIControlStateNormal];
        }
    }

}

- (void)setStateNormalImage:(NSString *)stateNormalImage
{
    if (_stateNormalImage!= stateNormalImage) {
        
        _stateNormalImage = [stateNormalImage copy];
        
        ThemeManger *manger = [ThemeManger shareInstens];
        
        UIImage *normalimage = [manger getThemeImage:_stateNormalImage];
        
        if (normalimage!= nil) {
            [self setImage:normalimage forState:UIControlStateNormal];
        }
    }
}




- (void)loadImage
{
    //得到管理者对象
    ThemeManger *manger = [ThemeManger shareInstens];
    
    //通过管家获得图片
    UIImage *stateNormalimage = [manger getThemeImage:self.stateNormalImage];
    UIImage *heightImage = [manger getThemeImage: _stateHeightImage];
    UIImage *backImage = [manger getThemeImage:_backThemeImage];
    
    
    if (stateNormalimage != nil) {
        
        [self setImage:stateNormalimage forState:UIControlStateNormal];
    }
    if (heightImage != nil) {
        [self setImage:heightImage forState:UIControlStateHighlighted];
    }
    if (backImage != nil) {
        [self setBackgroundImage:backImage forState:UIControlStateNormal];
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
