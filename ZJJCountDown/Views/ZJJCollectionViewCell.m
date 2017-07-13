//
//  ZJJCollectionViewCell.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/11.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJCollectionViewCell.h"

@implementation ZJJCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.timeKey = @"endTime";
    
}

@end
