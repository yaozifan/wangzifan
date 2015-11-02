//
//  WeiboCell.h
//  子微帆博day1
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoModel.h"
#import "UserModel.h"
#import "WeiboLayout.h"
#import "WeiboView.h"
@interface WeiboCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameImage;
@property (weak, nonatomic) IBOutlet UILabel *rePostLable;//转发
@property (weak, nonatomic) IBOutlet UILabel *commentLable;//评论
@property (weak, nonatomic) IBOutlet UILabel *srLable;//来源

@property(nonatomic,strong)WeiboLayout*layout;

@property(nonatomic,strong)WeiboView*weiboView;
@end
