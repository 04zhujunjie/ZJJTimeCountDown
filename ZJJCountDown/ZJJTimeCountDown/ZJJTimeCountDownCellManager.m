//
//  ZJJTimeCountDownCellManager.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/14.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDownCellManager.h"
#import "ZJJTimeCountDownLabel.h"

@implementation ZJJTimeCountDownCellManager{

    dispatch_source_t _timer;
    UIScrollView         *_countDownScrollView ;
    NSMutableArray                *_dataList;
}

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

- (BOOL)isTableViewOrCollectionView:(UIScrollView *)scrollView{
    
    if ([scrollView isKindOfClass:[UITableView class]] || [scrollView isKindOfClass:[UICollectionView class]]) {
        return YES;
    }
    
    NSAssert(NO, @"你所传入的scrollView，必须是UITableView或者UICollectionView类型");
    return NO;
}

- (void)countDownWithScrollView:(UIScrollView*)scrollView dataList:(NSMutableArray*)dataList {
    
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setupScrollViewTimeLabelText];
            });
        });
        dispatch_resume(_timer); // 启动定时器
    }
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
            NSAttributedString *timeStr = [self.delegate cellTimeStringWithModel:model timeLabel:timeLabel];
            if ([self isAutomaticallyDeletedWithModel:model timeLabel:timeLabel]) {
                
                if ([self.delegate respondsToSelector:@selector(cellAutomaticallyDeleteWithModel:)]) {
                    [self.delegate cellAutomaticallyDeleteWithModel:model];
                }
                [self deleteReloadDataWithModel:model indexPath:timeLabel.indexPath];
                [self setupScrollViewTimeLabelText];
                
            }else{
                timeLabel.attributedText = timeStr ;
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
    
    NSAttributedString *descript = [self.delegate cellTimeStringWithModel:model timeLabel:timeLabel];
    
    if (timeLabel.isAutomaticallyDeleted && [descript.string isEqualToString:timeLabel.jj_description] && [self countDownTableView]) {
        return YES;
    }
    return NO;
}

/**
 刷新表格
 */
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

/**
 销毁定时器
 */
- (void)destoryScrollViewTimer{
    
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
