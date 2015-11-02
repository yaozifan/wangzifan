//
//  FriendsCell.m
//  子微帆博day1
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(FriendsModel *)model
{
    if (_model != model) {
        _model = model;
        
        _nameLable.text = _model.screen_name;
        
        NSString*count = [NSString stringWithFormat:@"粉丝数：%@",_model.followers_count];
        
        _friendsLable.text = count;
        
        NSString*icon = _model.profile_image_url;
        [_iconImage setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"image5"]];
        
        
    }
    
    
    
}

@end
