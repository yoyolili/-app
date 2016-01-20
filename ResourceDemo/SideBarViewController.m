//
//  SideBarViewController.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "SideBarViewController.h"
#import "common.h"

@interface SideBarViewController ()


@end

@implementation SideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _className = @[@"首页", @"发现", @"收藏", @"设置"];
    _imageArray = @[@"iconfont-shouye", @"iconfont-faxian (1)", @"iconfont-shoucang2", @"iconfont-buchongiconsvg16"];
    self.menuTableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.menuTableView.backgroundColor = [UIColor clearColor];
    
    self.menuTableView.rowHeight = 80;
    [self.contentView addSubview:self.menuTableView];
}

@end
