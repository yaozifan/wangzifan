//
//  CommentCell.h
//  子微帆博day1
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "UIKit+AFNetworking.h"
#import "WXLabel.h"
@interface CommentCell : UITableViewCell<WXLabelDelegate>
{
    WXLabel*_commentLable;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabke;
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (nonatomic,strong) CommentModel *model;

//计算评论单元格的高度
+ (float)getCommentHeight:(CommentModel *)commentModel;


@end
