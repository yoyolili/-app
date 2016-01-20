//
//  IdeaViewController.m
//  ResourceDemo
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "IdeaViewController.h"

@interface IdeaViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation IdeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    // Do any additional setup after loading the view.
}
- (IBAction)send:(id)sender {
    
    _textField.text = @"";
    [self resignFirstResponder];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的意见已经提交,谢谢您的反馈~" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
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
