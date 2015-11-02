//
//  LeftViewController.m
//  子微帆博day1
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "LeftViewController.h"
#import "ThemeLable.h"
#import "ThemeManger.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_sectionTitle;
    NSArray*_rowTitle;
    UITableView *table;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    
    table.delegate = self;
    table.dataSource = self;
    table.backgroundView = nil;
    table.backgroundColor = nil;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rushTable) name:kThemeDidChangeNotificationName object:nil];
    
    
    [self.view addSubview:table];
    
    _rowTitle = @[@[@"无",@"偏移",@"偏移&缩放",@"旋转",@"视差"],@[@"小图",@"大图"]];
}

- (void)rushTable
{
    [table reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 5;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString*liefCell = @"leftCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liefCell ];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:liefCell];
    }
    
    
    cell.textLabel.text = _rowTitle[indexPath.section][indexPath.row];
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 50;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ThemeLable *lable = [[ThemeLable alloc]initWithFrame:CGRectMake(0, 0, 160, 50)];
    
   // NSLog(@"头视图字体");
    [lable setThemeName:@"More_Item_Text_color"];
    
    lable.backgroundColor = [UIColor clearColor];
    if (section == 0) {
        
        
        lable.text = @" 切换界面效果";
        return lable;
    }
    
       lable.text = @" 图片浏览模式";
    return lable;
}
@end
