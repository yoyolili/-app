//
//  SmallScrollView.h
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/10.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallScrollView : UIScrollView

@property (nonatomic) NSInteger index;
@property (nonatomic) int currentIndex;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong)void (^changeIndexValue)(NSInteger);

- (instancetype)initWithButtonArr:(NSArray *)array;

@end
