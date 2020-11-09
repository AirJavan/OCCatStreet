//
//  CSNetwork.m
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import "CSNetwork.h"
#import <AFNetworking/AFNetworking.h>

@implementation CSNetwork

+ (nullable NSURLSessionTask *)sendRequest:(CSRequest *)request completion:(CSNetworkBlock)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setTimeoutInterval:30];
    [requestSerializer setValue:@"CatStreet-ios" forHTTPHeaderField:@"User-Agent"];
    int hour = (int)([[NSTimeZone localTimeZone] secondsFromGMT] / 3600);
    int min = (int)([[NSTimeZone localTimeZone] secondsFromGMT] % 3600);
    [requestSerializer setValue:[NSString stringWithFormat:@"%@%d:%d", hour > 0 ? @"+": @"-",abs(hour), abs(min)] forHTTPHeaderField:@"timezone"];

    manager.requestSerializer = requestSerializer;
        
    NSURLSessionTask *task = [manager dataTaskWithHTTPMethod:request.methodStr
                                                   URLString:request.urlStr
                                                 parameters:request.paramaters
                                                    headers:request.headers
                                             uploadProgress:nil
                                           downloadProgress:nil
                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion([CSResponse responseWithTask:task responseObject:responseObject error:nil]);
        }
    }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion([CSResponse responseWithTask:task responseObject:nil error:error]);
        }
    }];
    if (task) {
        [task resume];
        [request didSend:task];
    }
    return task;
}

@end
