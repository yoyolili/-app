//
//  CollectTableViewCell.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/20.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "CollectTableViewCell.h"
#import "common.h"

@implementation CollectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(TheMainModel *)model
{
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumbnail]]];
    self.title.text = model.title;
    self.title.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
