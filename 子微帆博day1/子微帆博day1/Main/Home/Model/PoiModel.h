//
//  PoiModel.h
//  子微帆博day1
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseModel.h"
/*
 "poiid": "B2094654D069A6F4419C",
 "title": "三个贵州人(中关村店)",
 "address": "北四环西路58号理想国际大厦202-205",
 "lon": "116.30999",
 "lat": "39.98435",
 "category": "83",
 "city": "0010",
 "province": null,
 "country": null,
 "url": "",
 "phone": "010-82607678",
 "postcode": "100000",
 "weibo_id": "0",
 "categorys": "64 69 83",
 "category_name": "云贵菜",
 "icon": "http://u1.sinaimg.cn/upload/2012/03/23/1/xysh.png",
 */

@interface PoiModel : BaseModel
@property (nonatomic ,copy) NSString *poiid;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *lon;
@property (nonatomic ,copy) NSString *lat;
@property (nonatomic ,copy) NSString *phone;
@property (nonatomic ,copy) NSString *icon;

@end
