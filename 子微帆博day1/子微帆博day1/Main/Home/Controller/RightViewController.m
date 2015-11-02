//
//  RightViewController.m
//  子微帆博day1
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeImageButton.h"
#import "DrawSinaController.h"
#import "BaseNavController.h"
#import "LocViewController.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.]
    
    NSArray *imageNames = @[@"newbar_icon_1.png",
                            @"newbar_icon_2.png",
                            @"newbar_icon_3.png",
                            @"newbar_icon_4.png",
                            @"newbar_icon_5.png"];

    
    for (int i = 0; i < 5; i++) {
        ThemeImageButton *button = [[ThemeImageButton alloc]initWithFrame:CGRectMake(20, 64+(i*64), 35, 35)];
        
        NSString*image = imageNames[i];
        
        [button setStateNormalImage:image];
    
        button.tag =i;
        
        [button addTarget:self action:@selector(selectorButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }

}


- (void)selectorButton:(UIButton*)btn
{
    if (btn.tag == 0) {
        DrawSinaController *draw = [[DrawSinaController alloc] init];
        
        draw.title = @"发送微博";
        BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:draw];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
    if (btn.tag == 4) {
        LocViewController*loc = [[LocViewController alloc] init];
        
        BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:loc];
        
        [self presentViewController:nav animated:YES completion:nil];

        
        
    }
    
    
    
    
    
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
