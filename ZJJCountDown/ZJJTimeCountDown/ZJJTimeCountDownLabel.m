//
//  ZJJTimeCountDownLabel.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDownLabel.h"

static NSString *const kZJJTimeCountDownLabelDescription = @"活动已经结束！";

@implementation ZJJTimeCountDownLabel


- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
         _jj_description = kZJJTimeCountDownLabelDescription;
        [self setupProperty];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
         _jj_description = kZJJTimeCountDownLabelDescription;
        [self setupProperty];
    }
    return self;
}


- (void)setupProperty{
    
}

- (void)setJj_description:(NSString *)jj_description{

    _jj_description = jj_description;
    if ([self isNillWithString:jj_description]) {
        self.jj_description = kZJJTimeCountDownLabelDescription;
    }
}

- (BOOL)isNillWithString:(NSString *)str{

    if (!str || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

@end
