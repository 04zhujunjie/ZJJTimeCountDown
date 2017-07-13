//
//  ZJJOneTimeCountDownLabel.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/12.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJOneTimeCountDownLabel.h"

@implementation ZJJOneTimeCountDownLabel

- (void)setupProperty{

    self.timeKey = @"endTime";
    //设置过时数据自动删除
    self.isAutomaticallyDeleted = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
