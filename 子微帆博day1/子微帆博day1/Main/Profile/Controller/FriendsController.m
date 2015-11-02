//
//  FriendsController.m
//  子微帆博day1
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "FriendsController.h"
#import "AppDelegate.h"
#import "FriendsCell.h"
#import "FriendsModel.h"
@interface FriendsController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SinaWeiboRequestDelegate>
{
    NSMutableArray *_dataArray;
    UICollectionView*collection;
}

@end

@implementation FriendsController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
    self.title = @"关注列表";
    _dataArray = [[NSMutableArray alloc] init];
    [self creatCollection];
}

- (void)creatCollection
{
    UICollectionViewFlowLayout*flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake((KScreenWidth-40)/3, (KScreenWidth-40)/3+15);
    //设置四周间隙
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flowLayout];
    collection.showsHorizontalScrollIndicator = NO;
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"FriendsCell" bundle:[NSBundle mainBundle]];
    [collection registerNib:nib forCellWithReuseIdentifier:@"friendsCell"];
    
    [self.view addSubview:collection];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    FriendsCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"friendsCell" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (void)loadData
{
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    SinaWeibo *sina = delegate.sinaweibo;
    
    NSMutableDictionary*mutable = [[NSMutableDictionary alloc] init];
    [mutable setObject:sina.userID forKey:@"uid"];
    [mutable setObject:@"100" forKey:@"count"];
    
    [sina requestWithURL : @"friendships/friends.json"
                  params : mutable
              httpMethod : @"GET"
                delegate : self];
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error;
{
    NSLog(@"%@",error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result;
{
    NSArray*array = result[@"users"];
 //   NSLog(@"%@",result);
    for (NSDictionary*dic in array) {
        
        FriendsModel*model = [[FriendsModel alloc] initWithDataDic:dic];
        
        [_dataArray addObject:model];
    }
    
    [collection reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
