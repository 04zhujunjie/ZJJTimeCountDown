//
//  ZJJVerificationController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/12.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJVerificationController.h"
#import "ZJJTimeCountDownLabel.h"
#import "ZJJTimeCountDown.h"

static NSString *const kBtnTitle = @"点击获取验证码";

@interface ZJJVerificationController ()<ZJJTimeCountDownDelegate>



@property (weak, nonatomic) IBOutlet UIButton *verificationBtn;

@end

@implementation ZJJVerificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.verificationBtn setTitle:kBtnTitle forState:UIControlStateNormal];
}


- (IBAction)verificationBtn:(id)sender {
    //向服务器发送请求
    [self requestData];
}

- (void)requestData{

    //成功接收服务器数据后，进行倒计时
    if (1) {
        self.verificationBtn.userInteractionEnabled = NO;
        [self addTime];
    }
}

- (void)addTime{
    
    ZJJTimeCountDown * countDown = [ZJJTimeCountDown new];
    countDown.delegate = self;
    [countDown addTimeLabel:[ZJJTimeCountDownLabel new] time:[self dateByAddingSeconds:6]];
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

- (void)dateWithSeconds:(NSInteger)seconds timeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown{

    if (seconds) {

        [self.verificationBtn setTitle:[NSString stringWithFormat:@"(%.2ld)后可重新获取",seconds] forState:UIControlStateNormal];
        [self.verificationBtn setTitle:[NSString stringWithFormat:@"(%.2ld)后可重新获取",seconds] forState:UIControlStateHighlighted];
        
    }else{
    
        [self.verificationBtn setTitle:kBtnTitle forState:UIControlStateNormal];
        self.verificationBtn.userInteractionEnabled = YES;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
