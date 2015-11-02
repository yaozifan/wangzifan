//
//  CommentCell.m
//  子微帆博day1
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CommentCell.h"
#import "ThemeManger.h"
@implementation CommentCell


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _commentLable = [[WXLabel alloc] initWithFrame:CGRectZero];
        _commentLable.font = [UIFont systemFontOfSize:14.0f];
        _commentLable.linespace = 5;
        _commentLable.wxLabelDelegate = self;
        [self.contentView addSubview:_commentLable];
        self.backgroundColor = [UIColor clearColor];
        [self setNeedsDisplay];
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _nameLabke.text = _model.user.screen_name;
    
    NSString*url = _model.user.profile_image_url;
    
    [_commentImage setImageWithURL:[NSURL URLWithString:url]];
    //评论内容
    CGFloat height = [WXLabel getTextHeight:14.0f
                                      width:240
                                       text:_model.text
                                  linespace:5];
    
    _commentLable.frame = CGRectMake(_commentImage.right+10, _nameLabke.bottom+5, KScreenWidth-70, height);
    _commentLable.text = _model.text;
}

//返回一个正则表达式，通过此正则表达式查找出需要添加超链接的文本
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    //需要添加连接的字符串的正则表达式：@用户、http://... 、 #话题#
    NSString *regex1 = @"@\\w+"; //@"@[_$]";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#^#+#";  //\w 匹配字母或数字或下划线或汉字
    
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
    
    UIColor *linkColor = [[ThemeManger shareInstens] getThemeColor:@"Link_color"];
    return linkColor;
}

//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel {
    return [UIColor darkGrayColor];
}


//计算评论单元格的高度
+ (float)getCommentHeight:(CommentModel *)commentModel {
    CGFloat height = [WXLabel getTextHeight:14.0f
                                      width:KScreenWidth-70
                                       text:commentModel.text
                                  linespace:5];
    return height+40;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
