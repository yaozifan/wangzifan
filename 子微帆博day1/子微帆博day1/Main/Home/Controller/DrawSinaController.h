//
//  DrawSinaController.h
//  子微帆博day1
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeImageButton.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>
@interface DrawSinaController : BaseViewController<ZoomImageDelegate,CLLocationManagerDelegate>
{
    UIView*drawView;
    ThemeImageButton* sendButton;
    UITextView *textView;
    ZoomImageView *zoom;
    //位置管理器
    CLLocationManager *_locationMnager;
    UILabel*_locationLabel;
    
}
@end
