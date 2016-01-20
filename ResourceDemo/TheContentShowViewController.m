//
//  TheContentShowViewController.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/14.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TheContentShowViewController.h"

@interface TheContentShowViewController ()

@end

@implementation TheContentShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubview];
    // Do any additional setup after loading the view.
}

- (void)createSubview
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]]];
//    webView.frame = self.frame;
    [self.view addSubview:webView];
    [webView loadRequest:request];
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
