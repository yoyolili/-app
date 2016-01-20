//
//  TheMainInfoTableViewCell.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/11.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheMainInfoTableViewCell.h"
#import "common.h"

@implementation TheMainInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}
- (IBAction)btnclick:(UIButton *)sender {
    
    if (!self.model.isSave) {
        self.model.isSave = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"iconfont-xin (1)"] forState:UIControlStateNormal];
        if (![[[DBFileManager shareHandle] selectAllValue] containsObject:self.model]) {
            
            [[DBFileManager shareHandle] insertIntoData:self.model];
            NSLog(@"插入成功");
        }
    }else {
        self.model.isSave = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"iconfont-xin (2)"] forState:UIControlStateNormal];
        [[DBFileManager shareHandle]deleteDataFromUrl:self.model.share];
    }
}

- (void)setModel:(TheMainModel *)model
{
    _model = model;
    [self.backImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumbnail]]];
    self.titleLabel.text = model.title;
    self.titleLabel.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
