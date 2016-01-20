//
//  TheMonthTableViewCell.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TheMainModel;

@interface TheMonthTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (nonatomic, strong) TheMainModel *model;

@property (nonatomic) BOOL isSave;
@end
