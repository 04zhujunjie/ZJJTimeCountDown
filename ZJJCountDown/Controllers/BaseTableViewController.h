//
//  BaseTableViewController.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/11.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJJTimeCountDown.h"
#import "TableViewCell.h"
#import "TimeModel.h"

@interface BaseTableViewController : UITableViewController<ZJJTimeCountDownDelegate>

@property(nonatomic,strong) NSMutableArray *dataList;

@property(nonatomic,strong) ZJJTimeCountDown * countDown;

- (void)addData;

@end
