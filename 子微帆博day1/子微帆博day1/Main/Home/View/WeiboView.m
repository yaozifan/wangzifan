//
//  WeiboView.m
//  子微帆博day1
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboView.h"
#import "ThemeManger.h"
@implementation WeiboView

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

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self _createSubView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self _createSubView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}



- (void)changeColor:(NSNotification*)not
{
    _textLabel.textColor = [[ThemeManger shareInstens] getThemeColor:@"Timeline_Content_color"];
      
    _sourceLabel.textColor = [[ThemeManger shareInstens] getThemeColor:@"Timeline_Content_color"];
    
}

//创建对象的方法不能在layoutSubviews中，因为你滑动改变了单元格中的属性，这些对象就会一直重复创建
- (void)_createSubView{
    _textLabel = [[WXLabel alloc] init];
    _textLabel.linespace = 5;//行间距
    _textLabel.font = [UIFont systemFontOfSize:15];
    _sourceLabel = [[WXLabel alloc] init];
    _sourceLabel.linespace = 5;
    _sourceLabel.font = [UIFont systemFontOfSize:13];
    _imgView = [[ZoomImageView alloc] initWithFrame:CGRectZero];//微博图片
    _bgImageView = [[ThemeImageView alloc] init];
    _textLabel.wxLabelDelegate = self;
    _sourceLabel.wxLabelDelegate = self;
    _textLabel.textColor = [[ThemeManger shareInstens] getThemeColor:@"Timeline_Content_color"];
    
    _sourceLabel.textColor = [[ThemeManger shareInstens] getThemeColor:@"Timeline_Content_color"];
    [self addSubview:_bgImageView];
    [self addSubview:_textLabel];
    [self addSubview:_sourceLabel];
    [self addSubview:_imgView];
    
}

- (void)setLayout:(WeiboLayout *)layout
{
    if (_layout !=layout) {
        _layout = layout;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WeiBoModel*model = _layout.model;
    self.frame = _layout.frame;
    _textLabel.text = model.text;
    _textLabel.frame = _layout.textFrame;
    
    
    //是否转发
    if (model.reWeiboModel!=nil) {
        //如果是转发
        _sourceLabel.hidden = NO;
        _bgImageView.hidden = NO;
        //背景图片的fram
        _bgImageView.frame =_layout.bgImageFrame;
        //设置图片的拉伸点
        _bgImageView.topCapWidth = 30;
        _bgImageView.leftCapWidth =30;
        [_bgImageView setThemeImage: @"timeline_rt_border_9.png"];
        
        
        //原微博的fram和内容
        _sourceLabel.frame = _layout.srTextFrame;
        _sourceLabel.text = model.reWeiboModel.text;
        
        //原微博的图片地址
        NSString*imageString =model.reWeiboModel.thumbnailImage;
        if (imageString!=nil)
          {
            _imgView.hidden = NO;
            _imgView.fullImageUrlStr = model.reWeiboModel.originalImage;
            _imgView.frame = _layout.imgFrame;
            [_imgView setImageWithURL:[NSURL URLWithString:imageString]];
          }
        else
          {
            _imgView.hidden = YES;
          }
        
          }
        else
          {
           //没有转发 则隐藏不用的view
            _bgImageView.hidden = YES;
            _sourceLabel.hidden = YES;
        
             //图片地址
             NSString*imageString =model.thumbnailImage;
             if (imageString!=nil)
               {
                _imgView.hidden = NO;
                _imgView.fullImageUrlStr = model.originalImage;
                _imgView.frame = _layout.imgFrame;
                [_imgView setImageWithURL:[NSURL URLWithString:imageString]];
                }
             else
                {
                _imgView.hidden = YES;
                 }
        }
    if (_imgView.hidden == NO)
    {
        UIImageView *gifImage = _imgView.gifImage;
        gifImage.frame = CGRectMake(_imgView.width-24, _imgView.height-24, 24, 24);
        
        NSString *extain;
        if (model.reWeiboModel != nil)
        {//判断字符串是否是gif
            extain = [model.reWeiboModel.thumbnailImage pathExtension];
        }
        else
        {
            extain = [model.thumbnailImage pathExtension];

        }
        if ([extain isEqualToString:@"gif"]) {
            gifImage.hidden = NO;
            _imgView.isGif = YES;
        }else{
            gifImage.hidden = YES;
            _imgView.isGif = NO;
         
        }
 
    }
    
     
}

#pragma mark- wxLabel的代理方法
//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel;
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString*regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}
//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel;
{
    return [[ThemeManger shareInstens] getThemeColor:@"Link_color"];
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel;
{
    return [UIColor blueColor];
}

@end
