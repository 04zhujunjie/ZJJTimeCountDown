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
    [self setupTimeLabelP];
    [self setupTwoLabelP];
    [self setupThreeLabelP];
    
   
}

- (void)setupTimeLabelP{
//    self.timeLabel.timeKey = @"startTime";
    self.timeLabel.jj_description = @"活动已经开始";
    //边框模式
    self.timeLabel.textStyle = ZJJTextStlyeDDHHMMSSChineseBox;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.isRetainFinalValue = YES;
    self.timeLabel.hourAddString = @"小时";
    self.timeLabel.minuteAddString = @"分钟";
    self.timeLabel.secondAddString = @"秒";
    //设置文本高度
    self.timeLabel.textHeight = CGRectGetHeight(self.timeLabel.frame);
    self.timeLabel.textIntervalSymbol = @" ";
    self.timeLabel.textBackgroundInterval = 5;
    //设置自适应文本
    self.timeLabel.textAdjustsWidthToFitFont = YES;
    //设置单个文本背景色为透明色
    self.timeLabel.textBackgroundColor = [UIColor clearColor];
    self.timeLabel.textColor = [UIColor blackColor];
    //整体背景图片
    self.timeLabel.backgroundImage = [UIImage imageNamed:@"money_bg_mask"];
    self.timeLabel.textLeftDeviation = 5;
    //设置整体背景图片拉伸参数
    self.timeLabel.resizableBackgroundImageWithCapInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
}

- (void)setupTwoLabelP{

    self.twoTimeLabel.timeKey = @"endTime";
    self.twoTimeLabel.textStyle = ZJJTextStlyeDDHHMMSSBox;
    self.twoTimeLabel.jj_description = @"活动结束了！😄😄";
    //边框模式
    self.twoTimeLabel.textStyle = ZJJTextStlyeDDHHMMSSChineseBox;
    self.twoTimeLabel.font = [UIFont systemFontOfSize:15];
    self.twoTimeLabel.textAdjustsWidthToFitFont = YES;
    //每个文本背景间隔
    self.twoTimeLabel.textBackgroundInterval = 15;
    self.twoTimeLabel.textHeight = CGRectGetHeight(self.twoTimeLabel.frame);
    //设置间隔符
    self.twoTimeLabel.textIntervalSymbol = @"#";
    self.twoTimeLabel.textColor = [UIColor blackColor];
    self.twoTimeLabel.textIntervalSymbolFont = [UIFont boldSystemFontOfSize:20];
    self.twoTimeLabel.textIntervalSymbolColor = [UIColor lightGrayColor];
    //设置单个文本背景图片
    self.twoTimeLabel.textBackgroundImage = [UIImage imageNamed:@"money_bg_mask"];
    
    //设置单个背景图片拉伸参数
    self.twoTimeLabel.resizableImageWithCapInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    //设置文本距离背景左右边距
    self.twoTimeLabel.textAdjustsWidthLeftRightSide = 10;
    //设置圆角
    self.twoTimeLabel.textBackgroundRadius = 2;
    //文本边宽颜色
    self.twoTimeLabel.textBackgroundBorderColor = [UIColor grayColor];
    //文本边框宽度
    self.twoTimeLabel.textBackgroundBorderWidth = 1;
}

- (void)setupThreeLabelP{

    self.threeTImeLabel.timeKey = @"startTime";
    //设置文本自适应
    self.threeTImeLabel.textAdjustsWidthToFitFont = YES;
    
    //边框模式
    self.threeTImeLabel.textStyle = ZJJTextStlyeDDHHMMSSChineseBox;
    //字体颜色
    self.threeTImeLabel.textColor = [UIColor whiteColor];
    //单个文本背景颜色
    self.threeTImeLabel.textBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    //设置单个文本宽度
    self.threeTImeLabel.textHeight = CGRectGetHeight(self.threeTImeLabel.frame);
    //每个文本背景间隔
    self.threeTImeLabel.textBackgroundInterval = 8;
    //设置文本距离背景左右边距
    self.threeTImeLabel.textAdjustsWidthLeftRightSide = 10;
    //设置圆角
    self.threeTImeLabel.textBackgroundRadius = 5;
    //文本边宽颜色
    self.threeTImeLabel.textBackgroundBorderColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    //文本边框宽度
    self.threeTImeLabel.textBackgroundBorderWidth = 3;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
