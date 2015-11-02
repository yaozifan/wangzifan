//
//  DetailController.h
//  子微帆博day1
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiBoModel.h"
#import "CommentTable.h"
#import "AppDelegate.h"
@interface DetailController : BaseViewController<SinaWeiboRequestDelegate>
{
    CommentTable *table;
}
@property (nonatomic,strong)WeiBoModel *model;
@property (nonatomic,strong)NSMutableArray *data;//评论数组

@end
