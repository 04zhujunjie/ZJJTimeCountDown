//
//  ZJJTimeCountDownDateTool.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/11.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJJTimeCountDown.h"

@interface ZJJTimeCountDownDateTool : NSObject


/**
 转成时间戳

 @param str 时间字符串
 @param timeStyle 时间格式
 @return 时间戳
 */
+ (long long)getTimeTampWithStr:(NSString *)str timeStyle:(ZJJCountDownTimeStyle)timeStyle;

/**
 在当前的时间上追加秒数

 @param seconds 追加秒数
 @param timeStyle 时间格式
 @return 时间字符串
 */
+ (NSString *)dateByAddingSeconds:(NSInteger)seconds timeStyle:(ZJJCountDownTimeStyle)timeStyle;

@end
