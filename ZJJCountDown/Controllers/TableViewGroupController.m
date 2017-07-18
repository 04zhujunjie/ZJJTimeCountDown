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
    [self setupLabelTextWithIndextPath:indexPath model:model cell:cell];
    
   
    if ([cell.timeLabel.attributedText.string isEqualToString:cell.timeLabel.jj_description]) {
        cell.timeLabel.textColor = [UIColor redColor];
    }else{
    
        cell.timeLabel.textColor = [UIColor blackColor];
    }
    
    if ([cell.threeTImeLabel.attributedText.string isEqualToString:cell.threeTImeLabel.jj_description]) {
        cell.threeTImeLabel.textColor = [UIColor blueColor];
    }else{
        
        cell.threeTImeLabel.textColor = [UIColor whiteColor];
    }

    return cell;
}

- (void)setupLabelTextWithIndextPath:(NSIndexPath *)indexPath model:(id)model cell:(TableViewCell *)cell{

    //    //必须设置所显示的行
    cell.timeLabel.indexPath = indexPath;
    //在self.countDown不设置为过时自动删除情况下, 滑动过快的时候时间不会闪
    cell.timeLabel.attributedText = [self.countDown countDownWithModel:model timeLabel:cell.timeLabel];
    
    
    cell.twoTimeLabel.indexPath = indexPath;
    cell.twoTimeLabel.attributedText =  [self.countDown countDownWithModel:model timeLabel:cell.twoTimeLabel];
    
    cell.threeTImeLabel.indexPath = indexPath;
    cell.threeTImeLabel.attributedText = [self.countDown countDownWithModel:model timeLabel:cell.threeTImeLabel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.8];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"  第%ld组/%ld组",section,self.dataList.count];
    return label;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimeModel *model = self.dataList[indexPath.section][indexPath.row];
    [self.countDown deleteReloadDataWithModel:model indexPath:indexPath];
}

- (void)addData{
    
    NSArray *arr = @[
                     @"1591888666",
                     @"1598881266",
                     @"1496682149",
                     @"1566666688",
                     @"1588888888",
                     @"1566666688",];
    
    for (int j = 0; j < 500; j ++) {
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
    //时间格式为时间戳
    countDown.timeStyle = ZJJCountDownTimeStyleTamp;
    return countDown;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
