//
//  NearByViewController.m
//  子微帆博day1
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "NearByViewController.h"
#import "WeiboAnotation.h"
#import "WeiboAnnotationView.h"
#import "DataService.h"
#import "WeiBoModel.h"
@interface NearByViewController ()<MKAnnotation>

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatMap];
    [self _location];
    CLLocationCoordinate2D coordinate = {30.2042,120.2019};
    
    WeiboAnotation *anotation = [[WeiboAnotation alloc] init];
    
    anotation.coordinate = coordinate;
    anotation.title = @"张帅刚";
    anotation.subtitle = @"帅！";
    [_mapView addAnnotation:anotation];
    
}
//得到用户所在位置
- (void)_location
{
    _locationManager =  [[CLLocationManager alloc] init];
    
    if (kVersion >8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation*location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    //停止定位
    [_locationManager stopUpdatingLocation];
    NSString*lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString*lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    
    [self _loadNearByData:lon lat:lat];
    
    //设置显示区域
    //>>02 设置span ,数值越小,精度越高，范围越小
    MKCoordinateSpan span = {0.1,01};
    MKCoordinateRegion region = {coordinate,span};
    [_mapView setRegion:region];
    
}
//获取附近的微博
- (void)_loadNearByData:(NSString*)lon lat:(NSString*)lat
{
    NSMutableDictionary*dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:lon forKey:@"long"];
    [dic setObject:lat forKey:@"lat"];
    
    [DataService requestAFUrl:nearby_timeline
                   httpMethod:@"GET"
                       params:dic
                         data:nil
                        block:^(id result) {
                           
                            NSArray *statuses = [result objectForKey:@"statuses"];
                            NSMutableArray *anno = [[NSMutableArray alloc] init];
                            
                            for (NSDictionary*dic in statuses) {
                                WeiBoModel*model = [[WeiBoModel alloc] initWithDataDic:dic];
                                
                                //创建annotion
                                WeiboAnotation *antation = [[WeiboAnotation alloc] init];
                                
                                antation.weiboModel = model;
                                
                                [anno addObject:antation];
                            }
                            //把annotation添加到mapview
                            [_mapView addAnnotations:anno];
                        }];
}


- (void)creatMap
{
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    //显示用户位置
    _mapView.showsUserLocation = YES;
    //地图显示类型
    _mapView.mapType = MKMapTypeStandard;
    //设置代理
    _mapView.delegate = self;
    //用户跟踪模式
  //  _mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:_mapView];
}
//位置更新后调用
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //获取用户位置
    CLLocation*location = userLocation.location;
    //获取用户地点
    CLLocationCoordinate2D coordinage = location.coordinate;
    
    //获得用户经纬度
    //显示区域
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {coordinage,span};
    
    _mapView.region = region;
    
}
////返回一个标注视图
//- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//    MKPinAnnotationView*pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
//    if (pin == nil)
//    {
//        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
//    }
//    pin.canShowCallout = YES;
//    
//    pin.pinColor = MKPinAnnotationColorPurple;
//    return pin;
//}
//
- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    if ([annotation isKindOfClass:[WeiboAnnotationView class]])
    {
        WeiboAnnotationView*weiboView = (WeiboAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (weiboView == nil)
        {
            weiboView = [[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
        }
        return weiboView;
    }
    return nil;
}

@end
