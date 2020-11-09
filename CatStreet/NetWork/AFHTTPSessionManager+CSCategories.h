//
//  AFHTTPSessionManager+CSCategories.h
//  CatStreet
//
//  Created by Fluva on 2020/7/22.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (CSCategories)

- (void)POST:(NSString *)URLString
parameters:(nullable id)parameters
   success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
   failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

- (void)GET:(NSString *)URLString
parameters:(nullable id)parameters
   success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
   failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
