//
//  TheMonthView.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/10.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheMonthView.h"
#import "common.h"
@interface TheMonthView ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TheMonthView

static NSString *identifier = @"month cell";

- (void)addSubviews
{
    _pageIndex = 1;
    _tableView = [[UITableView alloc] init];
    
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-84);
        make.right.equalTo(self);
    }];
    
    _tableView.rowHeight = 150;
    
    [_tableView registerNib:[UINib nibWithNibName:@"TheMonthTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新");
        [self netRequest];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉加载");
        _pageIndex++;
        [self netRequest];
    }];
    
    [self netRequest];
    
}

- (void)netRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://www.wezeit.com/index.php?m=Home&c=Api&a=channelList&channel_id=112885&page=%ld&time=1453277173&click_time=0&end_item=0&device_id=866819029961576&version=android_3.3.8",(long)_pageIndex] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"datas"][@"list"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *temp in array) {
            
            if (_pageIndex == 0) {
                TheMainModel *model = [[TheMainModel alloc] initWithDict:temp];
                [arr addObject:model];
            }else{
                TheMainModel *model = [[TheMainModel alloc] initWithDict:temp];
                [self.contentArray addObject:model];
            }
        }
        
        if (_pageIndex == 0) {
            self.contentArray = arr;
        }
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error >>> %@",error);
    }];
    
    
    if (_refreshControl.isRefreshing) {
        [_refreshControl endRefreshing];
    }
    
    if (_tableView.mj_header.isRefreshing) {
        [_tableView.mj_header endRefreshing];
    }
    
    if (_tableView.mj_footer.isRefreshing) {
        [_tableView.mj_footer endRefreshing];
    }
}

#pragma mark - Lazy Loading
- (NSMutableArray *)contentArray
{
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

@end
