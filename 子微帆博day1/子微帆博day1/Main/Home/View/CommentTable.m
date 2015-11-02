//
//  CommentTable.m
//  子微帆博day1
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CommentTable.h"
#import "CommentCell.h"
@implementation CommentTable

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self)
    {    self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        [self _creatHeardView];
        
        UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]];
        
        [self registerNib:nib forCellReuseIdentifier:@"CommentCell"];
    }
    return  self;
}
- (void)setModel:(WeiBoModel *)model
{
    if (_model!=model)
    {
        _model = model;
        
        //创建微博视图的布局对象
        WeiboLayout *layout = [[WeiboLayout alloc] init];
        //isDetail 需要先赋值
        layout.isDetail = YES;
        layout.model = model;
        
        weiboView.layout = layout;
        weiboView.frame = layout.frame;
        weiboView.top = user.bottom + 5;

        //用户视图
        user.model = model;
        //设置头视图的位置
        _tableHeardView.height = weiboView.bottom;
        _tableHeardView.backgroundColor = [UIColor clearColor];
         self.tableHeaderView = _tableHeardView;
    }
}

- (void)_creatHeardView
{
    //头视图包括两方面，一个 个人信息，一个weibo内容
    
    _tableHeardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
    
    _tableHeardView.backgroundColor = [UIColor clearColor];
    
    //加载xib
    
    user = [[[NSBundle mainBundle] loadNibNamed:@"CommentUser" owner:self options:nil]lastObject];
    user.model = self.model;
    [_tableHeardView addSubview:user];
    user.backgroundColor = [UIColor clearColor];
    
    //创建微博视图
    weiboView = [[WeiboView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    weiboView.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [_tableHeardView addSubview:weiboView];
}

// 创建组的头视图
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    //评论数lable
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 10)];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont systemFontOfSize:15];
    lable.textColor = [UIColor blackColor];
    heardView.backgroundColor = [UIColor  colorWithWhite:0.5 alpha:0.1];
    //评论数
    NSNumber*num = _commentDic[@"total_number"];
    int value = [num intValue];
    lable.text = [NSString stringWithFormat:@"评论%d",value];
    [heardView addSubview:lable];
    
    return heardView;
}
//设置组的头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentModel*model = _dataArray[indexPath.row];
    CGFloat height = [CommentCell getCommentHeight:model];
    
    return height;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

   // NSLog(@"%d",[_model.commentsCount intValue]);
    return _dataArray.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


 @end
