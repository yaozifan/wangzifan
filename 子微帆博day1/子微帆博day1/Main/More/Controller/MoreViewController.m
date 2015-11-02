//
//  MoreViewController.m
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCell.h"
#import "ThemeViewController.h"
#import "AppDelegate.h"
#import "ThemeManger.h"
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView*table;
}
@end

@implementation MoreViewController
//视图每次重新加载时 调用此方法 刷新单元格
- (void)viewWillAppear:(BOOL)animated
{
    [table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    table =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    
    table.delegate = self;
    table.dataSource = self;
   
    [table registerClass:[MoreCell class] forCellReuseIdentifier:@"cell"];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rushCell) name:@"DidLogIn" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rushCell) name:@"DidLogOut" object:nil];

    
    table.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:table];

    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"DidLogIn" object:nil];
 
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"DidLogOut" object:nil];

}
- (void)rushCell
{
    [table reloadData];
}

//设置每一组对单元格数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
    
}
//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;

}
//设置头视图
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            [cell.themeImage setThemeImage:@"more_icon_theme.png"];
            cell.themelable.text = @"主题选择";
            
            ThemeManger*mange = [ThemeManger shareInstens];
        
            cell.nowLable.text = mange.themeName;
        }else if (indexPath.row ==1) {
            [cell.themeImage setThemeImage:@"more_icon_account.png"];
            cell.themelable.text = @"账户管理";

        }
        
    }
    else if (indexPath.section == 1){
        
        [cell.themeImage setThemeImage:@"more_icon_feedback.png"];
        cell.themelable.text = @"意见反馈";

        
    }else if (indexPath.section == 2){

       AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
        if ([appdelegate.sinaweibo isLoggedIn]) {
            
            cell.detailLable.text = @"退出登录";
            cell.loginLable.hidden = YES;
            cell.detailLable.hidden = NO;

        }else{
            cell.loginLable.text = @"请登录";
            cell.detailLable.hidden = YES;
            cell.loginLable.hidden = NO;
        }
    }

    //设置箭头
    if (indexPath.section<2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
           ThemeViewController *theme = [[ThemeViewController alloc]init];
          
          [self.navigationController pushViewController:theme animated:YES];
        }
    }
    
    if (indexPath.section == 2) {

        AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        if ([appdelegate.sinaweibo isLoggedIn]) {
            if (indexPath.row == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定要退出微博"
                                                               message:@"会删除登陆信息"
                                                              delegate:self
                                                     cancelButtonTitle:@"是"
                                                     otherButtonTitles:@"否", nil];
                [alert show];
                return;
                
            }
        }
        
        AppDelegate *appdeleget = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appdeleget.sinaweibo logIn];
        }



}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0) {
        
        AppDelegate *appdeleget = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appdeleget.sinaweibo logOut];
    }
    
}


@end
