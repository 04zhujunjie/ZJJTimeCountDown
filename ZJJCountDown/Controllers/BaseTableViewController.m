//
//  BaseTableViewController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/11.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AFNetworking.h"
@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.rowHeight = 80;
    [self setupLess];
}

- (void)setupLess {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://api.k780.com:88/?app=life.time&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        //                NSLog(@"%@",responseObject);
        NSString * webCurrentTimeStr = responseObject[@"result"][@"timestamp"];
        NSInteger webCurrentTime = webCurrentTimeStr.longLongValue;
        NSDate * date = [NSDate date];
        NSInteger nowInteger = [date timeIntervalSince1970];
        
        //注意⚠️：正确业务流程是先算出手机和服务器时间差，在做数据显示
        self.countDown.less = nowInteger - webCurrentTime;
        NSLog(@" --  与服务器时间的差值 -- %zd",self.countDown.less);
        [self addData];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ - 网络错误 ! ",error);
       
        /**
          注意⚠️：正确业务流程是先算出手机和服务器时间差，在做数据显示
          这时只是演示，防止这个请求链接失效，没数据显示
         */
        [self addData];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ZJJTimeCountDown *)countDown{

    if (!_countDown) {
        _countDown = [[ZJJTimeCountDown alloc] initWithScrollView:self.tableView dataList:self.dataList];
        _countDown.delegate = self;
    }
    return _countDown;
}

- (void)addData{

    
}



- (void)dealloc {
    /// 2.销毁
    [_countDown destoryTimer];
}

- (NSMutableArray *)dataList{
    
    if (!_dataList) {
        
        _dataList = [NSMutableArray array];
        
    }
    
    return _dataList;
}



@end
