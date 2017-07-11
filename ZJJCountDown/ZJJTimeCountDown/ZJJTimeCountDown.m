//
//  ZJJTimeCountDown.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDown.h"
#import "ZJJTimeCountDownDateTool.h"
static NSString *const kZJJCountDownDescription = @"活动已经结束！";
@interface ZJJTimeCountDown ()

@end


@implementation ZJJTimeCountDown {
    dispatch_source_t _timer;
    NSDateFormatter *dateFormatter;
    UIScrollView         *_countDownScrollView ;
    NSMutableArray                *_dataList;
    NSString * _timeKey;

}

/**
 初始化
 
 @param scrollView 滑动View ，可以是UITableView 或者 UICollectionView
 @param dataList 数据源
 @param timeKey 模型时间属性
 @return 初始化对象
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView dataList:(NSMutableArray *)dataList timeKey:(NSString *)timeKey {

    self = [super init];
    if (self) {
        
        [self isTableViewOrCollectionView:scrollView];
        _countDownScrollView  = scrollView;
        _dataList = dataList;
        _timeKey = timeKey;
        _jj_description = kZJJCountDownDescription;
        [self countDownWithScrollView:_countDownScrollView  dataList:_dataList timeKey:_timeKey];
        
    }
    return self;
}

- (void)countDownWithScrollView:(UIScrollView*)scrollView dataList:(NSMutableArray*)dataList timeKey:(NSString *)timeKey {

    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setupTimeLabelText];
            });
        });
        dispatch_resume(_timer); // 启动定时器
    }
}

- (BOOL)isTableViewOrCollectionView:(UIScrollView *)scrollView{

    if ([scrollView isKindOfClass:[UITableView class]] || [scrollView isKindOfClass:[UICollectionView class]]) {
        return YES;
    }
    
     NSAssert(NO, @"你所传入的scrollView，必须是UITableView或者UICollectionView类型");
    return NO;
}

- (void)setupTimeLabelText{

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

- (ZJJTimeCountDownLabel *)getTimeLabelWithContentView:(UIView *)contentView{

    for (UIView * contentSubView in contentView.subviews) {
        if ([contentSubView isKindOfClass:[ZJJTimeCountDownLabel class]]) {
            
            ZJJTimeCountDownLabel *timelabel = (ZJJTimeCountDownLabel *)contentSubView;
            return timelabel;
        }
    }
    return nil;
}

- (void)setupCellTimeLabelWithContentView:(UIView *)contentView{

    
    ZJJTimeCountDownLabel *timeLabel = [self getTimeLabelWithContentView:contentView];
    if (timeLabel) {
        
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
        NSString *timeStr = [self timeStringWithModel:model];
        if ([self isAutomaticallyDeletedWithModel:model]) {
            
            if ([self.delegate respondsToSelector:@selector(countDownWithAutomaticallyDeleteModel:)]) {
                [self.delegate countDownWithAutomaticallyDeleteModel:model];
            }
            [self deleteReloadDataWithModel:model indexPath:timeLabel.indexPath];
            
            [self setupTimeLabelText];
            
        }else{
            timeLabel.text = timeStr;
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
- (BOOL)isAutomaticallyDeletedWithModel:(id)model{

    if (self.editingStyle == ZJJCountDownCellEditingAutomaticallyDeleted && [self isOutDateWithModel:model] && [self countDownTableView]) {
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
    if ([timeStr isEqualToString:self.jj_description]) {
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
- (NSString *)countDownWithModel:(id)model{
    return [self timeStringWithModel:model];
}


- (NSString *)timeStringWithModel:(id)model{

    NSString *serverEndTime = [model valueForKey:_timeKey];
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
    return [ZJJTimeCountDownDateTool getNowTimeWithStartTimeTamp:sjInteger endTimeTamp:endTime description:self.jj_description];
 
}




- (void)setJj_description:(NSString *)jj_description{

    _jj_description = jj_description;
    if (!jj_description || [jj_description isEqualToString:@""]) {
        self.jj_description = kZJJCountDownDescription;
    }
}


/**
 *  主动销毁定时器
 */
-(void)destoryTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end
