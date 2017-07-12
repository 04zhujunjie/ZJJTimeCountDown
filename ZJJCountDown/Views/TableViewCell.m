//
//  TableViewCell.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ( )


@end

@implementation TableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    self.timeLabel.timeKey = @"startTime";
    self.twoTimeLabel.timeKey = @"endTime";
    self.timeLabel.jj_description = @"活动已经开始";
    self.twoTimeLabel.jj_description = @"活动结束了！😄😄";
    self.twoTimeLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
