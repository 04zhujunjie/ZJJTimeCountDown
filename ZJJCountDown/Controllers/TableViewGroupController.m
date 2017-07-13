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
    UINib*nib = [UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"one"];
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
    NSString *timeText = [self.countDown countDownWithModel:model timeLabel:cell.timeLabel];
    //在self.countDown不设置为过时自动删除情况下, 滑动过快的时候时间不会闪
    cell.timeLabel.text = timeText;
    cell.twoTimeLabel.indexPath = indexPath;
     NSString *twoTimeText = [self.countDown countDownWithModel:model timeLabel:cell.twoTimeLabel];
    cell.twoTimeLabel.text = twoTimeText;
    if ([cell.timeLabel.text isEqualToString:cell.timeLabel.jj_description]) {
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
                     @"1591888666",
                     @"1598881266",
                     @"1496682149",
                     @"1596966688",
                     @"1588888888"];
    
    for (int j = 0; j < 20; j ++) {
        NSMutableArray *arrM = [NSMutableArray array];
        for (int i = 1; i < arr.count; i ++) {
            
            TimeModel *model = [TimeModel new];
            model.startTime = arr[i];
            model.endTime = arr[j%(i+1)];
            [arrM addObject:model];
        }
        
        [self.dataList addObject:arrM];
    }
    
}

- (ZJJTimeCountDown *)countDown{
    
    ZJJTimeCountDown *countDown = [super countDown];
    //时间戳
    countDown.timeStyle = ZJJCountDownTimeStyleTamp;
    return countDown;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
