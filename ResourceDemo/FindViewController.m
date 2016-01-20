//
//  ViewController.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/10.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "FindViewController.h"
#import "common.h"

@interface FindViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) SmallScrollView *menuItemView;
@property (nonatomic, strong) BigScrollView *tableScrollView;

@property (nonatomic, strong) TheStarView *starView;
@property (nonatomic, strong) TheSuggestView *suggestView;
@property (nonatomic, strong) TheDayView *dayView;
@property (nonatomic, strong) TheMonthView *monthView;

@property (nonatomic, strong) NSArray *itemsArray;

@end

@implementation FindViewController

static NSString *suggectIdentifier = @"suggest cell";
static NSString *starItemIdentifier = @"star item";
static NSString *monthCellIdentifier = @"month cell";
static NSString *dayItemIdentifier = @"day item";

- (void)viewDidLoad {
    [super viewDidLoad];
    //_suggestView.pageIndex = 1;
    _itemsArray = @[@"推荐", @"收藏", @"本月", @"今日"];
    
    
    [self createMenuItemScrollView];
    [self createViewWithScrollView];
    
    [self changeIndex];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createMenuItemScrollView
{
    _menuItemView = [[SmallScrollView alloc] initWithButtonArr:_itemsArray];
    
    __weak FindViewController *weakSelf = self;
    void (^changeValue)(NSInteger) = ^(NSInteger currentIndex){
        _currentIndex = currentIndex;
        [weakSelf changeIndex];
        
    };
    [_menuItemView setValue:changeValue forKey:@"changeIndexValue"];
    
    [self.view addSubview:_menuItemView];
}

- (void)changeIndex
{
    switch (_currentIndex) {
        case 0:
            self.tableScrollView.contentOffset = CGPointMake(0, 0);
            break;
        case 1:
            self.tableScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            break;
        case 2:
            self.tableScrollView.contentOffset = CGPointMake(kScreenWidth * 2, 0);
            break;
        case 3:
            self.tableScrollView.contentOffset = CGPointMake(kScreenWidth * 3, 0);
            break;
            
        default:
            break;
    }
    _menuItemView.index = _currentIndex;
}

- (void)createViewWithScrollView
{
    _tableScrollView = [[BigScrollView alloc] initBigScrollView];
    _tableScrollView.delegate = self;
    _tableScrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_tableScrollView];
    
    _dayView = [[TheDayView alloc] initWithFrame:CGRectMake(kScreenWidth * 3, 0, kScreenWidth, kScrrenHeight )];
    _dayView.backgroundColor = [UIColor colorWithRed:223/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [_dayView addSubviews];
    _dayView.collectionView.delegate = self;
    _dayView.collectionView.dataSource = self;
    [_tableScrollView addSubview:_dayView];
    
    _monthView = [[TheMonthView alloc] initWithFrame:CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScrrenHeight )];
    [_monthView addSubviews];
    _monthView.tableView.dataSource = self;
    _monthView.tableView.delegate = self;
    [_tableScrollView addSubview:_monthView];
    
    _starView = [[TheStarView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScrrenHeight )];
    _starView.backgroundColor = [UIColor colorWithRed:223/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [_starView addSubviews];
    _starView.collectionView.delegate = self;
    _starView.collectionView.dataSource = self;
    [_tableScrollView addSubview:_starView];
    
    _suggestView = [[TheSuggestView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrrenHeight )];
    [_suggestView addSubviews];
    _suggestView.contentTableView.delegate = self;
    _suggestView.contentTableView.dataSource = self;
    [_tableScrollView addSubview:_suggestView];
}

- (UIViewController *)pushVC:(TheMainModel *)model
{
    TheContentShowViewController *showVC = [[TheContentShowViewController alloc] init];

    [showVC setValue:model.share forKey:@"url"];
    return showVC;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_tableScrollView]) {
        CGPoint point = _tableScrollView.contentOffset;
        _currentIndex = point.x / kScreenWidth;
    }
    _menuItemView.index = _currentIndex;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_suggestView.contentTableView]) {
        return _suggestView.contentArray.count;
    }
    if ([tableView isEqual:_monthView.tableView]) {
        return _monthView.contentArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_suggestView.contentTableView]) {
        TheSuggestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:suggectIdentifier forIndexPath:indexPath];

        TheMainModel *model = _suggestView.contentArray[indexPath.row];
        cell.model = model;
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1];
        }else {
            cell.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        }
        return cell;
    }
    
    if ([tableView isEqual:_monthView.tableView]) {
        TheMonthTableViewCell *monthCell = [tableView dequeueReusableCellWithIdentifier:monthCellIdentifier];
        TheMainModel *model = _monthView.contentArray[indexPath.row];
        monthCell.model = model;
        return monthCell;
    }
    return nil;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:_suggestView.contentTableView]) {
        [self.navigationController pushViewController:[self pushVC:_suggestView.contentArray[indexPath.row]] animated:YES];
    }
    if ([tableView isEqual:_monthView.tableView]) {
        [self.navigationController pushViewController:[self pushVC:_monthView.contentArray[indexPath.row]] animated:YES];
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation((90.0 * M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0 / -600;
    
    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    
    [UIView commitAnimations];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _starView.contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:_starView.collectionView]) {
        TheStarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:starItemIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        TheMainModel *model = _starView.contentArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    if ([collectionView isEqual:_dayView.collectionView]) {
        TheDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dayItemIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        TheMainModel *model = _dayView.contentArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    return nil;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:_starView.collectionView]) {
        [self.navigationController pushViewController:[self pushVC:_starView.contentArray[indexPath.row]] animated:YES];
    }
    if ([collectionView isEqual:_dayView.collectionView]) {
        [self.navigationController pushViewController:[self pushVC:_dayView.contentArray[indexPath.row]] animated:YES];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(170, 200);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
