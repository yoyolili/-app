//
//  TheSuggestView.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/14.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheSuggestView : UIView


@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) NSMutableArray *contentArray;

@property (nonatomic) NSInteger pageIndex;

- (void)addSubviews;

@end
