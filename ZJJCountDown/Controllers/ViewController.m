//
//  ViewController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "TableViewGroupController.h"
#import "ZJJCollectionViewController.h"
#import "ZJJTimeCountDownLabel.h"
#import "ZJJVerificationController.h"

@interface ViewController ()<ZJJTimeCountDownDelegate>

@property(nonatomic,strong) ZJJTimeCountDown * countDown;

@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *oneTimeLabel;

@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *twoTimeLabel;
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *threeTimeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oneTimeLabel.jj_description = @"活动已经结束!😄😄";
    self.threeTimeLabel.jj_description = @"😄😄活动已经结束!";
    
    self.countDown.delegate = self;
    //注意⚠️：如果传入非2017-7-12 20:20:20时间格式，要先设置时间格式，在进行视图添加
//    self.countDown.timeStyle = ZJJCountDownTimeStyleNormal;
    [self.countDown addTimeLabel:self.oneTimeLabel time:[self dateByAddingSeconds:-10]];
    [self.countDown addTimeLabel:self.twoTimeLabel time:[self dateByAddingSeconds:25]];
    [self.countDown addTimeLabel:self.threeTimeLabel time:[self dateByAddingSeconds:45]];
    // Do any additional setup after loading the view, typically from a nib.
}


/**
 在当前的时间上追加秒数

 @param seconds 追加秒数
 @return 时间
 */
- (NSString *)dateByAddingSeconds: (NSInteger)seconds{

    NSTimeInterval aTimeInterval = [NSDate timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeStr = [formatter stringFromDate:newDate];
    return timeStr;
}

- (ZJJTimeCountDown *)countDown{
    
    if (!_countDown) {

        _countDown = [[ZJJTimeCountDown alloc] init];
    }
    return _countDown;
}

- (IBAction)tableViewPlainClick:(id)sender {
    
    [self.navigationController pushViewController:[TableViewController new] animated:YES];
}
- (IBAction)tableViewGroupedClick:(id)sender {
    
    [self.navigationController pushViewController:[TableViewGroupController new] animated:YES];
}
- (IBAction)collectionViewClick:(id)sender {
    
       [self.navigationController pushViewController:[ZJJCollectionViewController new] animated:YES];
}
- (IBAction)verificationBtnClick:(id)sender {
    
    ZJJVerificationController *verCon = [[ZJJVerificationController alloc] initWithNibName:NSStringFromClass([ZJJVerificationController class]) bundle:nil];
    [self.navigationController pushViewController:verCon animated:YES];
}

- (void)outDateTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown{

    if ([timeLabel isEqual:self.oneTimeLabel]) {
        self.oneTimeLabel.textColor = [UIColor redColor];
    }
     else if ([timeLabel isEqual:self.twoTimeLabel]) {
        self.twoTimeLabel.textColor = [UIColor orangeColor];
     }else{
         self.threeTimeLabel.textColor = [UIColor greenColor];
     }
   
}



- (void)dealloc{
    [self.countDown destoryTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
