//
//  HomeViewController.m
//  XHAVAudioPlayer
//
//  Created by xiaohui on 2017/10/26.
//  Copyright © 2017年 XIAOHUI. All rights reserved.
//

#import "HomeViewController.h"
#import "XGTCKeYuanHistoryViewController.h"
#import "XGTCAVAudioManager.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"AVAudioPlayer";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"->" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNextPage)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)pushToNextPage
{
    [self.navigationController pushViewController:[[XGTCKeYuanHistoryViewController alloc] init] animated:YES];
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
