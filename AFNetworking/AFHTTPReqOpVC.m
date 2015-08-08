//
//  AFHTTPReqOpVC.m
//  AFNetworking
//
//  Created by qing yun on 15/8/5.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "AFHTTPReqOpVC.h"
#import "AFHTTPRequestOperation.h"
#import "common.h"


@interface AFHTTPReqOpVC ()

@end

@implementation AFHTTPReqOpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)get:(UIButton *)sender {
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"response.json"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}


@end
