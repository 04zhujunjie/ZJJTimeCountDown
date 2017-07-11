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


typedef NS_ENUM(NSInteger , ZJJCountDownTimeStyle) {

    //时间格式：2017-7-12 18:06:22
    ZJJCountDownTimeStyleNormal = 0,
    //时间戳：1591881249
    ZJJCountDownTimeStyleTamp,
    //时间格式 20170712180622
    ZJJCountDownTimeStylePureNumber
    
};

typedef NS_ENUM(NSInteger, ZJJCountDownCellEditingStyle){

    ZJJCountDownCellEditingNone = 0,
    //只支持UITableView，过时数据做自动删除，需要知道具体删除数据，请实现代理方法
    ZJJCountDownCellEditingAutomaticallyDeleted
};

@protocol ZJJTimeCountDownDelegate <NSObject>

@optional

- (void)countDownWithAutomaticallyDeleteModel:(id)model;

@end

@interface ZJJTimeCountDown : NSObject

@property (nonatomic ,strong)NSString *jj_description;

// 与服务器时间的差值 手机时间-服务器时间
@property (nonatomic ,assign) NSInteger less;
//时间格式
@property (nonatomic ,assign) ZJJCountDownTimeStyle timeStyle;
//编辑格式
@property (nonatomic ,assign) ZJJCountDownCellEditingStyle editingStyle;

@property (nonatomic ,weak) id <ZJJTimeCountDownDelegate> delegate;


/**
 初始化

 @param scrollView 滑动View ，可以是UITableView 或者 UICollectionView
 @param dataList 数据源
 @param timeKey 模型时间属性
 @return 初始化对象
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView dataList:(NSMutableArray *)dataList timeKey:(NSString *)timeKey;

- (void)deleteReloadDataWithModel:(id)model indexPath:(NSIndexPath *)indexPath;

// 滑动过快的时候时间不会闪  (tableViewcell数据源方法里实现即可)
- (NSString *)countDownWithModel:(id)model;

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
