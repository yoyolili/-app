//
//  TheStarView.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/10.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheStarView.h"
#import "common.h"

@implementation TheStarView

static NSString *identifier = @"star item";

- (void)addSubviews
{
    _pageIndex = 1;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(20, 10);
    flowLayout.footerReferenceSize = CGSizeMake(10, 20);
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];

    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-84);
        make.right.equalTo(self);
    }];
    [_collectionView registerNib:[UINib nibWithNibName:@"TheStarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"starview >>> 下拉刷新");
        [self loadContentFromNet];
    }];
    _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        NSLog(@"starview >>> 上拉加载");
        _pageIndex++;
        [self loadContentFromNet];
    }];
    
    [self loadContentFromNet];
}

- (void)loadContentFromNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://www.wezeit.com/index.php?m=Home&c=Api&a=channelList&channel_id=28&page=%ld&time=1453277555&click_time=0&end_item=0&device_id=866819029961576&version=android_3.3.8",(long)_pageIndex] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"datas"][@"list"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *temp in array) {
            
            if (_pageIndex == 1) {
                TheMainModel *model = [[TheMainModel alloc] initWithDict:temp];
                [arr addObject:model];
            }else{
                TheMainModel *model = [[TheMainModel alloc] initWithDict:temp];
                [self.contentArray addObject:model];
            }
        }
        
        if (_pageIndex == 1) {
            self.contentArray = arr;
        }
        [_collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error >>> %@",error);
    }];
    
    if (_refreshControl.isRefreshing) {
        [_refreshControl endRefreshing];
    }
    
    if (_collectionView.mj_header.isRefreshing) {
        [_collectionView.mj_header endRefreshing];
    }
    
    if (_collectionView.mj_footer.isRefreshing) {
        [_collectionView.mj_footer endRefreshing];
    }
    
}

- (NSMutableArray *)contentArray
{
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

@end
