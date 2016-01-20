//
//  TheMonthTableViewCell.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheMonthTableViewCell.h"
#import "common.h"

@implementation TheMonthTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)bindingDataWithDict:(NSDictionary *)dict
{
    
}
- (IBAction)btnClick:(id)sender {
    if (!self.isSave) {
        self.isSave = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"iconfont-xin (1)"] forState:UIControlStateNormal];
        if (![[[DBFileManager shareHandle] selectAllValue] containsObject:self.model]) {
            [[DBFileManager shareHandle] insertIntoData:self.model];
            NSLog(@"插入成功");
        }
    }else {
        
        self.isSave = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"iconfont-xin (2)"] forState:UIControlStateNormal];
        [[DBFileManager shareHandle]deleteDataFromUrl:self.model.share];
    }
}

- (void)setModel:(TheMainModel *)model
{
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumbnail]]];
    self.title.text = model.title;
    self.title.font = [UIFont fontWithName:@"SimHei" size:20];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
