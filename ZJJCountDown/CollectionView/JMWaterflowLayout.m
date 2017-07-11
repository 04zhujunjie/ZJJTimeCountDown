//
//  JMWaterflowLayout.m
//  TableViewRefreshDemo
//
//  Created by xiaozhu on 2017/6/28.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "JMWaterflowLayout.h"


static NSString *const kJMWaterflowLayoutHeader = @"JMWaterflowLayoutHeader";


/** 默认的列数 */
static const NSInteger XMGDefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat XMGDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat XMGDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets XMGDefaultEdgeInsets = {10, 10, 10, 10};

@interface JMWaterflowLayout()
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;
/** 头部视图 */
@property (nonatomic ,strong) UIView *headerView;

@property (nonatomic ,strong) UICollectionViewLayoutAttributes  *layoutHeader;
@property (nonatomic ,strong) UICollectionViewLayoutAttributes  *layoutFooter;


- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;
- (NSInteger)section;
@end

@implementation JMWaterflowLayout

#pragma mark - 常见数据处理
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return XMGDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return XMGDefaultColumnMargin;
    }
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return XMGDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return XMGDefaultEdgeInsets;
    }
}

- (NSInteger)section{

    if ([self.delegate respondsToSelector:@selector(sectionInWaterflowLayout:)]) {
        return [self.delegate sectionInWaterflowLayout:self];
    }
    return 0;
}

#pragma mark - 懒加载
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.contentHeight = 0;
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];

    //获取头部高度
    CGFloat headerHeight = [self heightForHeaderView];
    if (headerHeight && !_layoutHeader) {
        _layoutHeader = [UICollectionViewLayoutAttributes   layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.section]];
        _layoutHeader.frame =CGRectMake(0,0, self.collectionView.frame.size.width, headerHeight);
        [self.attrsArray insertObject:_layoutHeader atIndex:0];
    }
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:self.section];
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:self.section];
        // 获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
    CGFloat footerHeight = [self heightForFooterView];
    if (footerHeight && !_layoutFooter) {
        _layoutFooter = [UICollectionViewLayoutAttributes   layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:self.attrsArray.count inSection:self.section]];
        [self.attrsArray addObject:_layoutFooter];
    }
    
}

/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // 设置布局属性的frame
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    //headerView高度
    CGFloat headerHeight = [self heightForHeaderView];
    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }else{
    
        y += headerHeight;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    // 记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize = CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
    if (_layoutFooter) {
         CGFloat footerHeight = [self.delegate heightForFooterViewInWaterflowLayout:self];
        if (footerHeight) {
            _layoutFooter.frame = CGRectMake(0,contentSize.height, self.collectionView.frame.size.width, footerHeight);
            contentSize.height+=footerHeight;
        }
    }
    return contentSize;
}



/**
 *  根据kind、indexPath，计算对应的LayoutAttributes
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    //计算LayoutAttributes
    if([elementKind isEqualToString:UICollectionElementKindSectionHeader]){
        CGFloat width = self.collectionView.bounds.size.width;
        CGFloat height = [self heightForHeaderView];
        CGFloat x = 0;
        //根据offset计算kSupplementaryViewKindHeader的y
        //y = offset.y-(header高度-固定高度)
        CGFloat offsetY = self.collectionView.contentOffset.y;
        CGFloat y = MAX(0,
                        offsetY-height);
        attributes.frame = CGRectMake(x, y, width, height);
        attributes.zIndex = 1024;
    }else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]){
    
        
    }
    return attributes;
}


- (CGFloat)heightForHeaderView{

    if ([self.delegate respondsToSelector:@selector(heightForHeaderViewInWaterflowLayout:)]) {
        return [self.delegate heightForHeaderViewInWaterflowLayout:self];
    }
    return 0;
}

- (CGFloat)heightForFooterView{
    
    if ([self.delegate respondsToSelector:@selector(heightForFooterViewInWaterflowLayout:)]) {
        return [self.delegate heightForFooterViewInWaterflowLayout:self];
    }
    return 0;
}



@end
