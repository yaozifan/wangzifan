//
//  ZoomImageView.h
//  子微帆博day1
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class ZoomImageView;
@protocol ZoomImageDelegate <NSObject>
@optional
//图片将要放大
- (void)imageWillbig:(ZoomImageView*)zoomImage;
- (void)imageWillSmall:(ZoomImageView*)zoomImage;

@end


@interface ZoomImageView : UIImageView<NSURLConnectionDelegate,UIAlertViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    NSURLConnection *conction;
    double _length;
    NSMutableData *_data;
    MBProgressHUD*_hud;
         
}
@property (nonatomic,weak) id<ZoomImageDelegate>delegate;
@property (nonatomic,copy) NSString* fullImageUrlStr;
@property (nonatomic,assign) BOOL isGif;
@property (nonatomic,strong) UIImageView*gifImage;


@end
