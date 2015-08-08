
//
//  AFHTTPSessionMgrVC.m
//  AFNetworking
//
//  Created by qing yun on 15/8/5.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "AFHTTPSessionMgrVC.h"
#import "common.h"
#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionMgrVC ()

@end

@implementation AFHTTPSessionMgrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)get:(UIButton *)sender {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"request_get.json"];
    
    NSDictionary *parameters = @{@"foo":@"bar"};
    
    [manager GET:urlStr parameters:parameters success:^void(NSURLSessionDataTask * task, id responseObj) {
        NSLog(@"%@",responseObj);
        
    } failure:^void(NSURLSessionDataTask *task,NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (IBAction)formEncoded:(UIButton *)sender {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"request_post_body_http.json"];
    NSDictionary *parameters = @{@"foo":@"bar"};
    
    [manager POST:urlStr parameters:parameters success:^void(NSURLSessionDataTask * task, id responseObj) {
        NSLog(@"%@",responseObj);
        
    } failure:^void(NSURLSessionDataTask *task, NSError * error) {
        NSLog(@"%@",error);
    }];
}
- (IBAction)multiPart:(UIButton *)sender {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"upload2server.json"];
    
    NSURL *fileURL1 = [[NSBundle mainBundle] URLForResource:@"5" withExtension:@"jpg"];
    NSURL *fileURL2 = [[NSBundle mainBundle] URLForResource:@"6" withExtension:@"jpg"];
    
   [manager POST:urlStr parameters:nil constructingBodyWithBlock:^void(id<AFMultipartFormData> formData) {
       
       
       [formData appendPartWithFileURL:fileURL1 name:@"image" fileName:@"XXX.jpg" mimeType:@"image/jpeg" error:nil];
       [formData appendPartWithFileURL:fileURL2 name:@"image" fileName:@"yyyy.jpg" mimeType:@"image/jpeg" error:nil];
   } success:^void(NSURLSessionDataTask *task,id responseObj)
    {
        NSLog(@"%@",responseObj);
    }failure:^void(NSURLSessionDataTask *task,NSError *error) {
        NSLog(@"%@",error);
    }];
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
