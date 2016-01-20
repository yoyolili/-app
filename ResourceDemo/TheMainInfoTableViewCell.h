//
//  TheMainInfoTableViewCell.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/11.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TheMainModel;

@interface TheMainInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *colBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (nonatomic, strong) TheMainModel *model;

@end
