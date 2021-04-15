//
//  ZJJTimeCountDownButton.m
//  ZJJCountDown
//
//  Created by weiqu on 2021/4/14.
//  Copyright © 2021 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDownButton.h"
#import "ZJJTimeCountDownLabel.h"
#import "ZJJTimeCountDown.h"
#import "ZJJTimeCountDownDateTool.h"

@interface ZJJTimeCountDownButton ()<ZJJTimeCountDownDelegate>{

    NSString *_title;
    NSString *_countDownTitle;
    NSString *_replaceCharacter;
    UIColor *_downBorderColor;
    UIColor *_borderColor;
    ZJJTimeCountDown *_countDown;
    ZJJTimeCountDownButtonHandler _countDownButtonHandler;
    UIColor *_defaultTitleColor;
    UIColor *_defaultBackgroundColor;
    BOOL _isSS; //小于10时，前面是否补0，YES表示补0
}

@end

@implementation ZJJTimeCountDownButton

/**
 设置按钮的文本
 
 @param title 正常状态的文本
 @param countDownTitle 倒计时的文本，含有 replaceCharacter 值
 @param replaceCharacter 倒计时时间替换的字符串
 @param isSS  小于10时，前面是否补0，YES表示补0
 */
- (void)setTitle:(NSString *)title countDownTitle:(NSString *)countDownTitle replaceCharacter:(NSString *)replaceCharacter isSS:(BOOL)isSS{
    _title = title;
    _countDownTitle = countDownTitle;
    _replaceCharacter = replaceCharacter;
    _isSS = isSS;
    [self setupButtonTitle:0];
}
/**
 设置按钮的圆角
 
 @param radius 圆角半径
 */
- (void)setCornerRadius:(CGFloat)radius{
    [self setCornerRadius:radius downBorderColor:nil borderColor:nil borderWidth:0];
}
/**
 设置按钮的圆角
 
 @param radius 圆角半径
 @param downBorderColor 倒计时的线框颜色
 @param borderColor 未倒计时的线框颜色
 @param borderWidth  线框的宽度
 */
- (void)setCornerRadius:(CGFloat)radius downBorderColor:(UIColor *)downBorderColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = borderWidth;
    if (borderColor != nil) {
        self.layer.borderColor = borderColor.CGColor;
    }else{
        self.layer.borderColor = UIColor.clearColor.CGColor;
    }
    _downBorderColor = downBorderColor;
    _borderColor = borderColor;
    
}
/**
 开始倒计时
 
 @param totalSecond 总时间
 @param handler 回调函数
 */
- (void)startCountDownWidthSecond:(NSInteger)totalSecond handler:(ZJJTimeCountDownButtonHandler)handler{
    [self startCountDownWidthSecond:totalSecond];
    _countDownButtonHandler = handler;
}
/**
 获取文本的宽度，可以用来动态设置按钮的宽度
 */
- (CGFloat)getTextWidth{
    return [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT,25) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size.width;
}


- (void)startCountDownWidthSecond:(NSInteger)totalSecond{
    if (!_countDown) {
        _countDown = [ZJJTimeCountDown new];
        _countDown.delegate = self;
    }
    _defaultTitleColor = self.titleLabel.textColor;
    _defaultBackgroundColor = self.backgroundColor;
    ZJJTimeCountDownLabel *timeLabel = [ZJJTimeCountDownLabel new];
    [_countDown addTimeLabel:timeLabel time:[ZJJTimeCountDownDateTool dateByAddingSeconds:totalSecond timeStyle:ZJJCountDownTimeStyleNormal]];
    [self setupButtonColor:true];
}


-(UIColor*)getColor:(UIColor * )color defaultColor:(UIColor *)defaultColor{
    if (!color) {
        return defaultColor;
    }
    return  color;
}

- (void)dateWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown{

    NSInteger totalSeconds = timeLabel.totalSeconds;
    if (!totalSeconds) {
        [self setupButtonColor:false];
    }
    
    [self setupButtonTitle:totalSeconds];
    _countDownButtonHandler(self,totalSeconds);
}

- (void)setupButtonColor:(BOOL)isCountDown{
    if (isCountDown) {
        self.userInteractionEnabled = NO;
        UIColor * backGColor = [self getColor:self.downBackgroundColor defaultColor:_defaultBackgroundColor];
        self.backgroundColor = backGColor;
        [self setTitleColor:[self getColor:self.downTitleColor defaultColor:_defaultTitleColor] forState:UIControlStateNormal];
        [self setTitleColor:[self getColor:self.downTitleColor defaultColor:_defaultTitleColor] forState:UIControlStateHighlighted];
        self.layer.borderColor = [self getColor:_downBorderColor defaultColor:UIColor.clearColor].CGColor;
    }else{
        self.userInteractionEnabled = YES;
        UIColor * backGColor = [self getColor:self.normalBackgroundColor defaultColor:_defaultBackgroundColor];
        self.backgroundColor = backGColor;
        [self setTitleColor:[self getColor:self.normalTitleColor defaultColor:_defaultTitleColor] forState:UIControlStateNormal];
        [self setTitleColor:[self getColor:self.normalTitleColor defaultColor:_defaultTitleColor] forState:UIControlStateHighlighted];
        self.layer.borderColor = [self getColor:_borderColor defaultColor:UIColor.clearColor].CGColor;
    }
}

- (void)setupButtonTitle:(NSInteger)totalSeconds{
    
    NSString *btnTitle = _title;
    if (totalSeconds) {
        NSString *secondStr = @"";
        if (_isSS) {
            secondStr = [NSString stringWithFormat:@"%.2ld",totalSeconds];
        }else{
            secondStr = [NSString stringWithFormat:@"%ld",totalSeconds];
        }
        btnTitle = [_countDownTitle stringByReplacingOccurrencesOfString:_replaceCharacter withString:secondStr];
        
    }
    [self setTitle:btnTitle forState:UIControlStateNormal];
    [self setTitle:btnTitle forState:UIControlStateHighlighted];
}


- (void)setNormalTitleColor:(UIColor *)normalTitleColor{
    _normalTitleColor = normalTitleColor;
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self setTitleColor:normalTitleColor forState:UIControlStateHighlighted];
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor{
    _normalBackgroundColor = normalBackgroundColor;
    self.backgroundColor = normalBackgroundColor;
}

- (void)dealloc{
    [_countDown destoryTimer];
}

@end
