//
//  HomeViewController.m
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ThemeImageButton.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "WeiBoModel.h"
#import "WeiboTable.h"
#import "WeiboLayout.h"
#import "BaseNavController.h"
#import "MJRefresh.h"
#import "ThemeImageView.h"
#import "ThemeLable.h"
#import <AudioToolbox/AudioToolbox.h>
@interface HomeViewController ()<SinaWeiboRequestDelegate>
{
    NSMutableArray*_data;
    ThemeImageView *imageView;
    ThemeLable *lable;
    
}
@property(nonatomic,strong)WeiboTable*table;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标签栏上的按钮
//    if ([self.navigationController respondsToSelector:@selector(creatNavButton)]) {
//        
//        [self.navigationController performSelector:@selector(creatNavButton)];
//    }
    _data = [[NSMutableArray alloc]init];
    BaseNavController*nav = (BaseNavController*)self.navigationController;
    
    [nav creatNavButton];
    
   [self creatTableView];
    //加载数据
    [self loadData];
    
    
}

#pragma mark-创建单元格
- (void)creatTableView
{
    _table = [[WeiboTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
    _table.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    
    [self.view addSubview:_table];
}

- (void)loadData
{
   [self showMBProgressHUD:@"请骚等"];
    AppDelegate *appdeleget = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
 
    SinaWeibo *sinaweibo = appdeleget.sinaweibo;
 
    if (appdeleget.sinaweibo.isLoggedIn)
    {
          SinaWeiboRequest*request = [sinaweibo requestWithURL:@"statuses/friends_timeline.json"
                           params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                       httpMethod:@"GET"
                         delegate:self];
        request.dataTag = 100;
    }
    
}

- (void)_loadMoreData//上拉加载更多
{
    //设置MaxID
    AppDelegate *appdeleget = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaweibo = appdeleget.sinaweibo;
    
    if (appdeleget.sinaweibo.isLoggedIn)
    {
        //设置请求参数
        NSMutableDictionary*parms = [[NSMutableDictionary alloc] init];
        [parms setObject:@"10" forKey:@"count"];
        if (_data != 0)
        {
            WeiboLayout *layout = _data.lastObject;
            WeiBoModel *model = layout.model;
            NSString*userID = model.weiboIdStr;
            [parms setObject:userID forKey:@"max_id"];
        }
    SinaWeiboRequest*request = [sinaweibo requestWithURL:@"statuses/friends_timeline.json"
                           params:parms
                       httpMethod:@"GET"
                         delegate:self];
        request.dataTag =101;
    }
}

- (void)_loadNewData//下拉刷新
{
    //设置scincID
    AppDelegate *appdeleget = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaweibo = appdeleget.sinaweibo;
    
    if (appdeleget.sinaweibo.isLoggedIn)
    {
        //设置请求参数
        NSMutableDictionary*parms = [[NSMutableDictionary alloc] init];
        [parms setObject:@"10" forKey:@"count"];
        if (_data.count >0)
        {
            WeiboLayout*layout = _data.firstObject;
            WeiBoModel*model = layout.model;
            NSString*userID = model.weiboIdStr;
            [parms setObject:userID forKey:@"since_id"];
            SinaWeiboRequest*request = [sinaweibo requestWithURL:@"statuses/friends_timeline.json"
                                                          params:parms
                                                      httpMethod:@"GET"
                                                        delegate:self];
            request.dataTag = 102;//得到请求对象，设置请求对象接口属性类似于tag值
        }
    }
}
//此处复写了父类的方法
- (void)leftBarAction
{
    MMDrawerController *mmd = self.mm_drawerController;
    
    [mmd openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)rightBarAction
{
    //或者从aplication中获得MMDrawerController
    
    MMDrawerController *mmd = self.mm_drawerController;//用到了get方法，和导航栏self.navgation类似
    
    [mmd openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
    
}

//数据过来之后的代理方法
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error;
{
    NSLog(@"%@",error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result;
{
    
    NSArray*statuses= result[@"statuses"];
    
    NSMutableArray*dataArray = [[NSMutableArray alloc] initWithCapacity:statuses.count];
    
    for (int i =0; i<statuses.count; i++)
    {
    
        NSDictionary*dic =statuses[i];
        
        WeiboLayout*layout = [[WeiboLayout alloc] init];
        
        layout.model = [[WeiBoModel alloc] initWithDataDic:dic];
        
        [dataArray addObject:layout];
        
    }
    
    if (request.dataTag == 100)
    {
        _data = dataArray;
        [self showMBProgressHUDMod:@"加载完毕"];

    }
    else if (request.dataTag == 101)//下拉加载更多，dataArray等于空，而加载后的第一条微博和data里的最后一条微博重复了，所以需要删除一个
    {
        if (dataArray.count>1)//数组里存储的微博大于一条，第一条不作处理，因为第一条需要删除
        {
            //删除第一条
            [dataArray removeObjectAtIndex:0];
            [_data addObjectsFromArray: dataArray];
        }
    }
    else if(request.dataTag == 102)
    {
        NSRange range = NSMakeRange(0, dataArray.count);
        NSIndexSet*set = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [_data insertObjects:dataArray atIndexes:set];
        
        [self _showImageView:dataArray.count];
    }
    
    if (_data != nil) {
        _table.dataArray = _data;
        [_table reloadData];
    }
    [_table.header endRefreshing];
    [_table.footer endRefreshing];
}


#define mark - 显示未读信息
- (void)_showImageView:(NSInteger)count
{
     
    if(imageView == nil)
    {
        imageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(5, -40, KScreenWidth, 40)];
    
        [imageView setThemeImage:@"timeline_notify.png"];
    
        [self.view addSubview:imageView];
    
        lable = [[ThemeLable alloc]initWithFrame:imageView.bounds];
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [lable setThemeName:@"Timeline_Notice_color"];
    
        [imageView addSubview:lable];
    }
    if (count != 0)
    {
        NSString*str = [NSString stringWithFormat:@"更新了%li条微博",count];
        [lable setText:str];
        
        [UIView animateWithDuration:.6 animations:^{
            imageView.transform = CGAffineTransformMakeTranslation(0, 64+5+40);
        } completion:^(BOOL finished) {
            
             [UIView animateWithDuration:.6 animations:^{
                 [UIView setAnimationDuration:2];
                imageView.transform = CGAffineTransformIdentity;
                
            }];
            
        }];
        NSString*mav = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:mav];
        //注册系统声音
        SystemSoundID shouID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &shouID);
        AudioServicesPlaySystemSound(shouID);
     }
}
@end
