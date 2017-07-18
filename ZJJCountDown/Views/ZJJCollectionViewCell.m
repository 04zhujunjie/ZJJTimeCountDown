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
    self.timeLabel.timeKey = @"startTime";
    //边框模式
    self.timeLabel.textStyle = ZJJTextStlyeHHMMSSChineseBox;
    //对齐方式
    self.timeLabel.jj_textAlignment = ZJJTextAlignmentStlyeCenter;
    self.timeLabel.textHeight = 28;
    self.timeLabel.textAdjustsWidthToFitFont = YES;
    //设置间隔符
    self.timeLabel.textIntervalSymbol = @"  ";
    self.timeLabel.textBackgroundInterval = 3;
    self.timeLabel.textBackgroundInterval = 2;
    //整体背景图片
    self.timeLabel.backgroundImage = [UIImage imageNamed:@"timeBackground2"];
    self.timeLabel.font = [UIFont boldSystemFontOfSize:14];
    self.timeLabel.textColor = [UIColor whiteColor];
    //设置单个文本背景图片
    self.timeLabel.textBackgroundImage = [UIImage imageNamed:@"textBackground"];
    //设置圆角
    self.timeLabel.textBackgroundRadius = 2;
    //文本边宽颜色
    self.timeLabel.textBackgroundBorderColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.9];
    //文本边框宽度
    self.timeLabel.textBackgroundBorderWidth = 2;
}

@end
