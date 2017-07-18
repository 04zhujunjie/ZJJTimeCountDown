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
#import "ZJJTimeCountDownDateTool.h"

static NSString *const kBtnTitle = @"点击获取验证码";

@interface ZJJVerificationController ()<ZJJTimeCountDownDelegate>{

    ZJJTimeCountDown *_countDown;
}



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
    
    if (!_countDown) {
        _countDown = [ZJJTimeCountDown new];
        _countDown.delegate = self;
    }
    ZJJTimeCountDownLabel *timeLabel = [ZJJTimeCountDownLabel new];
    [_countDown addTimeLabel:timeLabel time:[ZJJTimeCountDownDateTool dateByAddingSeconds:3 timeStyle:ZJJCountDownTimeStyleNormal]];
}


- (void)dateWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown{

    if (timeLabel.totalSeconds) {
        
        [self.verificationBtn setTitle:[NSString stringWithFormat:@"(%.2ld)后可重新获取",timeLabel.totalSeconds] forState:UIControlStateNormal];
        [self.verificationBtn setTitle:[NSString stringWithFormat:@"(%.2ld)后可重新获取",timeLabel.totalSeconds] forState:UIControlStateHighlighted];
        
    }else{
        
        [self.verificationBtn setTitle:kBtnTitle forState:UIControlStateNormal];
        self.verificationBtn.userInteractionEnabled = YES;
    }
}


- (void)dealloc{
    [_countDown destoryTimer];
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
