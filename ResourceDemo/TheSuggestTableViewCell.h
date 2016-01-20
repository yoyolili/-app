//
//  TheSuggestTableViewCell.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/13.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TheMainModel;

@interface TheSuggestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (nonatomic, strong) TheMainModel *model;

@property (nonatomic) BOOL isSave;

@end
