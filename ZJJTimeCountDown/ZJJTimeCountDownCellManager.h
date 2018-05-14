//
//  ZJJTimeCountDownCellManager.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/14.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZJJTimeCountDownLabel;

@protocol ZJJTimeCountDownCellManagerDelegate <NSObject>


/**
 过时的数据自动删除回调方法， 针对UITableView 或者 UICollectionView上的倒计时视图
 
 @param model 数据模型
 */
- (void)cellAutomaticallyDeleteWithModel:(id)model;

- (NSAttributedString *)cellTimeStringWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel;

@end

@interface ZJJTimeCountDownCellManager : NSObject

@property (nonatomic ,weak) id <ZJJTimeCountDownCellManagerDelegate> delegate;


@property (nonatomic ,strong) NSMutableDictionary *headerSectionDic;
@property (nonatomic ,strong) NSMutableDictionary *footerSectionDic;
@property (nonatomic ,assign) BOOL isFirstViewForSupView;
/**
 初始化

 @param scrollView 滑动视图
 @param dataList 表格数据源
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView dataList:(NSMutableArray *)dataList;

/**
 删除数据 针对UITableView 或者 UICollectionView上的倒计时视图
 
 @param model 数据模型
 @param indexPath 索引位置
 */
- (void)deleteReloadDataWithModel:(id)model indexPath:(NSIndexPath *)indexPath;

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

- (void)destoryScrollViewTimer;

@end
