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


@end
