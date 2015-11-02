//
//  WeiboAnotation.h
//  子微帆博day1
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "WeiBoModel.h"
@interface WeiboAnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@property (nonatomic,strong) WeiBoModel *weiboModel;


@end
