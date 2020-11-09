//
//  AFHTTPSessionManager+CSCategories.m
//  CatStreet
//
//  Created by Fluva on 2020/7/22.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import "AFHTTPSessionManager+CSCategories.h"

@implementation AFHTTPSessionManager (CSCategories)


- (void)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    [self POST:URLString
    parameters:parameters
       headers:nil
      progress:nil
       success:success
       failure:failure];
}

- (void)GET:(NSString *)URLString
parameters:(nullable id)parameters
   success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    [self GET:URLString
    parameters:parameters
       headers:nil
      progress:nil
       success:success
       failure:failure];

}


@end
