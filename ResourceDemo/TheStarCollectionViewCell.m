//
//  TheStarCollectionViewCell.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheStarCollectionViewCell.h"
#import "common.h"

@implementation TheStarCollectionViewCell

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
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumbnail]]];
    self.title.text = model.title;
}

@end
