//
//  LocViewController.m
//  子微帆博day1
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "LocViewController.h"
#import "PoiModel.h"
@interface LocViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>

@end

@implementation LocViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatButton];
    }
    
    return  self;
    
}

- (void)creatButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"附近商圈";
    [self creatTable];
    
    //定位
    _manger = [[CLLocationManager alloc] init];
    
    if (kVersion >=8.0 ) {
        //请求允许定位
        [_manger requestWhenInUseAuthorization];
    }
    //设置请求的精准度
    [_manger setDistanceFilter:kCLLocationAccuracyNearestTenMeters];
    _manger.delegate = self;
    //开始定位
    [_manger startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
   //停止定位
    [manager stopUpdatingLocation];
    //获取当前的请求设置
    CLLocation *location = [locations lastObject];
    
    NSString *lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];

    //开始加载网络
    [self loadNearByPoisWithlon:lon lat:lat];
}
#pragma mark- 加载网络
- (void)loadNearByPoisWithlon:(NSString *)lon lat:(NSString *)lat
{
    //配置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:lon forKey:@"long"];//经度
    [params setObject:lat forKey:@"lat"];
    [params setObject:@50 forKey:@"count"];

    //请求数据
    //获取附近商家
    [DataService requestUrl:nearby_pois httpMethod:@"GET" params:params block:^(id result) {
        
        NSArray*pois = result[@"pois"];
        NSMutableArray*dataList = [NSMutableArray array];
        for (NSDictionary*dic in pois) {
            // 创建商圈模型对象
            PoiModel *poi = [[PoiModel alloc]initWithDataDic:dic];
            [dataList addObject:poi];
        }
        self.dataList = dataList;
        [_table reloadData];
        
    } ];
    
}

- (void)creatTable
{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    
    [self.view addSubview:_table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return self.dataList.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    // 获取当前单元格对应的商圈对象
    PoiModel *poi = self.dataList[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:poi.icon] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    
    cell.textLabel.text = poi.title;
    
    return cell;
    
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
