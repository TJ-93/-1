//
//  BDJDownloader.h
//  百思不得姐
//
//  Created by qianfeng on 2016/11/22.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void(^SUCCESSBLOCK)(NSData *data);
typedef void(^FAILBLOCK)(NSError *error) ;
@interface BDJDownloader : NSObject
+(void)downloadWithURLString:(NSString *)urlString success:(void(^)(NSData *data)) finishBlock fail:(void(^)(NSError *error)) failBlock;
//参数名可以省略;闭包去掉闭包名字就是闭包类型

//+(void)downloadWithURLString:(NSString *)urlString success:(void(^)(NSData *)) finishBlock fail:(void(^)(NSError *)) failBlock;
//+(void)downloadWithURLString:(NSString *)urlString success:(SUCCESSBLOCK) finishBlock fail:(FAILBLOCK) failBlock;
@end
