//
//  Common.h
//  子微帆博day1
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#ifndef ____day1_Common_h
#define ____day1_Common_h


#define  KScreenWidth   [UIScreen mainScreen].bounds.size.width
#define  KScreenHeight  [UIScreen mainScreen].bounds.size.height



#define kAppKey             @"1098155608"
#define kAppSecret          @"6f1be43df127529be39b96e4e31ffc89"
#define kAppRedirectURI     @"http://www.baidu.com"
#import "UIViewExt.h"


#define unread_count @"remind/unread_count.json"  //未读消息
#define home_timeline @"statuses/home_timeline.json"  //微博列表
#define comments  @"comments/show.json"   //评论列表
#define send_update @"statuses/update.json"  //发微博(不带图片)
#define send_upload @"statuses/upload.json"  //发微博(带图片)
#define geo_to_address @"location/geo/geo_to_address.json"  //查询坐标对应的位置
#define nearby_pois @"place/nearby/pois.json" // 附近商圈
#define nearby_timeline  @"place/nearby_timeline.json" //附近动态



#endif
