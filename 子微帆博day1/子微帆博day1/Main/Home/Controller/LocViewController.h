//
//  LocViewController.h
//  子微帆博day1
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DataService.h"
@interface LocViewController : BaseViewController
{
    UITableView*_table;
    
    
    CLLocationManager*_manger;
}
@property (nonatomic ,strong) NSArray *dataList;//用来存放 服务器返回的地理位置信息

@end
