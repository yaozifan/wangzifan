//
//  WeiboCell.m
//  子微帆博day1
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+AFNetworking.h"
#import "ThemeManger.h"
@implementation WeiboCell

- (void)awakeFromNib {
    // Initialization code
    
    [self _creatWeiboView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:kThemeDidChangeNotificationName  object:nil];
    
    self.backgroundColor = [UIColor clearColor];
}
- (void)changeColor:(NSNotification*)not
{
    _nameImage.textColor = [[ThemeManger shareInstens] getThemeColor:@"Timeline_Content_color"];
    
    _rePostLable.textColor = [[ThemeManger shareInstens] getThemeColor:@"Timeline_Content_color"];
    
    _commentLable.textColor = [[ThemeManger shareInstens] getThemeColor:@"Timeline_Content_color"];
    _srLable.textColor = [[ThemeManger shareInstens] getThemeColor:@"Timeline_Content_color"];


}

- (void)_creatWeiboView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _weiboView = [[WeiboView alloc] init];
    _weiboView.backgroundColor = [UIColor clearColor];

    
    [self.contentView addSubview:_weiboView];
    
}

- (void)setLayout:(WeiboLayout *)layout
{
    if (_layout !=layout) {
        _layout = layout;
        [self setNeedsLayout];//系统在适当时候调用layoutSubviews
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //
    WeiBoModel*_model = _layout.model;
    
    NSURL *url = [NSURL URLWithString:_model.userModel.profile_image_url];
    [_headImage setImageWithURL:url];
    NSString*repost =  [_model.repostsCount stringValue];
    _rePostLable.text = [NSString stringWithFormat:@"转发：%@",repost];
    NSString*comment = [_model.commentsCount stringValue];
    _commentLable.text = [NSString stringWithFormat:@"评论:%@",comment];
     _nameImage.text = _model.userModel.screen_name;
    _srLable.text = _model.source;
     //单元格要刷新的时候，把布局对象发送给weibboView
    _weiboView.layout = _layout;
    
    _weiboView.frame = _layout.frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
