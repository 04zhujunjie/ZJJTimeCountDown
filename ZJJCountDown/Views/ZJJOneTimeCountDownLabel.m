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
    //设置自定义时间样式，还需要实现ZJJTimeCountDownDelegate自定义文本方法，这样自定义文本才会生效
    self.textStyle = ZJJTextStlyeCustom;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
