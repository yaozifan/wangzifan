//
//  ProfileViewController.m
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ProfileViewController.h"
#import "WeiboTable.h"
#import "WeiboCell.h"
#import "AppDelegate.h"
#import "ThemeManger.h"
#import "UIKit+AFNetworking.h"
#import "ThemeLable.h"
#import "ThemeImageButton.h"
#import "FollowersController.h"
#import "FriendsController.h"
@interface ProfileViewController ()<SinaWeiboRequestDelegate>
{
    WeiboTable*table;
    UIView*heardView;
}
@property (nonatomic,strong) UIButton *guanzhu;
@property (nonatomic,strong) UIButton *fensi;
@property (nonatomic,strong) UIButton *zilian;
@property (nonatomic,strong) UIButton *more;

@property (nonatomic,strong) UIView *heardView;
@property (nonatomic,strong) UIImageView *profileImage;

@property (nonatomic,strong) ThemeLable *profileName;
@property (nonatomic,strong) ThemeLable *context;
@property (nonatomic,strong) ThemeLable *regeist;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view

    [self creatHeardView];
    
    [self creatTable];
}

- (void)creatHeardView
{
    heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
    
    _profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    _profileName = [[ThemeLable alloc] initWithFrame:CGRectMake(80, 10, 200, 20)];
    [_profileName setThemeName:@"Timeline_Content_color"];
    _context = [[ThemeLable alloc] initWithFrame:CGRectMake(80, 40, 200, 20)];
    _context.font = [UIFont systemFontOfSize:14];
     [_context setThemeName:@"Timeline_Content_color"];
    _regeist = [[ThemeLable alloc] initWithFrame:CGRectMake(80, 60,250, 50)];
     [_regeist setThemeName:@"Timeline_Content_color"];
    _regeist.numberOfLines = 0;
    _regeist.font = [UIFont systemFontOfSize:14];
    
//====================button
    _guanzhu = [UIButton buttonWithType:UIButtonTypeCustom];
    _fensi = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_guanzhu addTarget:self action:@selector(friendsController) forControlEvents:UIControlEventTouchUpInside];
    [_fensi addTarget:self action:@selector(followsController) forControlEvents:UIControlEventTouchUpInside];
    
    _zilian = [UIButton buttonWithType:UIButtonTypeCustom];
    _more = [UIButton buttonWithType:UIButtonTypeCustom];
    _guanzhu.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.3];
    _fensi.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.3];
    _zilian.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.3];
    _more.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.3];
    CGFloat x = (KScreenWidth-50)/4;
    _guanzhu.frame = CGRectMake(10, 110, x, x);
    _fensi.frame = CGRectMake(20+x, 110, x, x);
    ThemeLable*lable1 = [[ThemeLable alloc] initWithFrame:CGRectMake(10, 160, x, 20)];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.text = @"关注";
    [lable1 setThemeName:@"Timeline_Content_color"];
    ThemeLable*lable2 = [[ThemeLable alloc] initWithFrame:CGRectMake(20+x, 160, x, 20)];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.text = @"粉丝";
    [lable2 setThemeName:@"Timeline_Content_color"];
     [heardView addSubview:lable1];
    [heardView addSubview:lable2];
    _zilian.frame = CGRectMake(2*x+30, 110, x, x);
    _more.frame = CGRectMake(3*x+40, 110, x, x);
    [_zilian setTitle:@"资料" forState:UIControlStateNormal];
    [_more setTitle:@"更多" forState:UIControlStateNormal];

    [heardView addSubview:_guanzhu];
    [heardView addSubview:_fensi];
    [heardView addSubview:_zilian];
    [heardView addSubview:_more];
    [heardView addSubview:_profileName];
    [heardView addSubview:_context];
    [heardView addSubview:_regeist];
    [heardView addSubview:_profileImage];
}

- (void)friendsController
{
    FriendsController*friends = [[FriendsController alloc] init];
    
    [self.navigationController pushViewController:friends animated:YES];
}

- (void)followsController
{

    FollowersController *followers = [[FollowersController alloc] init];
    
    [self.navigationController pushViewController:followers animated:YES];
    
}
- (void)creatTable
{
    table = [[WeiboTable alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    
    table.tableHeaderView = heardView;
    
    [self.view addSubview:table];
    [self loadData];
}

- (void)loadData
{
    AppDelegate *appdeleget = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaweibo = appdeleget.sinaweibo;
    
    [sinaweibo requestWithURL:@"statuses/user_timeline.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
}
//数据 过来之后的代理方法
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error;
{
    NSLog(@"%@",error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result;
{
    
    NSArray*statuses= result[@"statuses"];
    
    NSMutableArray*dataArray = [[NSMutableArray alloc]initWithCapacity:statuses.count];
    
    for (int i =0; i<statuses.count; i++)
    {
        NSDictionary*dic =statuses[i];
        
        WeiboLayout*layout = [[WeiboLayout alloc]init];
        
        layout.model = [[WeiBoModel alloc]initWithDataDic:dic];
        
        [dataArray addObject:layout];
    }
    
    NSDictionary*dic = statuses[0];
    NSDictionary*userDic = dic[@"user"];
    self.profileName.text = userDic[@"screen_name"];
    [_profileImage setImageWithURL:[NSURL URLWithString:userDic[@"profile_image_url"]]];
     NSString*gender = userDic[@"gender"];
    if ([gender isEqualToString:@"m"]) {
        gender = @"男";
    }else if([gender isEqualToString:@"f"]){
        gender = @"女";
    }else{
        gender = @"未知";
    }
    NSString*location = userDic[@"location"];
    NSString*description = userDic[@"description"];
    self.context.text = [NSString stringWithFormat:@"%@ %@",gender,location];

    self.regeist.text = [NSString stringWithFormat:@"简介:%@",description];
    
    NSString*guanzhu1 = [NSString stringWithFormat:@"%@",userDic[@"friends_count"]];
    NSString*fensi1 = [NSString stringWithFormat:@"%@",userDic[@"followers_count"]];
    
    [_guanzhu setTitle:guanzhu1  forState:UIControlStateNormal];
    
    [_fensi setTitle:fensi1  forState:UIControlStateNormal];
    
    table.dataArray = dataArray;
    
    [table reloadData];
}




@end
