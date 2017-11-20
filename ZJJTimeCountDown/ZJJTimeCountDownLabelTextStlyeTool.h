//
//  ZJJTimeCountDownLabelTextStlyeTool.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/15.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJJTimeCountDownLabel.h"

@interface ZJJTimeCountDownLabelTextStlyeTool : NSObject

+(NSArray *)getTextArrayWithLabel:(ZJJTimeCountDownLabel *)label;

+ (BOOL)isBoxStyleWithLabel:(ZJJTimeCountDownLabel *)label;
+ (CGRect)textBoxAlignmentRectWithLabel:(ZJJTimeCountDownLabel *)label boxWidth:(CGFloat)boxWidth rect:(CGRect)rect;

@end
