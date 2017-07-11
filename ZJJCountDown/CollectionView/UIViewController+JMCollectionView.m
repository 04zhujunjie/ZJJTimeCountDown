//
//  UIViewController+JMCollectionView.m
//  TableViewRefreshDemo
//
//  Created by xiaozhu on 2017/6/29.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "UIViewController+JMCollectionView.h"
#import <objc/runtime.h>
@implementation UIViewController (JMCollectionView)


- (void)setC_dataArray:(NSMutableArray *)c_dataArray{
    
    objc_setAssociatedObject(self, @selector(c_dataArray), c_dataArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)c_dataArray{
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
