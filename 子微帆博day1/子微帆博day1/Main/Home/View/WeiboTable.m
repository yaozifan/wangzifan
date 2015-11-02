//
//  WeiboTable.m
//  子微帆博day1
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboTable.h"
#import "WeiBoModel.h"
#import "WeiboCell.h"
#import "WeiboLayout.h"
#import "DetailController.h"
#import "UIView+Navgation.h"
@implementation WeiboTable
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        
        UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
        
        [self registerNib:nib forCellReuseIdentifier:@"WeiboCell"];
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return _dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCell" forIndexPath:indexPath];
    
    WeiboLayout *model = _dataArray[indexPath.row];
    
    cell.layout = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboLayout *layout = _dataArray[indexPath.row];
    
    return  layout.frame.size.height + 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailController*detail = [[DetailController alloc]init];
    
    WeiboLayout *layout = _dataArray[indexPath.row];
    
    detail.model = layout.model;
    
    [self.viewController.navigationController pushViewController:detail animated:YES];
}


@end
