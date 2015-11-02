//
//  CommentUser.m
//  子微帆博day1
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CommentUser.h"

@implementation CommentUser

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 @property (weak, nonatomic) IBOutlet UIImageView *iconImage;
 @property (weak, nonatomic) IBOutlet UILabel *nameLable;
 @property (weak, nonatomic) IBOutlet UILabel *timeLable;
 @property (weak, nonatomic) IBOutlet UILabel *cfLable;
*/
- (void)setModel:(WeiBoModel *)model
{
    if (_model !=model)
    {
        _model = model;

        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImage.layer.borderWidth = 1;
    _iconImage.layer.cornerRadius = _iconImage.width/2;
    _iconImage.layer.masksToBounds = YES;//遮住圆形以外的东西

    NSString*str = _model.userModel.avatar_large;
    NSURL *url = [NSURL URLWithString:str];
    [_iconImage setImageWithURL:url];
    _nameLable.text = _model.userModel.screen_name;
    _timeLable.text = _model.createDate;
    _cfLable.text = _model.source;
    
}

@end
