//
//  ZoomImageView.m
//  子微帆博day1
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ZoomImageView.h"
#import <ImageIO/ImageIO.h>

 
@implementation ZoomImageView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self creatGif];
        self.userInteractionEnabled = YES;
        [self open];
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    
    if (self) {
        
        [self creatGif];
        self.userInteractionEnabled = YES;
        [self open];
       
    }
    return self;
}

- (void)open{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(action)];
    
    
    [self addGestureRecognizer:tap];
    
    self.contentMode = UIViewContentModeScaleAspectFit;
}



- (void)action
{       [self _creatScrllo];
    if ([self.delegate respondsToSelector:@selector(imageWillbig:)]) {
        [self.delegate imageWillbig:self];
    }
        [UIView animateWithDuration:.5 animations:^{
        [self requestDownImage];//发送网络请求
        
        _imageView.frame = _scrollView.frame;
        
    } completion:^(BOOL finished) {
    
             }];
}

- (void)_creatScrllo
{
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _scrollView.backgroundColor = [UIColor blackColor];
    [self.window addSubview:_scrollView];
    

    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _imageView.image = self.image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;//图片放大的
    CGRect rect = [self convertRect:self.bounds toView:self.window];//获得相对于窗口的fram
    
    _imageView.frame = rect;
    
    [_scrollView addSubview:_imageView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    
    [_scrollView addGestureRecognizer:tap];
    [self creatLongTap];

    
}
- (void)close
{
    [UIView animateWithDuration:.5 animations:^{
        
        CGRect fram = [self convertRect:self.bounds toView:self.window];
        _imageView.frame = fram;
        _scrollView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        _scrollView.hidden = YES;
        
        _imageView.top = _scrollView.contentOffset.y;
        
        
        _imageView = nil;
        _scrollView = nil;
    }];
    
}

- (void)requestDownImage
{
    
    if (_fullImageUrlStr.length>0) {
        _hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
        _hud.mode = MBProgressHUDModeDeterminate;
        _hud.progress = 0.0;

        NSURLRequest *ruquest = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_fullImageUrlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
        
        conction = [[NSURLConnection alloc]initWithRequest:ruquest delegate:self];
    }
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    
    NSDictionary *dic = httpResponse.allHeaderFields;
    
    NSString *length = dic[@"Content-Length"];
    _data = [[NSMutableData alloc]init];
    
    _length = [length doubleValue];
    
   // NSLog(@"%@",dic);
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
{
    [_data appendData:data];
    
    double praogress = _data.length/_length;
    _hud.progress = praogress;
    NSLog(@"%f",praogress);
    
}

- (void)isShowGif
{
    //建立图片源
    CGImageSourceRef soure = CGImageSourceCreateWithData((__bridge CFDataRef)_data, NULL);
    //获取图片源中的图片个数
    size_t count = CGImageSourceGetCount(soure);
    
    NSMutableArray*images = [[NSMutableArray alloc] init];
    for (size_t i = 0; i<count; i++) {
        //获取到单张图片
        CGImageRef image = CGImageSourceCreateImageAtIndex(soure, i, NULL);
        UIImage *uiimage = [UIImage imageWithCGImage:image];
        [images addObject:uiimage];
        CGImageRelease(image);
    }
         UIImage *animatedImage = [UIImage animatedImageWithImages:images duration:images.count*0.1];
        _imageView.image = animatedImage;
    

    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
{
    UIImage *image = [UIImage imageWithData:_data];
    _imageView.image = image;
    [_hud removeFromSuperview];
    CGFloat length = image.size.height/image.size.width * KScreenWidth;
    if (length > KScreenHeight) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.height = length;
            _scrollView.contentSize = CGSizeMake(KScreenWidth, length);
        }];
        
    }
    if (_isGif) {
        [self isShowGif];
    }
}

- (void)creatLongTap
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(savePicter:)];
    
    [_scrollView addGestureRecognizer:longPress];
}

- (void)savePicter:(UILongPressGestureRecognizer*)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存照片" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        
        [alert show];
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 0) {
        UIImage *image = _imageView.image;
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    NSLog(@"保存成功");
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    [hud hide:YES afterDelay:1];
    
}

- (void)creatGif
{
    _gifImage.hidden = YES;
    _gifImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _gifImage.image = [UIImage imageNamed:@"timeline_gif.png"];
    [self addSubview:_gifImage];
    
}



@end
