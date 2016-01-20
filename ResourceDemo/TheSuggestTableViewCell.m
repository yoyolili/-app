//
//  TheSuggestTableViewCell.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/13.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheSuggestTableViewCell.h"
#import "common.h"

@implementation TheSuggestTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)btnClick:(UIButton *)sender {
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
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumbnail]]];
    self.titleLable.text = model.title;
    self.titleLable.textColor = [UIColor blackColor];
    self.imgView.layer.cornerRadius = 100;
    self.imgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
