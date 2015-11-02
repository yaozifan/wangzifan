//
//  MoreCell.m
//  子微帆博day1
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MoreCell.h"
#import "ThemeManger.h"
@implementation MoreCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self creatSubViews];
        
        ThemeManger *manger = [ThemeManger shareInstens];
        self.backgroundColor = [manger getThemeColor:@"More_Item_color"];

        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeAction) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
    
}

- (void)themeAction
{
    
    ThemeManger *manger = [ThemeManger shareInstens];
    
    self.backgroundColor = [manger getThemeColor:@"More_Item_color"];
    
   // self.textLabel.textColor = [manger getThemeColor:@"More_Item_Text_color"];
    
}

- (void)creatSubViews
{
    //创建子视图
    //imageView
    
    _themeImage = [[ThemeImageView alloc]initWithFrame:CGRectMake(7, 7, 30, 30)];
    _themeImage.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:_themeImage];
    
    
    
    _themelable = [[ThemeLable alloc]initWithFrame:CGRectMake(44, 7, 150, 30)];
    
    [_themelable setThemeName:@"More_Item_Text_color"];
    
    [self.contentView addSubview:_themelable];
    
    

    
    _detailLable = [[ThemeLable alloc]initWithFrame:CGRectMake(0, 11, KScreenWidth, 20)];
    [_detailLable setThemeName:@"More_Item_Text_color"];
    _detailLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_detailLable];
 
    _nowLable = [[ThemeLable alloc] initWithFrame:CGRectMake(KScreenWidth-120, 12, 95, 20)];
    [_nowLable setThemeName:@"More_Item_Text_color"];
    _nowLable.textAlignment = NSTextAlignmentRight;
    _nowLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nowLable];
    
    _loginLable = [[ThemeLable alloc]initWithFrame:CGRectMake(0, 11, KScreenWidth, 20)];

    _loginLable.textAlignment = NSTextAlignmentCenter;
 
    [_loginLable setThemeName:@"More_Item_Text_color"];
    
    [self.contentView addSubview:_loginLable];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _nowLable.frame = CGRectMake(KScreenWidth-120, 12, 95, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
