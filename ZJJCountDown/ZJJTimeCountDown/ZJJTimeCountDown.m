//
//  ZJJTimeCountDown.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDown.h"
#import "ZJJTimeCountDownDateTool.h"

@interface ZJJTimeCountDownModel:NSObject
@property (nonatomic ,strong) ZJJTimeCountDownLabel *timeLabel;
@property (nonatomic ,strong) NSString *time;
@end

@implementation ZJJTimeCountDownModel
@end

@interface ZJJTimeCountDown ()

@property (nonatomic ,strong) NSMutableArray *timeLabelDataList;

@end


@implementation ZJJTimeCountDown {
    dispatch_source_t _scrollViewTimer;
    dispatch_source_t _labelTimer;
    UIScrollView         *_countDownScrollView ;
    NSMutableArray                *_dataList;
}



/**
 初始化
 
 @param scrollView 滑动View ，可以是UITableView 或者 UICollectionView
 @param dataList 数据源
 @return 初始化对象
 */

- (instancetype)initWithScrollView:(UIScrollView *)scrollView dataList:(NSMutableArray *)dataList{

    self = [super init];
    if (self) {
        
        [self isTableViewOrCollectionView:scrollView];
        _countDownScrollView  = scrollView;
        _dataList = dataList;
        [self countDownWithScrollView:_countDownScrollView  dataList:_dataList];
    }
    return self;
}
/**
 添加倒计时，添加后自动启动定时器 ，一般用于页面上可见少量的定时器
 
 @param timeLabel 时间视图
 @param time 时间
 */
- (void)addTimeLabel:(ZJJTimeCountDownLabel *)timeLabel time:(NSString *)time{
    
    if (timeLabel&&time) {
        
        ZJJTimeCountDownModel *model = [[ZJJTimeCountDownModel alloc] init];
        model.timeLabel = timeLabel;
        model.time = time;
        timeLabel.timeKey = @"time";
        [self.timeLabelDataList addObject:model];
    }
    if (!_labelTimer) {
        [self startTimer];
    }
}

/**
 启动定时器
 */
- (void)startTimer{
    
    if (_labelTimer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _labelTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_labelTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_labelTimer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setupTimeLabelText];
            });
        });
        dispatch_resume(_labelTimer); // 启动定时器
    }
}

- (void)setupTimeLabelText{
    
    if (!self.timeLabelDataList.count) {
        //销毁定时器
        [self destoryLabelTimer];
        return;
    }
    BOOL isHaveOutDate = NO;
    for (ZJJTimeCountDownModel *model in self.timeLabelDataList) {
        NSString *timeStr = [self timeStringWithModel:model timeLabel:model.timeLabel];
        model.timeLabel.text = timeStr;
        //判断该数据时候已经过时
        if ([timeStr isEqualToString:model.timeLabel.jj_description]) {
            if ([self.delegate respondsToSelector:@selector(outDateTimeLabel:timeCountDown:)]) {
                [self.delegate outDateTimeLabel:model.timeLabel timeCountDown:self];
            }
            //将过时的数据移除
            [self.timeLabelDataList removeObject:model];
            isHaveOutDate = YES;
            break;
        }
    }
    if (isHaveOutDate) {
        [self setupTimeLabelText];
    }
}

- (void)countDownWithScrollView:(UIScrollView*)scrollView dataList:(NSMutableArray*)dataList {

    if (_scrollViewTimer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _scrollViewTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_scrollViewTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_scrollViewTimer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setupScrollViewTimeLabelText];
            });
        });
        dispatch_resume(_scrollViewTimer); // 启动定时器
    }
}

- (BOOL)isTableViewOrCollectionView:(UIScrollView *)scrollView{

    if ([scrollView isKindOfClass:[UITableView class]] || [scrollView isKindOfClass:[UICollectionView class]]) {
        return YES;
    }
    
     NSAssert(NO, @"你所传入的scrollView，必须是UITableView或者UICollectionView类型");
    return NO;
}



- (void)setupScrollViewTimeLabelText{

    if (!_dataList.count) {
        return;
    }
    if ([self countDownTableView]) {
        
        NSArray  *cells = [self countDownTableView].visibleCells; //取出屏幕可见UITableViewCell
        for (UITableViewCell * cell in cells) {
            [self setupCellTimeLabelWithContentView:cell.contentView];
        }
    }
    if ([self countDownCollectionView]) {
        NSArray  *cells = [self countDownCollectionView].visibleCells; //取出屏幕可见UICollectionViewCell
        for (UICollectionViewCell * cell in cells) {
            [self setupCellTimeLabelWithContentView:cell.contentView];
        }
    }
    
}


- (void)setupCellTimeLabelWithContentView:(UIView *)contentView{

    for (UIView * contentSubView in contentView.subviews) {
        if ([contentSubView isKindOfClass:[ZJJTimeCountDownLabel class]]) {
            
            ZJJTimeCountDownLabel *timeLabel = (ZJJTimeCountDownLabel *)contentSubView;
            id model = nil;
            if (!_dataList.count) {
                return;
            }
            if ([_dataList[0] isKindOfClass:[NSArray class]]) {
                
                if (_dataList.count > timeLabel.indexPath.section) {
                    
                    NSArray *sectionList =_dataList[timeLabel.indexPath.section];
                    if (sectionList.count > timeLabel.indexPath.row) {
                        model = _dataList[timeLabel.indexPath.section][timeLabel.indexPath.row];
                    }else{
                        return;
                    }
                    
                }else{
                    return;
                }
            }else {
                if (_dataList.count > timeLabel.indexPath.row) {
                    model = _dataList[timeLabel.indexPath.row];
                }else{
                    
                    return;
                }
            }
            NSString *timeStr = [self timeStringWithModel:model timeLabel:timeLabel];
            if ([self isAutomaticallyDeletedWithModel:model timeLabel:timeLabel]) {
                
                if ([self.delegate respondsToSelector:@selector(scrollViewWithAutomaticallyDeleteModel:)]) {
                    [self.delegate scrollViewWithAutomaticallyDeleteModel:model];
                }
                [self deleteReloadDataWithModel:model indexPath:timeLabel.indexPath];
                [self setupScrollViewTimeLabelText];
                
            }else{
                timeLabel.text = timeStr;
            }
        }
    }
}

- (void)deleteReloadDataWithModel:(id)model indexPath:(NSIndexPath *)indexPath{

    //说明数据分组
    if ([_dataList[0] isKindOfClass:[NSArray class]]) {

        NSArray *deleteSection = _dataList[indexPath.section];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:deleteSection];
        if ([arr containsObject:model]) {
            [arr removeObject:model];
            if (arr.count == 0) {
                [_dataList removeObject:deleteSection];
            }else{
                
                [_dataList replaceObjectAtIndex:indexPath.section withObject:arr];
            }
        }
        
    }else{
        
        [_dataList removeObject:model];
    }
   [self countDownReloadData];
}

//是否是自动删除已过时的时间数据
- (BOOL)isAutomaticallyDeletedWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel{

    NSString *descript = [self timeStringWithModel:model timeLabel:timeLabel];
    
    if (timeLabel.isAutomaticallyDeleted && [descript isEqualToString:timeLabel.jj_description] && [self countDownTableView]) {
        return YES;
    }
    return NO;
}

/**
 判断该数据是否已经过时
 
 @param model 数据模型
 @return 是否
 */
- (BOOL)isOutDateWithModel:(id)model{

    NSString *timeStr = [self timeStringWithModel:model];
    if (!timeStr) {
        return YES;
    }
    return NO;
}


- (void)countDownReloadData{

    if ([self countDownTableView]) {
        [[self countDownTableView] reloadData];
    }
    if ([self countDownCollectionView]) {
        [[self countDownCollectionView] reloadData];
    }
}

- (UITableView *)countDownTableView{

    if ([_countDownScrollView isKindOfClass:[UITableView class]]) {
        
        UITableView *tabelView = (UITableView *)_countDownScrollView;
        return tabelView;
    }
    return nil;
}

- (UICollectionView *)countDownCollectionView{

    if ([_countDownScrollView isKindOfClass:[UICollectionView class]]){
        
        UICollectionView *collectionView = (UICollectionView *)_countDownScrollView;
        return collectionView;
    }
    return nil;
}

// 滑动过快的时候时间不会闪  (tableViewcell数据源方法里实现即可)
- (NSString *)countDownWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel{
    return [self timeStringWithModel:model timeLabel:timeLabel];
}




- (NSString *)timeStringWithModel:(id)model{
    return [self timeStringWithModel:model timeLabel:nil];
}

- (NSString *)timeStringWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel{

    
    //timeKey一定要设置，在初始化视图时设置或者在设置timeLabel其他属性前设置
    if (!timeLabel.timeKey) {
         NSAssert(NO, @"请查看ZJJTimeCountDownLabel类的timeKey属性是否已经设置，如果设置，请检查是否在视图初始化时设置");
    }
    NSString *serverEndTime = [model valueForKey:timeLabel.timeKey];
    NSDate * sjDate = [NSDate date];   //手机时间
    NSInteger sjInteger = [sjDate timeIntervalSince1970];  // 手机当前时间戳
    long long endTimeTamp = 0;
    switch (self.timeStyle) {
        case ZJJCountDownTimeStyleNormal:
        {
            endTimeTamp = [ZJJTimeCountDownDateTool getTimeTampWithNormal:serverEndTime];
        }
            break;
            
        case ZJJCountDownTimeStyleTamp:
        {
            endTimeTamp = serverEndTime.longLongValue;
        }
            break;
            
        case ZJJCountDownTimeStylePureNumber:
        {
            endTimeTamp = [ZJJTimeCountDownDateTool getTimeTampWithPureNumber:serverEndTime];
        }
            break;
            
        default:
            break;
    }
    NSInteger endTime = endTimeTamp + _less;
    return [self getNowTimeWithStartTimeTamp:sjInteger endTimeTamp:endTime timeLabel:timeLabel];
}

- (NSString *)getNowTimeWithStartTimeTamp:(NSInteger )startTimeTamp endTimeTamp:(NSInteger)endTimeTamp timeLabel:(ZJJTimeCountDownLabel *)timeLabel{
    
    NSTimeInterval timeInterval = endTimeTamp - startTimeTamp;
    //    NSLog(@"%f",timeInterval);
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    if ([self.delegate respondsToSelector:@selector(dateWithSeconds:timeLabel:timeCountDown:)]) {
        [self.delegate dateWithSeconds:seconds timeLabel:timeLabel timeCountDown:self];
    }
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (days <= 0&&hours<=0&&minutes<=0&&seconds<=0) {
        return timeLabel.jj_description;
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}


/**
 *  主动销毁定时器
 */
-(void)destoryTimer{
   
    [self destoryScrollViewTimer];
    [self destoryLabelTimer];
  
}
- (void)destoryScrollViewTimer{

    if (_scrollViewTimer) {
        dispatch_source_cancel(_scrollViewTimer);
        _scrollViewTimer = nil;
    }
}
- (void)destoryLabelTimer{
   
    if (_labelTimer) {
        dispatch_source_cancel(_labelTimer);
        _labelTimer = nil;
    }
}

-(void)dealloc{
//    [_countDownScrollView removeObserver:self forKeyPath:@"contentOffset"];
    NSLog(@"%s dealloc",object_getClassName(self));
}

- (NSMutableArray *)timeLabelDataList{

    if (!_timeLabelDataList) {
        _timeLabelDataList = [NSMutableArray array];
    }
    return _timeLabelDataList;
}

@end

