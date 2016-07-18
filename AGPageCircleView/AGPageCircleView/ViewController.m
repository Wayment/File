//
//  ViewController.m
//  AGPageCircleView
//
//  Created by Huiming on 16/7/18.
//  Copyright © 2016年 AppGame. All rights reserved.
//

#import "ViewController.h"
#import "AGPageCircleView.h"
#import "UIView+SDExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    AGPageCircleView *pageView = [[AGPageCircleView alloc] init];
    pageView.frame = CGRectMake(0, 0, self.view.sd_width, 200);
    pageView.imageNameArray = @[@"home_banner_more.jpg", @"userCentre_background.jpg", @"预告提醒750_PxCook", @"http://www.taopic.com/uploads/allimg/120628/201776-12062Q4295216.jpg"];
    
    [self.view addSubview:pageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
