//
//  ZJJTimeCountDownButton.h
//  ZJJCountDown
//
//  Created by weiqu on 2021/4/14.
//  Copyright © 2021 xiaozhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJJTimeCountDownButton;



typedef void(^ZJJTimeCountDownButtonHandler)(ZJJTimeCountDownButton * countDownButton,NSInteger second);

@interface ZJJTimeCountDownButton : UIButton
/**
 已经开始倒计时的按钮的背景颜色
 */
@property (nonatomic ,strong) UIColor *downBackgroundColor;
/**
 未倒计时的按钮的背景颜色
 */
@property (nonatomic ,strong) UIColor *normalBackgroundColor;

/**
 已经开始倒计时的按钮的字体颜色
 */
@property (nonatomic ,strong) UIColor *downTitleColor;
/**
 未倒计时的按钮的字体颜色
 */
@property (nonatomic ,strong) UIColor *normalTitleColor;

/**
 设置按钮的文本
 
 @param title 正常状态的文本
 @param countDownTitle 倒计时的文本，含有 replaceCharacter 值
 @param replaceCharacter 倒计时时间替换的字符串
 @param isSS  小于10时，前面是否补0，YES表示补0
 */
- (void)setTitle:(NSString *)title countDownTitle:(NSString *)countDownTitle replaceCharacter:(NSString *)replaceCharacter isSS:(BOOL)isSS;

/**
 设置按钮的圆角
 
 @param radius 圆角半径
 */
- (void)setCornerRadius:(CGFloat)radius;
/**
 设置按钮的圆角
 
 @param radius 圆角半径
 @param downBorderColor 倒计时的线框颜色
 @param borderColor 未倒计时的线框颜色
 @param borderWidth  线框的宽度
 */
- (void)setCornerRadius:(CGFloat)radius downBorderColor:(UIColor *)downBorderColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 开始倒计时
 
 @param totalSecond 总时间
 @param handler 回调函数
 */
- (void)startCountDownWidthSecond:(NSInteger)totalSecond handler:(ZJJTimeCountDownButtonHandler)handler;

/**
 获取文本的宽度，可以用来动态设置按钮的宽度
 */
- (CGFloat)getTextWidth;

@end

