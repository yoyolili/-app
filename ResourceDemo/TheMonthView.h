//
//  TheMonthView.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/10.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheMonthView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *contentArray;

@property (nonatomic) NSInteger pageIndex;

- (void)addSubviews;

@end
