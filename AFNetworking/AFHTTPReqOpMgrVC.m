//
//  AFHTTPReqOpMgrVC.m
//  AFNetworking
//
//  Created by qing yun on 15/8/5.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "AFHTTPReqOpMgrVC.h"
#import "common.h"
#import "AFHTTPRequestOperationManager.h"

@interface AFHTTPReqOpMgrVC ()

@end

@implementation AFHTTPReqOpMgrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)get:(UIButton *)sender {
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"request_get.json"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"foo":@"bar"};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
- (IBAction)postFormEncoded:(UIButton *)sender {
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"request_post_body_http.json"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"foo":@"bar"};
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
//    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"request_post_body_http.json"];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    NSDictionary *parameters = @{@"foo": @"bar"};
//
//        [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];

}
- (IBAction)postMultiPart:(UIButton *)sender {
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"upload2server.json"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"1" withExtension:@"jpg"];
    NSURL *filePath2 = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"jpg"];
    
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^ void(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"通过wifi下载");
        }
    }];
    [manager.reachabilityManager startMonitoring];
    
    
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
        [formData appendPartWithFileURL:filePath2 name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
