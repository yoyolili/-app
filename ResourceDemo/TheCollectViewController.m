//
//  TheCollectViewController.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheCollectViewController.h"
#import "common.h"

@interface TheCollectViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) TheMainInfoTableViewCell *cell;

@end

@implementation TheCollectViewController

static NSString *collectIdentifier = @"collect cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    self.contentArray = [[DBFileManager shareHandle] selectAllValue];
    for (int i = 0; i < 4; i++) {
        [self.contentArray removeObjectAtIndex:0];
    }
    [self createTableView];
    
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    // Do any additional setup after loading the view.
}
#pragma mark - create tableview
- (void)createTableView
{
    [_tableView registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:nil] forCellReuseIdentifier:collectIdentifier];
}

- (void)editAction:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
        [_tableView setEditing:YES animated:YES];
    }else{
        item.title = @"编辑";
        [_tableView setEditing:NO animated:YES];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:collectIdentifier forIndexPath:indexPath];

    _cell.model = self.contentArray[indexPath.row];
    return _cell;
}

#pragma mark - edit tableView -> delete
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //允许编辑
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.contentArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [[DBFileManager shareHandle] deleteDataFromUrl:_cell.model.share];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheContentShowViewController *showVC = [[TheContentShowViewController alloc] init];
    TheMainModel *model = self.contentArray[indexPath.row];
    [showVC setValue:model.share forKey:@"url"];
    [self.navigationController pushViewController:showVC animated:YES];
}

#pragma mark - lazy loading
- (NSMutableArray *)contentArray
{
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}


@end
