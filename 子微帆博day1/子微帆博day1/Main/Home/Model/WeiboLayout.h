//
//  WeiboLayout.h
//  子微帆博day1
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiBoModel.h"

@interface WeiboLayout : NSObject
@property (nonatomic,assign) CGRect textFrame;//微博文字
@property (nonatomic,assign) CGRect srTextFrame;//转发源微博文字
@property (nonatomic,assign) CGRect bgImageFrame;//背景图片
@property (nonatomic,assign) CGRect imgFrame;//微博图片

@property (nonatomic,assign) CGRect frame;//整个weiboView的frame



@property(nonatomic,strong)WeiBoModel* model;

@property (nonatomic,assign) BOOL isDetail;//是否是详情页面布局



@end
