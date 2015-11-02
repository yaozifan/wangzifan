//
//  ThemeLable.m
//  子微帆博day1
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ThemeLable.h"
#import "ThemeManger.h"
@implementation ThemeLable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getThemeTextColor:) name:kThemeDidChangeNotificationName object:nil];

}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getThemeTextColor:) name:kThemeDidChangeNotificationName object:nil];
        
    }
    return self;
}


- (void)setThemeName:(NSString *)themeName
{
    if(![_themeName isEqualToString:themeName]) {
    
        _themeName = [themeName copy];
    
        [self getImage];
       
    }
}

- (void)getThemeTextColor:(NSNotification*)noti
{
    [self getImage];
}

- (void)getImage
{
    ThemeManger *manger = [ThemeManger shareInstens];
    
    self.textColor = [manger getThemeColor:_themeName];
    
    
}



@end
