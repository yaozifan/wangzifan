//
//  ThemeManger.m
//  子微帆博day1
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ThemeManger.h"

@implementation ThemeManger

+ (ThemeManger*)shareInstens
{
    static ThemeManger *theme = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        theme = [[[self class] alloc]init];
        
    });
    return theme;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        //设置一个初始主题名 此主题名从系统自带的plist文件中读取，每次更改主题名都会更改plist文件中的key值，重新加载文件时就会加载plist文件中最后设置的主题名
        _themeName = [[NSUserDefaults standardUserDefaults] objectForKey:ThemeName];
        
        if (_themeName.length == 0) {
            //当初始主题名为空时，设置一个默认的主题名
            _themeName = @"Blue Moon";
        }
        //读取主题名，获得主题路径，配置文件，放到字典中
        NSString*conFilpath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        
        _themeConfig = [NSDictionary dictionaryWithContentsOfFile:conFilpath];
        
        NSString *themePath = [self themePath];
        
        NSString* colorPath = [themePath stringByAppendingPathComponent:@"config.plist"];
        
        _colorDic = [NSDictionary dictionaryWithContentsOfFile:colorPath];
        
    }
    
    return self;
}

//在主题名的set方法中发送通知
- (void)setThemeName:(NSString *)themeName
{
    if (![_themeName isEqualToString:themeName]) {
        
        _themeName = [themeName copy];

        //保存主题名到plist文件中
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:ThemeName];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        NSString *themePath = [self themePath];
        
        NSString* colorPath = [themePath stringByAppendingPathComponent:@"config.plist"];
        
        _colorDic = [NSDictionary dictionaryWithContentsOfFile:colorPath];
        
        //发送通知  //发送通知给自定义的ui控件中，比如需要改变图片的控制
        [[NSNotificationCenter defaultCenter]postNotificationName:kThemeDidChangeNotificationName object:nil];
        
    }
    
}


- (UIColor*)getThemeColor:(NSString*)colorName
{
    if (colorName.length == 0) {
        return  nil;
    }

    NSDictionary*color = _colorDic[colorName];
    
    CGFloat r = [color[@"R"]floatValue];
    CGFloat g = [color[@"G"]floatValue];
    CGFloat b = [color[@"B"]floatValue];
    CGFloat alpha = 1;
    
    
    if (color[@"alpha"]!=nil) {
        
        alpha = [color[@"alpha"]floatValue];
        
    }
    
    
    UIColor *color1 = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    
    return color1;
}

- (UIImage *)getThemeImage:(NSString *)imageName
{
    
    //得到图片路径 图片路径＋imageName 就是图片的总路径
    //得到主题包路径
    NSString*themPath = [self themePath];
    
    //拼接图片的路径
    NSString*imagePath = [themPath stringByAppendingPathComponent:imageName];
    
    //读取图片 从指定路径读取图片
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];

    return image;
}

//主题包路径获取
- (NSString*)themePath
{
    //获取当前程序主题包的根路径
    NSString*bundlePath = [[NSBundle mainBundle]resourcePath];
    
    //通过字典名字获取 当前主题包的路径
    NSString *themePath = [_themeConfig objectForKey:_themeName];
    
    //拼接成完整的路径
    NSString*path = [bundlePath stringByAppendingPathComponent:themePath];
    
    return path;
}



@end
