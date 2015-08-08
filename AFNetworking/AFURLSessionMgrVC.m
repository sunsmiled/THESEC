//
//  AFURLSessionMgrVC.m
//  AFNetworking
//
//  Created by qing yun on 15/8/5.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "AFURLSessionMgrVC.h"
#import "common.h"
#import "AFURLSessionManager.h"

@interface AFURLSessionMgrVC ()

@property (weak, nonatomic) IBOutlet UIProgressView *download;

@property (weak, nonatomic) IBOutlet UIProgressView *upLoadProgress;

@end

@implementation AFURLSessionMgrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)downLoad:(UIButton *)sender {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *urlStr = @"http://tingge.5nd.com/20060919//2014/2014-8-20/63916/1.Mp3";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    NSProgress *progress;
    NSURLSessionDownloadTask *downloasTask = [manager downloadTaskWithRequest:request progress:&progress destination:^ NSURL * (NSURL * tagerPath, NSURLResponse * response) {
        
        
        NSString *suggesedName = response.suggestedFilename;
        NSString *path = [@"/Users/qingyun/Desktop" stringByAppendingPathComponent:suggesedName];
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse *response,NSURL *filePath,NSError *error) {
        NSLog(@"file downloaded to:%@",filePath);
    }];
    [downloasTask resume];
    
    [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:(__bridge void *)(_download)];
}

- (IBAction)upLoad:(UIButton *)sender {
    
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"upload2server.json"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"3" withExtension:@"jpg"];
    NSURL *fileURL1 = [[NSBundle mainBundle] URLForResource:@"4" withExtension:@"jpg"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileURL:fileURL name:@"image" fileName:@"beauty1.jpg" mimeType:@"image/jpeg" error:nil];
        [formData appendPartWithFileURL:fileURL1 name:@"image" fileName:@"girl.jpg" mimeType:@"image/jpeg" error:nil];
        
         
    } error:nil];
    
    NSProgress *progress;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response,id responseObject,NSError *error) {
        if (error) {
            NSLog(@"Error:%@",error);
        }else {
            NSLog(@"%@ %@",response,responseObject);
        }
    }];
    
    [uploadTask resume];
    
    
    [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:(__bridge void *)(_upLoadProgress)];
}





- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"completedUnitCount"]) {
        int64_t completed = [change[@"new"] longLongValue];
        
        NSProgress *progress = object;
        int64_t total = progress.totalUnitCount;
        
        float progressValue = (float)completed / (float)total;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIProgressView *progressView = (__bridge UIProgressView *)(context);
            progressView.progress = progressValue;
        });
    }
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
