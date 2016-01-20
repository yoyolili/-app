//
//  TheDayCollectionViewCell.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TheMainModel;

@interface TheDayCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic, strong) TheMainModel *model;

@property (nonatomic) BOOL isSave;

@end
