//
//  TableViewCell.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJJTimeCountDownLabel.h"
#import "TimeModel.h"
@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *timeLabel;
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *twoTimeLabel;
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *threeTImeLabel;

@end
