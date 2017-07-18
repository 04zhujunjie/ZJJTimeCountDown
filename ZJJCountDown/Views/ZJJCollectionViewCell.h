//
//  ZJJCollectionViewCell.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/11.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJJTimeCountDownLabel.h"
@interface ZJJCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *watchImageView;

@end
