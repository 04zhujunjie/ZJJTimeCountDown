//
//  ZJJTimeCountDown.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDown.h"
#import "ZJJTimeCountDownDateTool.h"
#import "ZJJTimeCountDownLabelTextStlyeTool.h"
#import "ZJJTimeCountDownCellManager.h"
#import "ZJJTimeCountDownLabelManager.h"

@interface ZJJTimeCountDown ()<ZJJTimeCountDownCellManagerDelegate ,ZJJTimeCountDownLabelManagerDelegate>

@property (nonatomic ,strong) ZJJTimeCountDownLabelManager *labelManager;
@property (nonatomic ,strong) ZJJTimeCountDownCellManager *cellManager;

@end


@implementation ZJJTimeCountDown

#pragma mark ===================动态Cell=================

/**
 初始化
 
 @param scrollView 滑动View ，可以是UITableView 或者 UICollectionView
 @param dataList 数据源
 @return 初始化对象
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView dataList:(NSMutableArray *)dataList{

    self = [super init];
    if (self) {
        _cellManager = [[ZJJTimeCountDownCellManager alloc] initWithScrollView:scrollView dataList:dataList];
        _cellManager.delegate = self;
       
    }
    return self;
}



/**
 
 滑动过快的时候时间不会闪 (UITableViewCell 或者UICollectionViewCell 数据源方法里实现即可)
 
 @param timeLabel 倒计时视图
 @return 显示时间
 */
- (NSAttributedString *)countDownWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel{
    return [self timeStringWithModel:timeLabel.model timeLabel:timeLabel];
}

/**
 对表格区头视图进行处理
 
 @param view 区头视图
 @param section 区头视图位置
 @return 处理后的视图
 */
- (UIView *)dealWithHeaderView:(UIView *)view viewForHeaderInSection:(NSInteger)section{
    
    return [self.cellManager dealWithHeaderView:view viewForHeaderInSection:section];
}

/**
 对表格区尾视图进行处理
 
 @param view 区尾视图
 @param section 区尾视图位置
 @return 处理后的视图
 */
- (UIView *)dealWithFooterView:(UIView *)view viewForFooterInSection:(NSInteger)section{
    return [self.cellManager dealWithFooterView:view viewForFooterInSection:section];
}



//删除cell
- (void)deleteReloadDataWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    [_cellManager deleteReloadDataWithModel:model indexPath:indexPath];
}

#pragma mark ===================ZJJTimeCountDownCellManagerDelegate=================

- (void)cellAutomaticallyDeleteWithModel:(id)model{
    
    if ([self.delegate respondsToSelector:@selector(scrollViewWithAutomaticallyDeleteModel:)]) {
        [self.delegate scrollViewWithAutomaticallyDeleteModel:model];
    }
}

- (NSAttributedString *)cellTimeStringWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel{
    
    return [self timeStringWithModel:model timeLabel:timeLabel];
}


#pragma mark ===================非动态Cell=================


/**
 添加倒计时，添加后自动启动定时器 ，一般用于页面上可见少量的定时器
 
 @param timeLabel 时间视图
 @param time 时间
 */
- (void)addTimeLabel:(ZJJTimeCountDownLabel *)timeLabel time:(NSString *)time{
    [self.labelManager addTimeLabel:timeLabel time:time];
}


- (void)labelOutDateWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel{
    if ([self.delegate respondsToSelector:@selector(outDateTimeLabel:timeCountDown:)]) {
        [self.delegate outDateTimeLabel:timeLabel timeCountDown:self];
    }
}

- (NSAttributedString *)labelTimeStringWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel{
    
    return [self timeStringWithModel:model timeLabel:timeLabel];
}


- (ZJJTimeCountDownLabelManager *)labelManager{
    
    if (!_labelManager) {
        _labelManager = [[ZJJTimeCountDownLabelManager alloc] init];
        _labelManager.delegate = self;
    }
    return _labelManager;
}

/**
 判断该数据是否已经过时
 
 @param model 数据模型
 @return 是否
 */
- (BOOL)isOutDateWithModel:(id)model{

    NSAttributedString *timeStr = [self timeStringWithModel:model];
    if (!timeStr) {
        return YES;
    }
    return NO;
}
- (NSAttributedString *)timeStringWithModel:(id)model{
    return [self timeStringWithModel:model timeLabel:nil];
}
- (NSAttributedString *)timeStringWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel{

    //timeKey一定要设置，在初始化视图时设置或者在设置timeLabel其他属性前设置
    if (!timeLabel.timeKey) {
         NSAssert(NO, @"请查看ZJJTimeCountDownLabel类的timeKey属性是否已经设置，如果设置，请检查是否在视图初始化时设置");
    }
    NSString *serverEndTime = [model valueForKey:timeLabel.timeKey];
    NSDate * sjDate = [NSDate date];   //手机时间
    NSInteger sjInteger = [sjDate timeIntervalSince1970];  // 手机当前时间戳
    long long endTimeTamp = [ZJJTimeCountDownDateTool getTimeTampWithStr:serverEndTime timeStyle:self.timeStyle];
    long long endTime = endTimeTamp + _less;
    return [self getNowTimeWithStartTimeTamp:sjInteger endTimeTamp:endTime timeLabel:timeLabel];
}

- (NSAttributedString *)getNowTimeWithStartTimeTamp:(NSInteger )startTimeTamp endTimeTamp:(long long)endTimeTamp timeLabel:(ZJJTimeCountDownLabel *)timeLabel{
    
    NSTimeInterval timeInterval = endTimeTamp - startTimeTamp;
    //    NSLog(@"%f",timeInterval);
    NSInteger days = (NSInteger)(timeInterval/(3600*24));
    NSInteger hours = (NSInteger)((timeInterval-days*24*3600)/3600);
    NSInteger minutes = (NSInteger)(timeInterval-days*24*3600-hours*3600)/60;
    NSInteger seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    timeLabel.days = days;
    timeLabel.hours = hours;
    timeLabel.minutes = minutes;
    timeLabel.seconds = seconds;
    timeLabel.totalSeconds = (NSInteger)timeInterval;
    
    if ([self.delegate respondsToSelector:@selector(dateWithTimeLabel:timeCountDown:)]) {
        [self.delegate dateWithTimeLabel:timeLabel timeCountDown:self];
    }
    return [self setupLabelTextWithTimeLabel:timeLabel];

}

- (NSAttributedString *)setupLabelTextWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel{

    if (timeLabel.days <= 0&&timeLabel.hours<=0&&timeLabel.minutes<=0&&timeLabel.seconds<=0) {
        timeLabel.days = 0;
        timeLabel.hours = 0;
        timeLabel.minutes = 0;
        timeLabel.seconds = 0;
        if (![ZJJTimeCountDownLabelTextStlyeTool isBoxStyleWithLabel:timeLabel] && timeLabel.days == 0 && timeLabel.hours == 0 && timeLabel.minutes == 0 && timeLabel.seconds ==0 && timeLabel.totalSeconds == 0) {
            
            timeLabel.textFinalValue = [self setupTextWithLabel:timeLabel];
        }
        
        NSAttributedString *finalValue =[[NSAttributedString alloc] initWithString:timeLabel.jj_description];
        return finalValue;
    }
    
    return [self setupTextWithLabel:timeLabel];
}

- (NSAttributedString *)setupTextWithLabel:(ZJJTimeCountDownLabel *)timeLabel{

    if ([self.delegate respondsToSelector:@selector(customTextWithTimeLabel:timeCountDown:)]) {
        NSAttributedString *customizeText = [self.delegate customTextWithTimeLabel:timeLabel timeCountDown:self];
        if (![self isNillWithString:customizeText.string] && timeLabel.textStyle == ZJJTextStlyeCustom) {
            
            return customizeText;
            
        }
    }
    if (timeLabel.days){
        return [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld天 %.2ld小时 %.2ld分 %.2ld秒",(long)timeLabel.days,(long)timeLabel.hours, (long)timeLabel.minutes,(long)timeLabel.seconds]];
    }
    return [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2ld小时 %.2ld分 %.2ld秒",(long)timeLabel.hours, (long)timeLabel.minutes,(long)timeLabel.seconds]];
}



/**
 *  主动销毁定时器
 */
-(void)destoryTimer{
   
    if (_cellManager) {
        [_cellManager destoryScrollViewTimer];
    }
    
    if (_labelManager) {
        [_labelManager destoryLabelTimer];
    }
  
}

- (void)setIsFirstViewForSupView:(BOOL)isFirstViewForSupView{
    _isFirstViewForSupView = isFirstViewForSupView;
    self.cellManager.isFirstViewForSupView = isFirstViewForSupView;
}

- (BOOL)isNillWithString:(NSString *)str{
    
    if (!str || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

-(void)dealloc{
    
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end

