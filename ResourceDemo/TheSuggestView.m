//
//  TheSuggestView.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/14.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheSuggestView.h"
#import "common.h"

@interface TheSuggestView ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TheSuggestView

static NSString *identifier = @"suggest cell";


- (void)addSubviews
{
    _pageIndex = 1;
    _contentTableView = [[UITableView alloc] init];
    
    [self addSubview:_contentTableView];
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-84);
        make.right.equalTo(self);
    }];
    
    _contentTableView.rowHeight = 160;
    
    [_contentTableView registerNib:[UINib nibWithNibName:@"TheSuggestTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    _contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新");
        [self netRequest];
    }];
    _contentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉加载");
        _pageIndex++;
        [self netRequest];
    }];
    
    [self netRequest];
    
}


#pragma mark - URL Request
- (void)netRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://www.wezeit.com/index.php?m=Home&c=Api&a=channelList&channel_id=4&page=%ld&time=1453277684&click_time=0&end_item=0&device_id=866819029961576&version=android_3.3.8",(long)_pageIndex] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"datas"][@"list"];
        //[array removeObjectAtIndex:1];
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
        
        
        //[self.imageArray removeObjectAtIndex:0];
        [_contentTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error >>> %@",error);
    }];
    
    
    if (_refreshControl.isRefreshing) {
        [_refreshControl endRefreshing];
    }
    
    if (_contentTableView.mj_header.isRefreshing) {
        [_contentTableView.mj_header endRefreshing];
    }
    
    if (_contentTableView.mj_footer.isRefreshing) {
        [_contentTableView.mj_footer endRefreshing];
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
