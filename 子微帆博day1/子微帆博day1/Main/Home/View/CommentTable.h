//
//  CommentTable.h
//  子微帆博day1
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoModel.h"
#import "WeiboView.h"
#import "WeiboLayout.h"
#import "CommentUser.h"
@interface CommentTable : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    UIView*_tableHeardView;
    WeiboView*weiboView;
    CommentUser*user;
}
@property (nonatomic,strong)WeiBoModel *model;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSDictionary*commentDic;

@end
