//
//  MoreCell.h
//  子微帆博day1
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeLable.h"
@interface MoreCell : UITableViewCell
@property(nonatomic,strong)ThemeImageView *themeImage;
@property(nonatomic,strong)ThemeLable*themelable ;//选项
@property(nonatomic,strong)ThemeLable*detailLable;//登出
@property(nonatomic,strong)ThemeLable *loginLable;//登录
@property(nonatomic,strong)ThemeLable*nowLable;//当前主题
@end
