//
//  WeiboAnnotationView.h
//  子微帆博day1
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "WeiboAnotation.h"
#import "UIKit+AFNetworking.h"
@interface WeiboAnnotationView : MKAnnotationView
{
    UIImageView *_headImageView;//头像视图
    UILabel *_textLabel; //微博内容
    
}

@end
