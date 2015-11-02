//
//  DrawSinaController.m
//  子微帆博day1
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//
#define kVersion [[UIDevice currentDevice].systemVersion doubleValue]

#import "DrawSinaController.h"
#import "AFNateWorking.h"
#import "DataService.h"
#import "MMDrawerController.h"
 @interface DrawSinaController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation DrawSinaController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
    [self creatButton];
    [self creatView];
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
}
- (void)creatButton
{
    ThemeImageButton *button1 = [[ThemeImageButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button1 addTarget:self action:@selector(backController) forControlEvents:UIControlEventTouchUpInside];
    [button1 setStateNormalImage:@"button_icon_close.png"];
    UIBarButtonItem*close = [[UIBarButtonItem alloc] initWithCustomView:button1];
    [self.navigationItem setLeftBarButtonItem:close];
    
    ThemeImageButton *button2 = [[ThemeImageButton alloc] initWithFrame:CGRectMake(KScreenWidth-44, 0, 44, 44)];
    [button2 addTarget:self action:@selector(sendContext) forControlEvents:UIControlEventTouchUpInside];
    [button2 setStateNormalImage:@"button_icon_ok.png"];
    UIBarButtonItem*send = [[UIBarButtonItem alloc] initWithCustomView:button2];
    [self.navigationItem setRightBarButtonItem:send];
}

- (void)backController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendContext
{
    NSString *text = textView.text;
    NSString*error = nil;
    if (text.length ==0) {
        error = @"微博为空";
    }else if (text.length >140){
        error = @"微博字数大于140";
    }
    if (error!=nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        
        
        AFHTTPRequestOperation *operation = [DataService sendWeibo:text image:zoom.image block:^(id result) {
           // NSLog(@"%@",result);
            [self showTop:@"发送成功" show:YES afnateWoking:operation];

            
        }];
        [self showTop:@"正在发送" show:NO afnateWoking:operation];
        
        //通过UIWindow找到  MMDRawer
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        
//        if ([window.rootViewController isKindOfClass:[MMDrawerController class]]) {
//            MMDrawerController *mmDrawer = (MMDrawerController *)window.rootViewController;
//            
//            [mmDrawer closeDrawerAnimated:YES completion:NULL];
//        }
//        [textView resignFirstResponder];
//
//        [self dismissViewControllerAnimated:YES completion:nil];
//
        /* afnate 发送微博*/
//        NSMutableDictionary*dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:text forKey:@"status"];
//        //0.取得本地保存的token
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSDictionary *sinaweiboInfo = [defaults objectForKey:@"ZIFanSinaWeiboAuthData"];
//        NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
//        
//        //将token添加到请求参数中
//        [dic setObject:accessToken forKey:@"access_token"];
//        
//       [AFNateWorking afNetWorking:@"https://api.weibo.com/2/statuses/update.json" params:dic metod:@"POST" completionBlock:^(id completion) {
//           NSLog(@"发送");
//                   } errorBlock:^(NSError *error) {
//            
//        }];
    }
}

- (void)creatView
{
    drawView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight-50, KScreenWidth, 50)];
     [self.view addSubview:drawView];
    
    //3.创建多个编辑按钮
    NSArray *imgs = @[
                      @"compose_toolbar_1.png",
                      @"compose_toolbar_4.png",
                      @"compose_toolbar_3.png",
                      @"compose_toolbar_5.png",
                      @"compose_toolbar_6.png"
                      ];

    CGFloat x = KScreenWidth/imgs.count;
    for (int i =0; i<imgs.count; i++) {
        
        sendButton = [[ThemeImageButton alloc] initWithFrame:CGRectMake(i*x, 0, x, 50)];
        sendButton.tag = i;
        [sendButton addTarget:self action:@selector(sendButton:) forControlEvents:UIControlEventTouchUpInside];
        [sendButton setStateNormalImage:imgs[i]];
        [drawView addSubview:sendButton];
    }
    //3 创建label 显示位置信息
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    _locationLabel.hidden = YES;
    _locationLabel.font = [UIFont systemFontOfSize:14];
    _locationLabel.backgroundColor = [UIColor grayColor];
    [drawView addSubview:_locationLabel];

    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 140)];
    textView.backgroundColor = [UIColor grayColor];
    
         [self.view addSubview:textView];
}
- (void)sendButton:(UIButton*)btn
{
    //发送图片
    if (btn.tag == 0) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        [actionSheet showInView:self.view];
    }
    
    if (btn.tag == 3) {
        
        if (_locationMnager == nil) {
            _locationMnager = [[CLLocationManager alloc] init];
            
            //判断系统版本信息 ，如果大于8.0 则调用以下方法获取授权
            if (kVersion > 8.0) {
                [_locationMnager requestWhenInUseAuthorization];//使用时候获得授权
            }
        }
        _locationMnager.delegate = self;
        //设置定位精度
        [_locationMnager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        //开始定位
        [_locationMnager startUpdatingLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //停止定位 不停止的话会一直定位
    [manager stopUpdatingLocation];
    //获取地理位置
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;//获取经纬度
    
    NSLog(@"经度%f,纬度%f",coordinate.longitude,coordinate.latitude);
    //地理位置反编码
    //一 新浪位置反编码 接口说明  http://open.weibo.com/wiki/2/location/geo/geo_to_address
    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:coordinateStr forKey:@"coordinate"];
    
    __weak DrawSinaController* drawSelf = self;
    
    [DataService requestAFUrl:geo_to_address httpMethod:@"GET" params:params data:nil block:^(id result) {
        NSArray*ages = [result objectForKey:@"geos"];
        
        if (ages.count>0) {
            NSDictionary*geoDic = [ages lastObject];
            
            NSString*addr = geoDic[@"address"];
            NSLog(@"地址%@",addr);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                __strong DrawSinaController *draw = drawSelf;
                
                draw->_locationLabel.hidden = NO;
                draw->_locationLabel.text = addr;
            });
        }
    }];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    
    UIImagePickerControllerSourceType sourceType;
    
    if (buttonIndex == 0) {//拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamrea = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamrea) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
            [alert show];
        }
        return;
    }else if (buttonIndex == 1){
           sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }else{
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = sourceType;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - 弹出键盘后 通知工具栏调整高度
- (void)keyBoardWillShow:(NSNotification*)not
{
    //取得键盘的fram
 //   NSLog(@"%@",not);
    NSValue *boundsValues = [not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect fram = [boundsValues CGRectValue];
    //键盘的高度
    CGFloat height = fram.size.height;
    //调整视图的高度
    drawView.bottom = KScreenHeight-height;
}
//选择图片后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage*image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //显示缩略图
    if (zoom == nil) {
        
        zoom = [[ZoomImageView alloc] initWithImage:image];
        zoom.delegate = self;
        zoom.frame = CGRectMake(10, textView.bottom+10, 80, 80);
        
        [self.view addSubview:zoom];
        
    }
    zoom.image = image;
        
}//选择图片后关闭键盘
- (void)imageWillbig:(ZoomImageView*)zoomImage;
{
    [textView resignFirstResponder];
}



@end
