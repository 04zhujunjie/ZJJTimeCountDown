//
//  ZJJTimeCountDown.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZJJTimeCountDownLabel.h"

@class ZJJTimeCountDown;

typedef NS_ENUM(NSInteger , ZJJCountDownTimeStyle) {

    //时间格式：2017-7-12 18:06:22
    ZJJCountDownTimeStyleNormal = 0,
    //时间戳：1591881249
    ZJJCountDownTimeStyleTamp,
    //时间格式 20170712180622
    ZJJCountDownTimeStylePureNumber
    
};

@protocol ZJJTimeCountDownDelegate <NSObject>

@optional


/**
 过时的数据自动删除回调方法， 针对UITableView 或者 UICollectionView上的倒计时视图

 @param model 数据模型
 */
- (void)scrollViewWithAutomaticallyDeleteModel:(id)model;


/**
 过时的数据回调方法,回调的数据调用addTimeLabel:(ZJJTimeCountDownLabel *)timeLabel time:(NSString *)time方法所添加数据

 @param timeLabel 倒计时视图
 @param timeCountDown self
 */
- (void)outDateTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown;

/**
 每次执行倒计时，回调方法
 @param timeLabel 倒计时Label
 @param timeCountDown self
 */
- (void)dateWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown;


/**
 自定义时间格式方法 ，需要设置timeLabel的textStyle为ZJJTextStlyeCustom，自定义时间样式才会生效
 如果返回值为nil或者@“”，自定义时间失败，失败后显示原来时间格式
 @param timeLabel 时间label
 @param timeCountDown self
 @return 自定义时间格式字符
 */
- (NSAttributedString *)customTextWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown;

@end

@interface ZJJTimeCountDown : NSObject


// 与服务器时间的差值 手机时间-服务器时间
@property (nonatomic ,assign) NSInteger less;
//时间格式
@property (nonatomic ,assign) ZJJCountDownTimeStyle timeStyle;

@property (nonatomic ,weak) id <ZJJTimeCountDownDelegate> delegate;

@property (nonatomic ,assign) BOOL isFirstViewForSupView;
/**
 添加倒计时，添加后自动启动定时器 ，一般用于页面上可见少量的定时器

 @param timeLabel 时间视图
 @param time 时间
 */
- (void)addTimeLabel:(ZJJTimeCountDownLabel *)timeLabel time:(NSString *)time;

/**
 初始化，针对UITableView 或者 UICollectionView上的倒计时视图

 @param scrollView 滑动View ，可以是UITableView 或者 UICollectionView
 @param dataList 数据源
 @return 初始化对象
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView dataList:(NSMutableArray *)dataList;


/**
 删除数据 针对UITableView 或者 UICollectionView上的倒计时视图

 @param model 数据模型
 @param indexPath 索引位置
 */
- (void)deleteReloadDataWithModel:(id)model indexPath:(NSIndexPath *)indexPath;


/**
 
 滑动过快的时候时间不会闪 (UITableViewCell 或者UICollectionViewCell 数据源方法里实现即可)
 
 @param timeLabel 倒计时视图
 @return 显示时间
 */
- (NSAttributedString *)countDownWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel;

/**
 对表格区头视图进行处理

 @param view 区头视图
 @param section 区头视图位置
 @return 处理后的视图
 */
- (UIView *)dealWithHeaderView:(UIView *)view viewForHeaderInSection:(NSInteger)section;

/**
 对表格区尾视图进行处理
 
 @param view 区尾视图
 @param section 区尾视图位置
 @return 处理后的视图
 */
- (UIView *)dealWithFooterView:(UIView *)view viewForFooterInSection:(NSInteger)section;

/**
 判断该数据是否已经过时

 @param model 数据模型
 @return 是否
 */
- (BOOL)isOutDateWithModel:(id)model;

/**
 注销定时器
 */
- (void)destoryTimer;

@end
