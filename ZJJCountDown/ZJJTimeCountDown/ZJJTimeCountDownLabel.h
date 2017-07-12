//
//  ZJJTimeCountDownLabel.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJJTimeCountDownLabel;

@interface ZJJTimeCountDownLabel : UILabel

@property (nonatomic ,strong) NSIndexPath *indexPath;

@property (nonatomic ,strong) NSString *jj_description;

@property (nonatomic ,assign) BOOL isAutomaticallyDeleted;

@property (nonatomic ,strong) NSString *timeKey;

- (void)setupProperty;

@end
