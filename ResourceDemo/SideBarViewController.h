//
//  SideBarViewController.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "LLBlurSidebar.h"

@interface SideBarViewController : LLBlurSidebar

@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSArray *className;
@property (nonatomic, strong) NSArray *imageArray;

@end
