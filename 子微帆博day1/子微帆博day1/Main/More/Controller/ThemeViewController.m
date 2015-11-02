//
//  ThemeViewController.m
//  子微帆博day1
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManger.h"
#import "MoreCell.h"
@interface ThemeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *keyArray;
    
    UITableView *table;
}
@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    
    
    table.delegate = self;
    table.dataSource = self;
    
    
    [self.view addSubview:table];
    
}


-(void)loadData
{
    NSString*path = [[NSBundle mainBundle]pathForResource:@"theme" ofType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    keyArray = [dic allKeys];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return keyArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[MoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = keyArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = keyArray[indexPath.row];
    
    ThemeManger *manger = [ThemeManger shareInstens];
    
    manger.themeName = str;
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
