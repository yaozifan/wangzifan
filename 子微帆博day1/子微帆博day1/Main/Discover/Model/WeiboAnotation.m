//
//  WeiboAnotation.m
//  子微帆博day1
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboAnotation.h"

@implementation WeiboAnotation
- (void)setWeiboModel:(WeiBoModel *)weiboModel{
    _weiboModel = weiboModel;
    NSDictionary *geo = weiboModel.geo;
    
    
    NSArray *coordinates = [geo objectForKey:@"coordinates"];
    if (coordinates.count >= 2) {
        NSString *longitude = coordinates[0];
        NSString *latitude = coordinates[1];
        //设置坐标
        _coordinate = CLLocationCoordinate2DMake([longitude floatValue], [latitude floatValue]);
    }
}

@end
