//
//  WeiboAnnotationView.m
//  子微帆博day1
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboAnnotationView.h"

@implementation WeiboAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, 100, 40);
        [self _creatViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, 100, 40);
        [self _creatViews];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, 100, 40);
        [self _creatViews];
    }
    return self;
}
- (void)_creatViews
{
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _headImageView.image = [UIImage imageNamed:@"image5"];
    [self addSubview:_headImageView];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 40)];
    _textLabel.backgroundColor = [UIColor lightGrayColor];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.numberOfLines = 3;
    _textLabel.text = @"刚";
    
    [self addSubview:_textLabel];
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    
//    WeiboAnotation *annotation = self.annotation;
//    WeiBoModel *model = annotation.weiboModel;
//    
//    _textLabel.text = model.text;
//    
//    
//    NSString *urlStr = model.userModel.profile_image_url;
//    
//    [_headImageView setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"icon"]];
//    
//}
@end
