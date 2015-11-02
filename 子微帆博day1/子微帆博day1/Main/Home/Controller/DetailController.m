//
//  DetailController.m
//  子微帆博day1
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "DetailController.h"
#import "BaseNavController.h"
#import "CommentModel.h"
#import "MJRefresh.h"
@implementation DetailController

- (void)viewDidLoad;
{
//    [self creatTable];
//    [self loadData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self creatTable];
    [self loadData];
}
- (void)creatTable
{
        
    table = [[CommentTable alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    table.model = _model;
    table.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reguestHeader)];
    table.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reguestFooter)];
    
    [self.view addSubview:table];
    
}

- (void)reguestHeader
{
    SinaWeibo*weibo = [self sinaWeibo];
    
}

- (void)reguestFooter
{
    SinaWeibo*weibo = [self sinaWeibo];
    
    NSMutableDictionary*dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:_model.weiboIdStr forKey:@"id"];
    
    CommentModel *model = _data.lastObject;
    
    if (model==nil) {
        return;
    }
    NSString*lastID = model.idstr;
    
    [dic setObject:lastID forKey:@"max_id"];
    
     SinaWeiboRequest *request = [weibo requestWithURL:@"comments/show.json"
                                        params:dic
                                    httpMethod:@"GET" delegate:self];
    request.dataTag = 101;

}

- (void)loadData
{
    SinaWeibo*weibo = [self sinaWeibo];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:_model.weiboIdStr forKey:@"id"];
    [dic setObject:@"10" forKey:@"count"];
    SinaWeiboRequest*request = [weibo requestWithURL:@"comments/show.json"
                   params:dic
               httpMethod:@"GET"
                 delegate:self];
    request.dataTag = 100;
    
}

- (SinaWeibo*)sinaWeibo
{
    AppDelegate *deleget = (AppDelegate*)[UIApplication sharedApplication].delegate;
    SinaWeibo*weibo = deleget.sinaweibo;
    return weibo;
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result;
{
    
  //  NSLog(@"==%@",result);
    
    
    if (request.dataTag ==100) {
        
        NSArray*array = result[@"comments"];
        NSMutableArray *comentArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary*dic in array) {
            
            CommentModel*model = [[CommentModel alloc] initWithDataDic:dic];
            
            [comentArray addObject:model];
        }
        
        _data = comentArray;
        table.dataArray = _data;
        [table reloadData];
    }
    else if (request.dataTag == 101)
    {
        NSArray*array = result[@"comments"];
        NSMutableArray *comentArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary*dic in array)
        {
            CommentModel*model = [[CommentModel alloc] initWithDataDic:dic];
            [comentArray addObject:model];
       }
        [_data addObjectsFromArray:comentArray];
        table.dataArray = _data;
        [table reloadData];
        table.commentDic = result;
   }
    [table.footer endRefreshing];
    [table.header endRefreshing];
}

@end
