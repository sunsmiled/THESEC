//
//  AFNetStateMonitorVC.m
//  AFNetworking
//
//  Created by qing yun on 15/8/5.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "AFNetStateMonitorVC.h"
#import "AFNetworkReachabilityManager.h"

@interface AFNetStateMonitorVC ()

@property (nonatomic,strong) AFNetworkReachabilityManager *manager;
@end

@implementation AFNetStateMonitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFNetworkReachabilityManager sharedManager];
    
    [_manager setReachabilityStatusChangeBlock:^ void(AFNetworkReachabilityStatus status) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络状态" message: AFStringFromNetworkReachabilityStatus(status) delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }];
    // Do any additional setup after loading the view.
}
- (IBAction)startMonitor:(UIButton *)sender {
    
    if (!sender.selected) {
        [_manager startMonitoring];
        sender.selected = YES;
    }else{
        [_manager stopMonitoring];
        sender.selected = NO;
    }
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
