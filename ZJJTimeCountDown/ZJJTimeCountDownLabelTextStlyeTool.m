//
//  ZJJTimeCountDownLabelTextStlyeTool.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/15.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDownLabelTextStlyeTool.h"


@implementation ZJJTimeCountDownLabelTextStlyeTool

+(NSArray *)getTextArrayWithLabel:(ZJJTimeCountDownLabel *)label{

    NSArray *texts = nil;
    switch (label.textStyle) {
        case ZJJTextStlyeDDHHMMSSBox:{
        
            texts =[self setupLabelTextDDHHMMSSWithLabel:label];
        }
            
            break;
        case ZJJTextStlyeDDHHMMSSChineseBox:{
            
            texts =[self setupLabelTextDDHHMMSSWithLabel:label];
        }
            
            break;
        case ZJJTextStlyeHHMMSSBox:{
            
            texts = [self setupLabelTextHHMMSSWithLabel:label];
        }
            
            break;
        case ZJJTextStlyeHHMMSSChineseBox:{
            texts = [self setupLabelTextHHMMSSWithLabel:label];
        }
            
            break;
        case ZJJTextStlyeMMSSBox:{
            
            texts = [self setupLabelTextMMSSWithLabel:label];
        }
            
            break;
        case ZJJTextStlyeMMSSChineseBox:{
             texts = [self setupLabelTextMMSSWithLabel:label];
        }
            
            break;
        case ZJJTextStlyeSSBox:{
            
             texts = [self setupLabelTextSSWithLabel:label];
            
        }
            
            break;
        case ZJJTextStlyeSSChineseBox:{
            
             texts = [self setupLabelTextSSWithLabel:label];
            
        }
            
            break;

            
        default:
            break;
    }
    
    
    return texts;
}



+ (NSArray *)setupLabelTextDDHHMMSSWithLabel:(ZJJTimeCountDownLabel *)label{
    
    NSMutableArray *textArray = [NSMutableArray array];
    NSString *dayStr;NSString *hourStr;NSString *minuteStr;NSString *secondStr;
    dayStr = [NSString stringWithFormat:@"%.2ld%@",(long)label.days,label.dayAddString];
    hourStr = [NSString stringWithFormat:@"%.2ld%@",(long)label.hours,label.hourAddString];
    minuteStr = [NSString stringWithFormat:@"%.2ld%@",(long)label.minutes,label.minuteAddString];
    secondStr = [NSString stringWithFormat:@"%.2ld%@",(long)label.seconds,label.secondAddString];
    
    if (label.textIntervalSymbol) {
        
        [textArray addObject:dayStr];
        [textArray addObject:label.textIntervalSymbol];
        [textArray addObject:hourStr];
        [textArray addObject:label.textIntervalSymbol];
        [textArray addObject:minuteStr];
        [textArray addObject:label.textIntervalSymbol];
        [textArray addObject:secondStr];
        
    }else{
        
        [textArray addObject:dayStr];
        [textArray addObject:hourStr];
        [textArray addObject:minuteStr];
        [textArray addObject:secondStr];
    }
    
    return textArray;
    
}

+ (NSArray *)setupLabelTextHHMMSSWithLabel:(ZJJTimeCountDownLabel *)label{
    
    NSInteger hours = label.days*24+label.hours;
    NSMutableArray *textArray = [NSMutableArray array];
    NSString *hourStr;NSString *minuteStr;NSString *secondStr;
    
    hourStr = [NSString stringWithFormat:@"%.2ld%@",(long)hours,label.hourAddString];
    minuteStr = [NSString stringWithFormat:@"%.2ld%@",(long)label.minutes,label.minuteAddString];
    secondStr = [NSString stringWithFormat:@"%.2ld%@",(long)label.seconds,label.secondAddString];
    
    if (label.textIntervalSymbol) {
        [textArray addObject:hourStr];
        [textArray addObject:label.textIntervalSymbol];
        [textArray addObject:minuteStr];
        [textArray addObject:label.textIntervalSymbol];
        [textArray addObject:secondStr];
        
    }else{
        [textArray addObject:hourStr];
        [textArray addObject:minuteStr];
        [textArray addObject:secondStr];
    }
    
    return textArray;
    
}

+ (NSArray *)setupLabelTextMMSSWithLabel:(ZJJTimeCountDownLabel *)label{
    
    NSInteger minutes = (label.days*24+label.hours)*60+label.minutes;
    NSMutableArray *textArray = [NSMutableArray array];
    NSString *minuteStr;NSString *secondStr;
    
    minuteStr = [NSString stringWithFormat:@"%.2ld%@",(long)minutes,label.minuteAddString];
    secondStr = [NSString stringWithFormat:@"%.2ld%@",(long)label.seconds,label.secondAddString];
    
    if (label.textIntervalSymbol) {
        [textArray addObject:minuteStr];
        [textArray addObject:label.textIntervalSymbol];
        [textArray addObject:secondStr];
        
    }else{
        [textArray addObject:minuteStr];
        [textArray addObject:secondStr];
    }
    
    return textArray;
    
}

+ (NSArray *)setupLabelTextSSWithLabel:(ZJJTimeCountDownLabel *)label{

    NSMutableArray *textArray = [NSMutableArray array];
    NSString *secondStr;
     secondStr = [NSString stringWithFormat:@"%.2ld%@",(long)label.totalSeconds,label.secondAddString];
    
    if (label.textIntervalSymbol) {

        [textArray addObject:secondStr];
        
    }else{
        [textArray addObject:secondStr];
    }
    
    return textArray;
    
}



+ (BOOL)isBoxStyleWithLabel:(ZJJTimeCountDownLabel *)label{

    if (label.textStyle == ZJJTextStlyeDDHHMMSSBox ||
          label.textStyle == ZJJTextStlyeDDHHMMSSChineseBox||
          label.textStyle == ZJJTextStlyeHHMMSSBox ||
          label.textStyle == ZJJTextStlyeHHMMSSChineseBox||
          label.textStyle == ZJJTextStlyeMMSSBox ||
          label.textStyle == ZJJTextStlyeMMSSChineseBox||
          label.textStyle == ZJJTextStlyeSSBox ||
          label.textStyle == ZJJTextStlyeSSChineseBox) {
       
        return YES;
    }
    return NO;
}

+ (CGRect)textBoxAlignmentRectWithLabel:(ZJJTimeCountDownLabel *)label boxWidth:(CGFloat)boxWidth rect:(CGRect)rect{
    
    CGRect newRext = CGRectMake(0, 0, rect.size.width, rect.size.height);
    switch (label.jj_textAlignment) {
      
        case ZJJTextAlignmentStlyeLeftCenter:
        {
            newRext.origin.x = -label.textBackgroundBorderWidth/2.0;
            newRext.origin.y = [self levelOriginYWithLabel:label];
        }
            break;
        case ZJJTextAlignmentStlyeCenter:
        {
            CGFloat width = CGRectGetWidth(rect);
            if (boxWidth < width) {
                newRext.origin.x = (width-boxWidth)/2.0;
            }
            newRext.origin.y = [self levelOriginYWithLabel:label];
            
        }
            break;
        case ZJJTextAlignmentStlyeLeftTop:
        {
            newRext.origin.x =-label.textBackgroundBorderWidth/2.0;
            newRext.origin.y = -label.textBackgroundBorderWidth/2.0;
        }
            break;
        case ZJJTextAlignmentStlyeCustom:
        {
            newRext.origin.x = label.textLeftDeviation-label.textBackgroundBorderWidth/2.0;
            newRext.origin.y = label.textTopDeviation-label.textBackgroundBorderWidth/2.0;
        }
            break;


        case ZJJTextAlignmentStlyeCenterTop:
        {
            CGFloat width = CGRectGetWidth(rect);
            if (boxWidth < width) {
                newRext.origin.x = (width-boxWidth)/2.0;
            }
            newRext.origin.y = -label.textBackgroundBorderWidth/2.0;
        }
            break;
        case ZJJTextAlignmentStlyeLeftBottom:
        {
            newRext.origin.x = -label.textBackgroundBorderWidth/2.0;
            newRext.origin.y = [self bottomOriginYWithLabel:label];
        }
            break;
        case ZJJTextAlignmentStlyeCenterBottom:
        {
            CGFloat width = CGRectGetWidth(rect);
            if (boxWidth < width) {
                newRext.origin.x = (width-boxWidth+label.textBackgroundBorderWidth)/2.0;
            }
            newRext.origin.y = [self bottomOriginYWithLabel:label];
        }
            break;
        case ZJJTextAlignmentStlyeRightBottom:
        {
           newRext.origin.x = [self rightOriginXWithLabel:label boxWidth:boxWidth];
            newRext.origin.y = [self bottomOriginYWithLabel:label];
        }
            break;
        case ZJJTextAlignmentStlyeRightTop:
        {
           newRext.origin.x = [self rightOriginXWithLabel:label boxWidth:boxWidth];
            newRext.origin.y = -label.textBackgroundBorderWidth/2.0;
        }
            break;
        case ZJJTextAlignmentStlyeCenterRight:
        {
            newRext.origin.x = [self rightOriginXWithLabel:label boxWidth:boxWidth];
           newRext.origin.y = [self levelOriginYWithLabel:label];
        }
            break;
            
        case ZJJTextAlignmentStlyeHorizontalCenter:
        {
           newRext.origin.y = [self levelOriginYWithLabel:label];
            newRext.origin.x = label.textLeftDeviation - label.textBackgroundBorderWidth/2.0;
        }
            break;
            
        case ZJJTextAlignmentStlyeVerticalCenter:
        {
            CGFloat width = CGRectGetWidth(rect);
            if (boxWidth < width) {
                newRext.origin.x = (width-boxWidth)/2.0;
            }
            newRext.origin.y = label.textTopDeviation - label.textBackgroundBorderWidth/2.0;
        }
            break;
            
        default:
            break;
    }
    
    
    return newRext;
}



/**
 获取水平居中，偏离顶部多少

 */
+ (CGFloat)levelOriginYWithLabel:(ZJJTimeCountDownLabel *)label{

    CGFloat originY = 0;
    CGFloat h = label.frame.size.height;
    if (label.textHeight < h) {
        originY = (h - label.textHeight+2)/2.0;
    }
    return originY;
}

+ (CGFloat)bottomOriginYWithLabel:(ZJJTimeCountDownLabel *)label{

    CGFloat originY = 0;
    CGFloat h = label.frame.size.height;
    if (label.textHeight < h) {
        originY = h - label.textHeight+label.textBackgroundBorderWidth/2.0;;
    }
    return originY;
}

+ (CGFloat)rightOriginXWithLabel:(ZJJTimeCountDownLabel *)label boxWidth:(CGFloat)boxWidth{

    CGFloat originX = 0;
    CGFloat width = CGRectGetWidth(label.frame);
    if (boxWidth < width) {
        originX = width-boxWidth+label.textBackgroundBorderWidth/2.0;
    }
    return originX;
}

@end
