//
//  BigScrollView.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/10.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "BigScrollView.h"
#import "common.h"

@implementation BigScrollView

- (instancetype)initBigScrollView
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 30, kScreenWidth, kScrrenHeight);
        self.contentSize = CGSizeMake(kScreenWidth * 4, 0);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

@end
