//
//  SmallScrollView.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/10.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "SmallScrollView.h"
#import "common.h"

@interface SmallScrollView ()

@property (nonatomic, strong) NSArray *buttonArray;
@property (nonatomic, strong) UIView *slidView;

@end

@implementation SmallScrollView

- (instancetype)initWithButtonArr:(NSArray *)array
{
    if (self = [super init]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.frame = CGRectMake(0, 0, kScreenWidth, 30);
        self.contentSize = CGSizeMake(array.count * kScreenWidth / 4, 30);
        self.backgroundColor = [UIColor colorWithRed:121/255.0 green:131/255.0 blue:146/255.0 alpha:1];
        self.selectedColor = [UIColor whiteColor];
        
        [self createSliedView];
        
        NSMutableArray *muArr = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(kScreenWidth / 4 * i, 0, kScreenWidth / 4, 30);
            [self addSubview:btn];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
            btn.tag = 100 + i;
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [muArr addObject:btn];
        }
        self.buttonArray = muArr;
        self.index = 0;
    }
    return self;
}

- (void)btnClick:(UIButton *)btn
{
    self.index = btn.tag - 100;
    
    if (_changeIndexValue) {
        _changeIndexValue(_index);
    }
}

- (void)createSliedView
{
    _slidView = [[UIView alloc] initWithFrame:CGRectMake(0, 28, kScreenWidth / 4, 2)];
    _slidView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_slidView];
}

- (void)setIndex:(NSInteger)index
{
    UIButton *notSelectedBtn = _buttonArray[_index];
    notSelectedBtn.selected = NO;
    
    UIButton *selectedBtn = _buttonArray[index];
    selectedBtn.selected = YES;
    
    _index = index;
    CGRect frame = _slidView.frame;
    frame.origin.x = _index * kScreenWidth / 4;
    [UIView animateWithDuration:0.3 animations:^{
        _slidView.frame = frame;
    }];
    
}

@end
