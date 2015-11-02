//
//  CommentUser.h
//  子微帆博day1
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoModel.h"
#import "UIKit+AFNetworking.h"
@interface CommentUser : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *cfLable;
@property (nonatomic,strong)WeiBoModel*model;



@end
