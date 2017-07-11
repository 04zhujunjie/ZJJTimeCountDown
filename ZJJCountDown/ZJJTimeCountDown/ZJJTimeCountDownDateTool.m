//
//  ZJJTimeCountDownDateTool.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/11.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDownDateTool.h"

@implementation ZJJTimeCountDownDateTool


+ (long long)getTimeTampWithNormal:(NSString *)normalTimeStr{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:normalTimeStr];
   long long timeTamp = [date timeIntervalSince1970];
    return timeTamp;
}

+ (long long)getTimeTampWithPureNumber:(NSString *)pureNumberTimeStr{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate* date = [formatter dateFromString:pureNumberTimeStr];
    long long timeTamp = [date timeIntervalSince1970];
    return timeTamp;
}

+ (NSString *)getNowTimeWithStartTimeTamp:(NSInteger )startTimeTamp endTimeTamp:(NSInteger)endTimeTamp description:(NSString *)description{
    
    NSTimeInterval timeInterval = endTimeTamp - startTimeTamp;
    //    NSLog(@"%f",timeInterval);
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (days <= 0&&hours<=0&&minutes<=0&&seconds<=0) {
        return description;
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}

@end
