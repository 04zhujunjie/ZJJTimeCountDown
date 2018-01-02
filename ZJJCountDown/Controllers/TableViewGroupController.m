//
//  TableViewGroupController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/11.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "TableViewGroupController.h"

static NSInteger const kZJJHeaderHeight = 30;
static NSInteger const kZJJFooterHeight = 40;

@interface TableViewGroupController ()
//表格区头数据
@property (nonatomic ,strong) NSMutableArray *headerDatas;
//表格区尾数据
@property (nonatomic ,strong) NSMutableArray *footerDatas;

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

  
    [cell.timeLabel setupCellWithModel:model indexPath:indexPath];
    //在不设置为过时自动删除情况下 滑动过快的时候时间不会闪
    cell.timeLabel.attributedText = [self.countDown countDownWithTimeLabel:cell.timeLabel];
    
    [cell.twoTimeLabel setupCellWithModel:model indexPath:indexPath];
    //在不设置为过时自动删除情况下 滑动过快的时候时间不会闪
    cell.twoTimeLabel.attributedText = [self.countDown countDownWithTimeLabel:cell.twoTimeLabel];
  
    [cell.threeTImeLabel setupCellWithModel:model indexPath:indexPath];
    //在不设置为过时自动删除情况下 滑动过快的时候时间不会闪
    cell.threeTImeLabel.attributedText = [self.countDown countDownWithTimeLabel:cell.threeTImeLabel];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kZJJHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return kZJJFooterHeight;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    id model = self.headerDatas[section];
    ZJJTimeCountDownLabel *label=[[ZJJTimeCountDownLabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kZJJHeaderHeight)];
    label.timeKey = @"startTime";
    label.model = model;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.8];
    label.textColor = [UIColor whiteColor];
    
   return [self.countDown dealWithHeaderView:label viewForHeaderInSection:section];
   
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kZJJFooterHeight)];
    footerView.backgroundColor = [UIColor orangeColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
    label.center = CGPointMake(label.center.x, kZJJFooterHeight/2.0);
    label.text = [NSString stringWithFormat:@"区尾[%ld/%ld]",section,self.footerDatas.count];
    [footerView addSubview:label];
    ZJJTimeCountDownLabel *timeLabel=[[ZJJTimeCountDownLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+5, 0, CGRectGetWidth(self.view.frame)-CGRectGetWidth(label.frame)-25, kZJJHeaderHeight)];
    timeLabel.center = CGPointMake(timeLabel.center.x, kZJJFooterHeight/2.0);
    timeLabel.timeKey = @"startTime";
    id model = self.footerDatas[section];
    timeLabel.model = model;
    timeLabel.textColor = [UIColor whiteColor];
    [footerView addSubview:timeLabel];
    return [self.countDown dealWithFooterView:footerView viewForFooterInSection:section];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeModel *model = self.dataList[indexPath.section][indexPath.row];
    NSArray *deleteSection = self.dataList[indexPath.section];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:deleteSection];
    if (arr.count == 1) {
        //移除区头数据
            [_headerDatas removeObjectAtIndex:indexPath.section];
        //移除区尾数据
            [_footerDatas removeObjectAtIndex:indexPath.section];
    }
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
    for (int i = 0; i < self.dataList.count; i ++) {
        TimeModel *model = [TimeModel new];
        model.startTime = arr[i%6];
        [self.headerDatas addObject:model];
    }
    
    for (int i = 0; i < self.dataList.count; i ++) {
        TimeModel *model = [TimeModel new];
        model.startTime = arr[i%6];
        [self.footerDatas addObject:model];
    }
    
}

- (ZJJTimeCountDown *)countDown{
    
    ZJJTimeCountDown *countDown = [super countDown];
    countDown.delegate = self;
    //时间格式为时间戳
    countDown.timeStyle = ZJJCountDownTimeStyleTamp;
    return countDown;
}

- (NSMutableArray *)headerDatas{
    
    if (!_headerDatas) {
        _headerDatas = [NSMutableArray array];
    }
    return _headerDatas;
}


- (NSMutableArray *)footerDatas{
    
    if (!_footerDatas) {
        _footerDatas = [NSMutableArray array];
    }
    return _footerDatas;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
