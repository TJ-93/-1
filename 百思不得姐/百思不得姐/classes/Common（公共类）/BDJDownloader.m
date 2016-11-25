//
//  BDJDownloader.m
//  百思不得姐
//
//  Created by qianfeng on 2016/11/22.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import "BDJDownloader.h"
#import <AFNetworking/AFNetworking.h>
@implementation BDJDownloader
+(void)downloadWithURLString:(NSString *)urlString success:(void(^)(NSData *data)) finishBlock fail:(void(^)(NSError *error)) failBlock{
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager=[[AFURLSessionManager alloc]initWithSessionConfiguration:config];
    //设置返回二进制数据
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *task=[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error){
            failBlock(error);
        }else{
            NSHTTPURLResponse *r=(NSHTTPURLResponse *)response;
            if (r.statusCode==200){
//                返回正确的数据
                finishBlock(responseObject);
            }else{
                NSError *e=[NSError errorWithDomain:urlString code:r.statusCode userInfo:@{@"msg":@"下载失败"}];
                failBlock(e);
            }
        }
    }];
    [task resume];
}
@end
