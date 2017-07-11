//
//  JMWaterflowLayout.h
//  TableViewRefreshDemo
//
//  Created by xiaozhu on 2017/6/28.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMWaterflowLayout;

@protocol JMWaterflowLayoutDelegate <NSObject>

@required
- (CGFloat)waterflowLayout:(JMWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional



- (NSInteger)columnCountInWaterflowLayout:(JMWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(JMWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(JMWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(JMWaterflowLayout *)waterflowLayout;

- (NSInteger)sectionInWaterflowLayout:(JMWaterflowLayout *)waterflowLayout;

- (CGFloat)heightForHeaderViewInWaterflowLayout:(JMWaterflowLayout *)layout ;

- (CGFloat)heightForFooterViewInWaterflowLayout:(JMWaterflowLayout *)layout;

@end

@interface JMWaterflowLayout : UICollectionViewFlowLayout

@property (nonatomic ,weak) id <JMWaterflowLayoutDelegate> delegate;


@end
