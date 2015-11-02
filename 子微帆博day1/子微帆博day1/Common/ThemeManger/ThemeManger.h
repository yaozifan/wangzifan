//
//  ThemeManger.h
//  子微帆博day1
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeDidChangeNotificationName  @"kThemeDidChangeNotificationName"
#define ThemeName @"ThemeName"


@interface ThemeManger : NSObject

@property(nonatomic,strong)NSDictionary*colorDic;
@property(nonatomic,copy)NSString*themeName;//主题的文件名字，也就是主题名
@property(nonatomic,strong)NSDictionary *themeConfig;//接收的plist内容

+ (ThemeManger*)shareInstens;//获得单例对象

- (UIImage*)getThemeImage:(NSString*)imageName;//获得图片

- (UIColor*)getThemeColor:(NSString*)colorName;


@end
