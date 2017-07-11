//
//  TableViewGroupController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/11.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "TableViewGroupController.h"

@interface TableViewGroupController ()

@end

@implementation TableViewGroupController

- (instancetype)initWithStyle:(UITableViewStyle)style{

    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
    TimeModel *model = self.dataList[indexPath.section][indexPath.row];
    //必须设置所显示的行
    cell.timeLabel.indexPath = indexPath;
    NSString *timeText = [self.countDown countDownWithModel:model];
    //在self.countDown不设置为过时自动删除情况下, 滑动过快的时候时间不会闪
    cell.timeLabel.text = timeText;
    if ([cell.timeLabel.text isEqualToString:self.countDown.jj_description]) {
        cell.timeLabel.textColor = [UIColor redColor];
    }else{
    
        cell.timeLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimeModel *model = self.dataList[indexPath.section][indexPath.row];
    [self.countDown deleteReloadDataWithModel:model indexPath:indexPath];
}

- (void)addData{
    
    NSArray *arr = @[@"1496881149",
                     @"1591881249",
                     @"1496881149",
                     @"1596881529",
                     @"1588888888"];
    
    for (int j = 0; j < 50; j ++) {
        NSMutableArray *arrM = [NSMutableArray array];
        for (int i = 0; i < arr.count; i ++) {
            
            TimeModel *model = [TimeModel new];
            model.endTime = arr[i];
            [arrM addObject:model];
        }
        
        [self.dataList addObject:arrM];
    }
    
}

- (ZJJTimeCountDown *)countDown{
    
    ZJJTimeCountDown *countDown = [super countDown];
    countDown.jj_description = @"活动已经结束了！😄😄";
    //时间戳
    countDown.timeStyle = ZJJCountDownTimeStyleTamp;
    return countDown;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
