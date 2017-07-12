//
//  ZJJTimeCountDownDateTool.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/11.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJJTimeCountDownDateTool : NSObject

+ (long long)getTimeTampWithNormal:(NSString *)normalTimeStr;

+ (long long)getTimeTampWithPureNumber:(NSString *)pureNumberTimeStr;

@end
