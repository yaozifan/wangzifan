//
//  DiscoverController.m
//  子微帆博day1
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "DiscoverController.h"
#import "NearByViewController.h"
@interface DiscoverController ()

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)womenButton:(UIButton *)sender {
    NearByViewController*near = [[NearByViewController alloc] init];
    
    [self.navigationController pushViewController:near animated:YES];
}
- (IBAction)weiboButton:(UIButton *)sender {
    
    
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
