//
//  MainViewController.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/10.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "MainViewController.h"
#import "common.h"


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) SideBarViewController *sideBarVC;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSTimer *workTimer;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic) NSInteger pageIndex;

@end

@implementation MainViewController

static NSString *identifier = @"main cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageIndex = 0;

    [self createNavigationView];
    [self createSideBar];
    [self createGesture];
    [self createTableView];
    [self loadMoreDataFromNet];
    
    // Do any additional setup after loading the view.
}

#pragma mark - View
- (void)createNavigationView
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:88/255.0 green:89/255.0 blue:110/255.0 alpha:0.8];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"image_nav"] forBarMetrics:0];
    self.navigationItem.title = @"首页";
    
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-faxian"] style:UIBarButtonItemStylePlain target:self action:@selector(showFindVC)];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}

- (void)createSideBar
{
    self.sideBarVC = [[SideBarViewController alloc] init];
    [self.sideBarVC setBgRGB:0x000000];
    [self.view addSubview:self.sideBarVC.view];
    self.sideBarVC.menuTableView.delegate = self;
    self.sideBarVC.menuTableView.dataSource = self;
    self.sideBarVC.view.frame = self.view.bounds;
}

- (void)createTableView
{
    
    [_tableView registerNib:[UINib nibWithNibName:@"TheMainInfoTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
  
    _tableView.frame = [UIScreen mainScreen].applicationFrame;
    _tableView.contentSize = CGSizeMake(kScreenWidth, self.titleArray.count * _tableView.rowHeight);
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [_tableView addPullToRefreshWithActionHandler:^{
        int64_t delayTime = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self refreshTriggered];
        });
    }];
    
    _tableView.pullToRefreshController.waitingAnimation = SpiralPullToRefreshWaitAnimationCircular;
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉加载");
        _pageIndex++;
        [self loadMoreDataFromNet];
    }];

}

- (void)refreshTriggered
{
    [_workTimer invalidate];
    //[self.titleArray removeAllObjects];
    [self loadMoreDataFromNet];
    _workTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(endFresh) userInfo:nil repeats:NO];
    //[self endFresh];
}

- (void)endFresh
{
    [_workTimer invalidate];
    _workTimer = nil;
    
    [_tableView.pullToRefreshController didFinishRefresh];
}

- (void)createGesture
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

- (void)showFindVC
{
    TheFindViewController *findVC = [[TheFindViewController alloc]initWithNibName:@"TheFindViewController" bundle:nil];
    [self.navigationController pushViewController:findVC animated:YES];
}

- (void)showMenu
{
    [self.sideBarVC showHideSidebar];
}

- (void)loadMoreDataFromNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    
    [manager GET:[NSString stringWithFormat:@"http://www.wezeit.com/index.php?m=Home&c=Api&a=getList&p=%ld&model=0&page_id=0&create_time=0&client=android&device_id=866819029961576&version=android_3.3.8",(long)_pageIndex] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"object >>> %@",responseObject);
        
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"datas"][@"list"];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *temp in array) {

            if (_pageIndex == 0) {
                TheMainModel *model = [[TheMainModel alloc] initWithDict:temp];
                [arr addObject:model];
            }else{
                TheMainModel *model = [[TheMainModel alloc] initWithDict:temp];
                [self.titleArray addObject:model];
            }
        }
        
        if (_pageIndex == 0) {
            self.titleArray = arr;
        }

        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error >>> %@",error);
    }];
    
    if (_refreshControl.isRefreshing) {
        [_refreshControl endRefreshing];
    }
    
    if (_tableView.mj_footer.isRefreshing) {
        [_tableView.mj_footer endRefreshing];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        return self.titleArray.count;
    }
    if ([tableView isEqual:self.sideBarVC.menuTableView]) {
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        TheMainInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        TheMainModel *model = self.titleArray[indexPath.row];
        
        cell.model = model;
        cell.backgroundColor = [UIColor lightGrayColor];
        
        return cell;
    }
    if ([tableView isEqual:self.sideBarVC.menuTableView]) {
        static NSString *menuIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:menuIdentifier];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        cell.textLabel.text = self.sideBarVC.className[indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.sideBarVC.imageArray[indexPath.row]]];
        return cell;
    }
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:self.tableView]) {
        TheContentShowViewController *showVC = [[TheContentShowViewController alloc] init];
        //NSDictionary *dict = self.titleArray[indexPath.row];
        TheMainModel *model = self.titleArray[indexPath.row];
        [showVC setValue:model.share forKey:@"url"];
        [self.navigationController pushViewController:showVC animated:YES];
    }
    if ([tableView isEqual:self.sideBarVC.menuTableView]) {
        if (indexPath.row == 0) {
            
            [self.sideBarVC showHideSidebar];
        }else if (indexPath.row == 1){
            [self.sideBarVC showHideSidebar];
            TheFindViewController *findVC = [[TheFindViewController alloc]initWithNibName:@"TheFindViewController" bundle:nil];
            [self.navigationController pushViewController:findVC animated:YES];
        }else if (indexPath.row == 2){
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TheCollectViewController *collectVC = [story instantiateViewControllerWithIdentifier:@"collectVC"];
            [self.navigationController pushViewController:collectVC animated:YES];
        
        }else if (indexPath.row == 3){
            [self.sideBarVC showHideSidebar];
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SettingViewController *settingVC = [story instantiateViewControllerWithIdentifier:@"settingVC"];
            [self.navigationController pushViewController:settingVC animated:YES];
        }
    }

}

//设置将要显示的行的动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = CATransform3DMakeTranslation(0.1, 0.1, 1);
    cell.layer.transform = CATransform3DInvert(rotation);
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1.2];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

#pragma mark - Lazy Loading

- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

@end
