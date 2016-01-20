//
//  SettingViewController.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "SettingViewController.h"
#import "SDImageCache.h"
#import "IdeaViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setLabel];
}

- (void)setLabel
{
    CGFloat size = [[SDImageCache sharedImageCache] getSize];
    
    _cacheLabel.text = [NSString stringWithFormat:@"缓存%.2lfM" , size / 1024 / 1024 ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else if (section == 1) {
        return 2;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            CGFloat size = [[SDImageCache sharedImageCache] getSize];
            
            if (size > 0) {
                NSString *count = [NSString stringWithFormat:@"是否清除[ %.2lfM ]的缓存" , size / 1024 / 1024 ];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:count delegate:self cancelButtonTitle:nil otherButtonTitles:@"清除" ,  @"取消" , nil];
                [alert show];
                
            }else
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"暂无缓存" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }else if (indexPath.row == 2) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经是最新版本!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }else if (indexPath.row == 3) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            IdeaViewController *ideaVC = [story instantiateViewControllerWithIdentifier:@"ideaVC"];
            [self.navigationController pushViewController:ideaVC animated:YES];
        }
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"开发者信息" message:@"QQ:839632616\nTel:15238609725\nemail:839632616@qq.com" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }else if (indexPath.row == 1){
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"aboutVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 清除缓存的提示框 相应的点击方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _cacheLabel.text = [NSString stringWithFormat:@"缓存0.0M"];
        [[SDImageCache sharedImageCache] clearDisk];
    }else{
        return ;
    }
}

@end
