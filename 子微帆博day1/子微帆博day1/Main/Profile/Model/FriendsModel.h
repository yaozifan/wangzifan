//
//  FriendsModel.h
//  子微帆博day1
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseModel.h"

@interface FriendsModel : BaseModel
@property (nonatomic,copy) NSString*profile_image_url;
@property (nonatomic,copy) NSString*screen_name;
@property (nonatomic,assign) NSString* followers_count;

@end
