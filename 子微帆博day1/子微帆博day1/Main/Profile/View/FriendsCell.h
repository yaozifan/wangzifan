//
//  FriendsCell.h
//  子微帆博day1
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsModel.h"
#import "UIKit+AFNetworking.h"
@interface FriendsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *friendsLable;

@property (nonatomic,strong)FriendsModel*model;


@end
