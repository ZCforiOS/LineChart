//
//  ZCLineChart.m
//  LineChart
//
//  Created by zhangchao on 16/3/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ZCLineChart.h"
#import "UIColor+Random.h"

#define COLORRGB(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]



@implementation ZCLineChart

+(LCLineChartView *)drawChartViewBeginTime:(NSString *)beginTIme EndTime:(NSString *)endTime Rect:(CGRect)rect Unit:(NSString *)unit XArray:(NSMutableArray *)xArray YArray:(NSMutableArray *)yArray{
    
//    NSMutableArray* colorArray = [[NSMutableArray alloc] initWithObjects:COLORRGB(169, 204, 72),COLORRGB(168, 137, 255),COLORRGB(255, 171, 120),COLORRGB(194, 194, 194),COLORRGB(81, 198, 211), nil];
    NSMutableArray* colorArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [colorArray addObject:[UIColor randomColor]];
    }
    
    NSMutableArray* maxArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i <yArray.count; i++) {
        NSArray* array = [[yArray objectAtIndex:i] objectForKey:@"array"];
        NSInteger max = [[array valueForKeyPath:@"@max.intValue"] intValue];
        [maxArray addObject:[NSString stringWithFormat:@"%ld",max]];
    }
    
    //最大值分5份显示y轴
    NSInteger max = [[maxArray valueForKeyPath:@"@max.intValue"] intValue];
    NSMutableArray* numberArray = [[NSMutableArray alloc] init];
    NSInteger number = ((max/10 + 1)* 10)/5;
    for (NSInteger i = 0; i < 6; i++) {
        NSString* str = [NSString stringWithFormat:@"%ld",number*i];
        [numberArray addObject:str];
    }
    
    //y轴最小值
    NSMutableArray* minArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < yArray.count; i++) {
        NSArray* array = [[yArray objectAtIndex:i] objectForKey:@"array"];
        NSInteger min = [[array valueForKeyPath:@"@min.intValue"] intValue];
        [minArray addObject:[NSString stringWithFormat:@"%ld",min]];
    }
    
    //时间差
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date1 = [dateFormatter dateFromString:beginTIme];
    NSDate *date2 = [dateFormatter dateFromString:endTime];
    
    if ([date1 isEqualToDate:date2]) {
        date1 = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date1 timeIntervalSinceReferenceDate])];
        date2 = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date2 timeIntervalSinceReferenceDate] + 24*3600)];
    }else{
        date2 = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date2 timeIntervalSinceReferenceDate] + 24* 3600)];
    }
    
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    int days = ((int)time)/(3600*24);
    NSString* dateContent = [[NSString alloc] initWithFormat:@"%i天",days];
    
    NSMutableArray* dateArray = [[NSMutableArray alloc] init];
    for (int i = 0; i< [dateContent intValue] + 1; i++) {
        NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents* compontent = nil;
        compontent = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date1];
        NSDateComponents* adCompontent = [[NSDateComponents alloc] init];
        [adCompontent setDay:1*i];
        NSDate* nextDate = [calendar dateByAddingComponents:adCompontent toDate:date1 options:0];
        NSString* nextDateStr = [dateFormatter stringFromDate:nextDate];
        [dateArray addObject:nextDateStr];
    }
    
    //画图
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSDateFormatter* newDateFormatter = [[NSDateFormatter alloc] init];
    [newDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    for (NSInteger i = 0; i < yArray.count; i++) {
        NSArray* newYArray = [yArray[i] objectForKey:@"array"];
        LCLineChartData* lineChart = [LCLineChartData new];
        lineChart.xMin = [date1 timeIntervalSinceReferenceDate];
        lineChart.xMax = [date2 timeIntervalSinceReferenceDate];
        lineChart.title = [yArray[i] objectForKey:@"title"];
        lineChart.color = colorArray[i];
        lineChart.itemCount = xArray.count;
        lineChart.getData = ^(NSUInteger item){
            float x = [[newDateFormatter dateFromString:xArray[item]] timeIntervalSinceReferenceDate];
            float y = [newYArray[item] floatValue];
            NSString* label1 = [NSString stringWithFormat:@"%@",xArray[item]];
            NSString* label2 = [NSString stringWithFormat:@"%@",newYArray[item]];
            return [LCLineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
        };
        [array addObject:lineChart];
    }
    
    LCLineChartView* chartView = [[LCLineChartView alloc] initWithFrame:rect];
    chartView.yMin = 0;
    chartView.yMax = [numberArray[5] integerValue];
    chartView.ySteps = numberArray;
    chartView.data = array;
    
    //单位
    UILabel* unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -15, 200, 21)];
    unitLabel.backgroundColor = [UIColor clearColor];
    unitLabel.textColor = [UIColor grayColor];
    unitLabel.font = [UIFont systemFontOfSize:12.0];
    unitLabel.text = [NSString stringWithFormat:@"单位:%@",unit];
    [chartView addSubview:unitLabel];
    
    UILabel * dateDabel_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 185, 70, 21)];
    dateDabel_1.backgroundColor = [UIColor clearColor];
    dateDabel_1.font = [UIFont systemFontOfSize:12.0f];
    dateDabel_1.text = [dateArray objectAtIndex:0];
    dateDabel_1.textColor = [UIColor grayColor];
    [chartView addSubview:dateDabel_1];
    
    UILabel * dateDabel_2 = [[UILabel alloc] initWithFrame:CGRectMake(135, 185, 70, 21)];
    dateDabel_2.backgroundColor = [UIColor clearColor];
    dateDabel_2.font = [UIFont systemFontOfSize:12.0f];
    dateDabel_2.text = [dateArray objectAtIndex:[dateArray count]/2];
    dateDabel_2.textColor = [UIColor grayColor];
    [chartView addSubview:dateDabel_2];
    
    //..
    CGPoint p = dateDabel_2.center;
    p.x = [UIScreen mainScreen].bounds.size.width/2;
    dateDabel_2.center = p;
    
    
    UILabel * dateDabel_3 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, 185, 70, 21)];
    dateDabel_3.backgroundColor = [UIColor clearColor];
    dateDabel_3.font = [UIFont systemFontOfSize:12.0f];
    dateDabel_3.text = [dateArray objectAtIndex:[dateArray count]-1];
    dateDabel_3.textColor = [UIColor grayColor];
    [chartView addSubview:dateDabel_3];
    
    //只有一个日期的情况下，只显示中间一个时间
    if ([dateArray count]==1) {
        dateDabel_1.hidden = YES;
        dateDabel_3.hidden = YES;
    }else if([dateArray count]==2){
        dateDabel_2.hidden = YES;
    }
    
    return chartView;

    
}
















@end
