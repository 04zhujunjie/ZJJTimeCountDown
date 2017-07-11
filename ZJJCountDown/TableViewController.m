//
//  TableViewController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
    TimeModel *model = self.dataList[indexPath.row];
    //必须设置所显示的行
    cell.timeLabel.indexPath = indexPath;
    //在不设置为过时自动删除情况下 滑动过快的时候时间不会闪
    cell.timeLabel.text = [self.countDown countDownWithModel:model];
    return cell;
}




- (ZJJTimeCountDown *)countDown{

    ZJJTimeCountDown *countDown = [super countDown];
    //设置自动删除已经超时数据
    countDown.editingStyle = ZJJCountDownCellEditingAutomaticallyDeleted;
    return countDown;
}

- (void)countDownWithAutomaticallyDeleteModel:(id)model{
    
    NSLog(@"==model:%@===endTime=%@===",model,[model valueForKey:@"endTime"]);
}

- (void)addData{


    NSArray *arr = @[@"2017-2-5 12:10:06",
                      @"2017-3-5 12:10:06",
                      @"2017-4-5 12:10:06",
                      @"2017-5-5 12:10:06",
                      @"2019-6-5 12:10:06",
                      @"2017-7-10 18:6:16",
                      @"2017-8-5 18:10:06",
                      @"2017-9-5 18:10:06",
                     @"2017-10-5 18:10:06",
                     @"2017-7-10 18:6:16",
                     @"2017-8-5 18:10:06",
                     @"2017-9-5 18:10:06",
                     @"2017-10-5 18:10:06",
                     @"2016-7-10 18:6:16",
                     @"2017-8-5 18:10:06",
                     @"2016-9-5 18:10:06",
                     @"2007-10-5 18:10:06",
                     @"2017-4-5 12:10:06",
                     @"2017-5-5 12:10:06",
                     @"2017-6-5 12:10:06",
                     @"2020-7-10 18:6:16"];
    
//    NSArray *arr = @[
//                     @"20170715180616",
//                     @"20170805181006"];
    
    for (int i = 0; i < arr.count; i ++) {
        
        TimeModel *model = [TimeModel new];
        model.endTime = arr[i];
        [self.dataList addObject:model];
    }
    
    //移除过时数据
//    [self removeOutDate];
  
}

//移除过时数据
- (void)removeOutDate{

    for (NSInteger i = self.dataList.count-1; i >= 0; i--) {
        
        TimeModel *model = self.dataList[i];
        if ([self.countDown isOutDateWithModel:model]) {
            [self.dataList removeObject:model];
        }
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
