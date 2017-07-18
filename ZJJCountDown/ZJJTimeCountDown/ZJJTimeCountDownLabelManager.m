//
//  ZJJTimeCountDownLabelManager.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/14.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDownLabelManager.h"
#import "ZJJTimeCountDownLabel.h"


@interface ZJJTimeCountDownModel:NSObject
@property (nonatomic ,strong) ZJJTimeCountDownLabel *timeLabel;
@property (nonatomic ,strong) NSString *time;
@end

@implementation ZJJTimeCountDownModel
@end

@interface ZJJTimeCountDownLabelManager ()

@property (nonatomic ,strong) NSMutableArray *timeLabelDataList;

@end

@implementation ZJJTimeCountDownLabelManager{

    dispatch_source_t _labelTimer;
}

/**
 添加倒计时，添加后自动启动定时器 ，一般用于页面上可见少量的定时器
 
 @param timeLabel 时间视图
 @param time 时间
 */
- (void)addTimeLabel:(ZJJTimeCountDownLabel *)timeLabel time:(NSString *)time{
    
    if (timeLabel&&time) {
        
        ZJJTimeCountDownModel *model = [[ZJJTimeCountDownModel alloc] init];
        model.timeLabel = timeLabel;
        model.time = time;
        timeLabel.timeKey = @"time";
        [self.timeLabelDataList addObject:model];
    }
    [self startTimer];
}

/**
 启动定时器
 */
- (void)startTimer{
    
    if (_labelTimer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _labelTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_labelTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_labelTimer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setupTimeLabelText];
            });
        });
        dispatch_resume(_labelTimer); // 启动定时器
    }
}

- (void)setupTimeLabelText{
    
    if (!self.timeLabelDataList.count) {
        //销毁定时器
        [self destoryLabelTimer];
        return;
    }
    BOOL isHaveOutDate = NO;
    for (ZJJTimeCountDownModel *model in self.timeLabelDataList) {
        NSAttributedString *timeStr = [self.delegate labelTimeStringWithModel:model timeLabel:model.timeLabel];
        model.timeLabel.attributedText = timeStr;
        //判断该数据时候已经过时
        if ([timeStr.string isEqualToString:model.timeLabel.jj_description]) {
            if ([self.delegate respondsToSelector:@selector(labelOutDateWithTimeLabel:)]) {
                [self.delegate labelOutDateWithTimeLabel:model.timeLabel];
            }
            //将过时的数据移除
            [self.timeLabelDataList removeObject:model];
            isHaveOutDate = YES;
            break;
        }
    }
    if (isHaveOutDate) {
        [self setupTimeLabelText];
    }
}

- (NSMutableArray *)timeLabelDataList{
    
    if (!_timeLabelDataList) {
        _timeLabelDataList = [NSMutableArray array];
    }
    return _timeLabelDataList;
}

- (void)destoryLabelTimer{
    
    if (_labelTimer) {
        dispatch_source_cancel(_labelTimer);
        _labelTimer = nil;
    }
}

@end
