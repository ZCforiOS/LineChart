//
//  ViewController.m
//  LineChart
//
//  Created by zhangchao on 16/3/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ViewController.h"
#import "ZCLineChart.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray* xArray = [[NSMutableArray alloc] initWithObjects:
    @"2016-02-08 13:14:55",
    @"2016-02-09 14:48:30",
    @"2016-02-10 16:47:23",
    @"2016-02-11 04:17:50",nil];
    
    NSMutableArray* yArray = [[NSMutableArray alloc]init];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithObjects:@[@[@"176",@"177",@"180",@"190"],@"身高"] forKeys:@[@"array",@"title"]];
     NSMutableDictionary* newDict = [[NSMutableDictionary alloc] initWithObjects:@[@[@"50",@"80",@"100",@"220"],@"体重"] forKeys:@[@"array",@"title"]];
    
    
    [yArray addObject:dict];
    [yArray addObject:newDict];
    
    LCLineChartView* chartView = [ZCLineChart drawChartViewBeginTime:@"2016-02-08" EndTime:@"2016-02-11" Rect:CGRectMake(0, 60, self.view.frame.size.width, 200) Unit:@"cm" XArray:xArray YArray:yArray];
    [self.view addSubview:chartView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
