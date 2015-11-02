//
//  NearByViewController.h
//  子微帆博day1
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>

@interface NearByViewController : BaseViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    MKMapView*_mapView;
    CLLocationManager *_locationManager;

}
@end
