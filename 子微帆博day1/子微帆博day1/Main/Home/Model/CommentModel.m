//
//  CommentModel.m
//  子微帆博day1
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CommentModel.h"
@implementation CommentModel

- (void)setAttributes:(NSDictionary *)dataDic
{
     [super setAttributes:dataDic];
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
    self.user = user;

    NSDictionary *status = [dataDic objectForKey:@"status"];
    WeiBoModel *weibo = [[WeiBoModel alloc] initWithDataDic:status];
    self.weibo = weibo;
    
    NSDictionary *commentDic = [dataDic objectForKey:@"reply_comment"];
    if (commentDic != nil) {
        CommentModel *sourceComment = [[CommentModel alloc] initWithDataDic:commentDic];
        self.sourceComment = sourceComment;
    }
    
    //处理评论中的表情
   // self.text = [Utils parseTextImage:_text];


}

@end
