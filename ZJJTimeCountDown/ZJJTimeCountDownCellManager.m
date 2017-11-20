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
         _dataList = dataList;
         [self initWithScrollView:scrollView];
    }
    return self;
}

- (void)initWithScrollView:(UIScrollView *)scrollView {

    [self isTableViewOrCollectionView:scrollView];
    _countDownScrollView  = scrollView;
    [self countDownWithScrollView:_countDownScrollView];
}

- (BOOL)isTableViewOrCollectionView:(UIScrollView *)scrollView{
    
    if ([scrollView isKindOfClass:[UITableView class]] || [scrollView isKindOfClass:[UICollectionView class]]) {
        return YES;
    }
    
    NSAssert(NO, @"你所传入的scrollView，必须是UITableView或者UICollectionView类型");
    return NO;
}

- (void)countDownWithScrollView:(UIScrollView*)scrollView {
    
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
    
    if ([self countDownTableView]) {
        
        //设置tableViewCell上倒计时
        [self setupTabelViewCellTimeLabel];
        //设置tableView区头和区尾倒计时
        [self setupTabelViewHeaderOrFooterTimeLabel];
       
    }
    if ([self countDownCollectionView]) {
        
         //设置CollectionCell上倒计时
        [self setupCollectionCellTimeLabel];
      
    }
    
}


/**
 设置tableViewCell上倒计时
 */
- (void)setupTabelViewCellTimeLabel{

    if (_dataList.count) {
        
        NSArray  *cells = [self countDownTableView].visibleCells; //取出屏幕可见UITableViewCell
        for (UITableViewCell * cell in cells) {
            [self setupCellTimeLabelWithContentView:cell.contentView];
        }
    }
}

/**
 设置tableView区头和区尾倒计时
 */
- (void)setupTabelViewHeaderOrFooterTimeLabel{

    
    if (_headerSectionDataList.count) {
        //获取可见的组
        NSArray *indexPaths = [self countDownTableView].indexPathsForVisibleRows;
        for (NSIndexPath *indexPath in indexPaths) {

            id model = _headerSectionDataList[indexPath.section];
            UIView *view = [[self countDownTableView].delegate tableView:[self countDownTableView] viewForHeaderInSection:indexPath.section];
            [self setupTabelTiemLabelWithView:view model:model];
        }
    }
    
    if (_footerSectionDataList.count) {
        
        //获取可见的组
        NSArray *indexPaths = [self countDownTableView].indexPathsForVisibleRows;
        for (NSIndexPath *indexPath in indexPaths) {
            id model = _footerSectionDataList[indexPath.section];
            UIView *view = [[self countDownTableView].delegate tableView:[self countDownTableView] viewForFooterInSection:indexPath.section];
            [self setupTabelTiemLabelWithView:view model:model];
        }
        
    }
}

- (void)setupCollectionCellTimeLabel{

    if (_dataList.count) {
        
        NSArray  *cells = [self countDownCollectionView].visibleCells; //取出屏幕可见UICollectionViewCell
        for (UICollectionViewCell * cell in cells) {
            [self setupCellTimeLabelWithContentView:cell.contentView];
        }
    }
}

- (void)setupTabelTiemLabelWithView:(UIView *)view model:(id)model{

    
    if ([view isKindOfClass:[ZJJTimeCountDownLabel class]]) {
        
        ZJJTimeCountDownLabel *timeLabel = (ZJJTimeCountDownLabel *)view;
         [self setupAttributedText:timeLabel model:model];
        NSLog(@"====++++++=timeLabel.text===%@====",timeLabel.text);
    }
    
    for (UIView * contentSubView in view.subviews) {
        if ([contentSubView isKindOfClass:[ZJJTimeCountDownLabel class]]) {
            ZJJTimeCountDownLabel *timeLabel = (ZJJTimeCountDownLabel *)contentSubView;
            [self setupAttributedText:timeLabel model:model];
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
           
            if ([self isAutomaticallyDeletedWithModel:model timeLabel:timeLabel]) {
                
                if ([self.delegate respondsToSelector:@selector(cellAutomaticallyDeleteWithModel:)]) {
                    [self.delegate cellAutomaticallyDeleteWithModel:model];
                }
                [self deleteReloadDataWithModel:model indexPath:timeLabel.indexPath];
                [self setupScrollViewTimeLabelText];
                
            }else{
                [self setupAttributedText:timeLabel model:model];
            }
        }
    }
}

- (void)setupAttributedText:(ZJJTimeCountDownLabel *)timeLabel model:(id)model{

    NSAttributedString *timeStr = [self.delegate cellTimeStringWithModel:model timeLabel:timeLabel];
    timeLabel.attributedText = timeStr ;
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
                if (self.headerSectionDataList.count >= indexPath.section) {
                    [self.headerSectionDataList removeObjectAtIndex:indexPath.section];
                }
                if (self.footerSectionDataList.count >=indexPath.section) {
                    [self.footerSectionDataList removeObjectAtIndex:indexPath.section];
                }
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
