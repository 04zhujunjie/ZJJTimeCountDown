//
//  ZJJVerificationController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/12.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJVerificationController.h"
#import "ZJJTimeCountDownButton.h"
@interface ZJJVerificationController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidthConstraint;

@property (weak, nonatomic) IBOutlet ZJJTimeCountDownButton *countDownBtn;

@end

@implementation ZJJVerificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countDownBtn.normalTitleColor = UIColor.blackColor;
    self.countDownBtn.normalBackgroundColor = UIColor.grayColor;
    self.countDownBtn.downBackgroundColor = UIColor.greenColor;
    self.countDownBtn.downTitleColor = UIColor.whiteColor;
   
    //设置按钮的圆角，边框的颜色和大小
    [self.countDownBtn setCornerRadius:self.countDownBtn.frame.size.height/2.0 downBorderColor:UIColor.blueColor borderColor:UIColor.blackColor borderWidth:2];
    //设置按钮的文本，isSS表示倒计时小于10时，前面是否补0，YES表示补0
    [self.countDownBtn setTitle:@"点击获取验证码" countDownTitle:@"{}s" replaceCharacter:@"{}" isSS:NO];
    //设置按钮的宽度
    [self setupCountDownBtnWidth];
}


- (IBAction)countDownBtnClick:(ZJJTimeCountDownButton *)sender {
   
    __weak typeof(self) weakSelf = self;
    [sender startCountDownWidthSecond:3 handler:^(ZJJTimeCountDownButton *countDownButton, NSInteger second) {
        __strong typeof(self) strongSelf = weakSelf;
        CGFloat textWidth = [countDownButton getTextWidth];
        NSLog(@"剩余的秒数：%ld===文本的宽度：%lf",second,textWidth);
        //设置按钮的宽度
        [strongSelf setupCountDownBtnWidth];
    }];
}
//设置按钮的宽度
- (void)setupCountDownBtnWidth{
    CGFloat btnWidth = MAX(70, [self.countDownBtn getTextWidth]+25);
    //设置按钮的宽度
    self.btnWidthConstraint.constant = btnWidth;
    
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
