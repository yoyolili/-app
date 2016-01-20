//
//  TheFindViewController.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/10.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheFindViewController.h"
#import "common.h"

@interface TheFindViewController ()

//@property (nonatomic, strong) TheSuggestViewController *suggestView;
//@property (nonatomic, strong) TheStarView *starView;
//@property (nonatomic, strong) TheMonthView *monthView;
//@property (nonatomic, strong) TheDayView *dayView;

@property (nonatomic, strong) FindViewController *findVC;

@property (nonatomic, strong) UIButton *suggestBtn;
@property (nonatomic, strong) UIButton *starBtn;
@property (nonatomic, strong) UIButton *monthBtn;
@property (nonatomic, strong) UIButton *dayBtn;

@property (nonatomic, strong) UIImageView *suggestImage;
@property (nonatomic, strong) UIImageView *starImage;
@property (nonatomic, strong) UIImageView *monthImage;
@property (nonatomic, strong) UIImageView *dayImage;

@property (nonatomic, strong) UILabel *suggestLabel;
@property (nonatomic, strong) UILabel *starLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic) NSInteger currentIndex;

@end

@implementation TheFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupLayout
{
    //添加视图
    
    self.title = @"发现";
    [self.view addSubview:self.suggestBtn];
    [self.view addSubview:self.starBtn];
    [self.view addSubview:self.monthBtn];
    [self.view addSubview:self.dayBtn];
    [self.view addSubview:self.suggestImage];
    [self.view addSubview:self.starImage];
    [self.view addSubview:self.monthImage];
    [self.view addSubview:self.dayImage];
    [self.view addSubview:self.suggestLabel];
    [self.view addSubview:self.starLabel];
    [self.view addSubview:self.monthLabel];
    [self.view addSubview:self.dayLabel];
    
    //添加约束
    [self.suggestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.starBtn.mas_left).with.offset(-1);
        make.bottom.equalTo(self.monthBtn.mas_top).with.offset(-1);
    }];
    
    [self.starBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.suggestBtn);
        make.size.equalTo(self.suggestBtn);
        make.right.equalTo(self.view);
    }];
    
    [self.monthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.suggestBtn);
        make.centerX.equalTo(self.suggestBtn);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.dayBtn.mas_left).with.offset(-1);
    }];
    
    [self.dayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.monthBtn);
        make.right.equalTo(self.view);
        make.centerY.equalTo(self.monthBtn);
    }];
    
    [self.suggestImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.suggestBtn.mas_top).with.offset(30);
        make.bottom.equalTo(self.suggestLabel.mas_top).with.offset(10);
        make.centerX.equalTo(self.suggestBtn);
    }];
    
    [self.suggestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.suggestBtn);
        make.bottom.equalTo(self.suggestBtn.mas_bottom).with.offset(20);
        
    }];
    
    [self.starImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.suggestImage);
        make.centerX.equalTo(self.starBtn);
        
    }];
    
    [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.starBtn);
        make.centerY.equalTo(self.suggestLabel);
    }];
    
    [self.monthImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.monthBtn);
        make.top.equalTo(self.monthBtn.mas_top).with.offset(30);
        make.bottom.equalTo(self.monthLabel.mas_top).with.offset(10);
    }];
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.monthBtn);
        make.bottom.equalTo(self.monthBtn.mas_bottom).with.offset(20);
    }];
    
    [self.dayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dayBtn);
        make.centerY.equalTo(self.monthImage);
    }];
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dayBtn);
        make.centerY.equalTo(self.monthLabel);
    }];
    
}

- (void)btnClick:(UIButton *)sender {
    
    _findVC = [[FindViewController alloc] init];
    
    switch (sender.tag) {
        case 100:
            _currentIndex = 0;
            _findVC.currentIndex = _currentIndex;
            break;
        case 101:
            _currentIndex = 1;
            _findVC.currentIndex = _currentIndex;
            break;
        case 102:
            _currentIndex = 2;
            _findVC.currentIndex = _currentIndex;
            break;
        case 103:
            _currentIndex = 3;
            _findVC.currentIndex = _currentIndex;
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:_findVC animated:YES];
}

#pragma mark - Lazy Load
- (UIButton *)suggestBtn
{
    if (_suggestBtn == nil) {
        _suggestBtn = [[UIButton alloc] init];
        _suggestBtn.backgroundColor = [UIColor colorWithRed:96/255.0 green:143/255.0 blue:159/255.0 alpha:1];
        _suggestBtn.alpha = 0.8;
        _suggestBtn.tag = 100;
        [_suggestBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _suggestBtn;
}

- (UIButton *)starBtn
{
    if (_starBtn == nil) {
        _starBtn = [[UIButton alloc] init];
        _starBtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:178/255.0 blue:23/255.0 alpha:1];
        _starBtn.alpha = 0.7;
        _starBtn.tag = 101;
        [_starBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _starBtn;
}

- (UIButton *)monthBtn
{
    if (_monthBtn == nil) {
        _monthBtn = [[UIButton alloc] init];
        _monthBtn.backgroundColor = [UIColor colorWithRed:237/255.0 green:222/255.0 blue:139/255.0 alpha:1];
        _monthBtn.tag = 102;
        [_monthBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _monthBtn;
}

- (UIButton *)dayBtn
{
    if (_dayBtn == nil) {
        _dayBtn = [[UIButton alloc] init];
        _dayBtn.backgroundColor = [UIColor colorWithRed:1/255.0 green:77/255.0 blue:103/255.0 alpha:1];
        _dayBtn.layer.opacity = 0.7;
        _dayBtn.tag = 103;
        [_dayBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dayBtn;
}

- (UIImageView *)suggestImage
{
    if (_suggestImage == nil) {
        _suggestImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-hand-copy"]];
    }
    return _suggestImage;
}

- (UIImageView *)starImage
{
    if (_starImage == nil) {
        _starImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-shoucang"]];
    }
    return _starImage;
}

- (UIImageView *)monthImage
{
    if (_monthImage == nil) {
        _monthImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-yuexingim2"]];
    }
    return _monthImage;
}

- (UIImageView *)dayImage
{
    if (_dayImage == nil) {
        _dayImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-ri"]];
    }
    return _dayImage;
}

- (UILabel *)suggestLabel
{
    if (_suggestLabel == nil) {
        _suggestLabel = [[UILabel alloc] init];
        _suggestLabel.text = @"热门推荐";
        _suggestLabel.textColor = [UIColor blackColor];
    }
    return _suggestLabel;
}

- (UILabel *)starLabel
{
    if (_starLabel == nil) {
        _starLabel = [[UILabel alloc] init];
        _starLabel.text = @"热门收藏";
        _starLabel.textColor = [UIColor blackColor];
    }
    return _starLabel;
}
- (UILabel *)monthLabel
{
    if (_monthLabel == nil) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.text = @"本月热点";
        _monthLabel.textColor = [UIColor blackColor];
    }
    return _monthLabel;
}
- (UILabel *)dayLabel
{
    if (_dayLabel == nil) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.text = @"今日热点";
        _dayLabel.textColor = [UIColor blackColor];
    }
    return _dayLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
