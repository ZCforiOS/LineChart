//
//  ZCLineChart.h
//  LineChart
//
//  Created by zhangchao on 16/3/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LCLineChartView.h>

@interface ZCLineChart : NSObject

/**
 *
 *
 *  @param beginTIme 开始时间
 *  @param endTime   结束时间
 *  @param rect      位置
 *  @param unit      单位
 *  @param xArray    x轴数据
 *  @param yArray    y轴数据
 *
 *  @return 
 */
+(LCLineChartView*)drawChartViewBeginTime:(NSString*)beginTIme
                                  EndTime:(NSString*)endTime
                                     Rect:(CGRect)rect
                                     Unit:(NSString*)unit
                                   XArray:(NSMutableArray*)xArray
                                   YArray:(NSMutableArray*)yArray;

@end
