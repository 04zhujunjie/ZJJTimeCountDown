//
//  ZJJTimeCountDownLabelManager.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/14.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZJJTimeCountDownLabel;

@protocol ZJJTimeCountDownLabelManagerDelegate <NSObject>


- (NSAttributedString *)labelTimeStringWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel;

- (void)labelOutDateWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel;

@end

@interface ZJJTimeCountDownLabelManager : NSObject

@property (nonatomic ,weak) id <ZJJTimeCountDownLabelManagerDelegate> delegate;

/**
 添加倒计时，添加后自动启动定时器 ，一般用于页面上可见少量的定时器
 
 @param timeLabel 时间视图
 @param time 时间
 */
- (void)addTimeLabel:(ZJJTimeCountDownLabel *)timeLabel time:(NSString *)time;

/**
 销毁定时器
 */
- (void)destoryLabelTimer;

@end
