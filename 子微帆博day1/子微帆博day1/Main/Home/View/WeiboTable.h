//
//  WeiboTable.h
//  子微帆博day1
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTable : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *dataArray;

@end
