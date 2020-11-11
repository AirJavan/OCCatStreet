//
//  CSRequestBunch.m
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import "CSRequestBunch.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface CSRequestBunch()
@property (nonatomic, strong)NSMutableArray<CSRequest *>* requestsHolder;
@property (nonatomic, strong)AFHTTPSessionManager* manager;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation CSRequestBunch

+ (instancetype)requestBunch {
    return [[CSRequestBunch alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.lock = [[NSLock alloc] init];
    }
    return self;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        [requestSerializer setTimeoutInterval:30];
        [requestSerializer setValue:@"CatStreet-ios" forHTTPHeaderField:@"User-Agent"];
        int hour = (int)([[NSTimeZone localTimeZone] secondsFromGMT] / 3600);
        int min = (int)([[NSTimeZone localTimeZone] secondsFromGMT] % 3600);
        [requestSerializer setValue:[NSString stringWithFormat:@"%@%d:%d", hour > 0 ? @"+": @"-",abs(hour), abs(min)] forHTTPHeaderField:@"timezone"];

        _manager.requestSerializer = requestSerializer;
    }
    return _manager;
}
- (void)cancelAllRequests {
    [self.manager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
        [self.lock lock];
        CSRequest *request = [self requestForTask:obj];
        if (request) {
            [self.requestsHolder removeObject:request];
        }
        [self.lock unlock];
    }];
}

- (void)request:(void(^)(CSRequest *request))requestConfig completion:(CSNetworkBlock)completion {
    if (requestConfig) {
        CSRequest *request = [CSRequest request];
        //设置token
        requestConfig(request);
        NSURLSessionTask *task = [self.manager dataTaskWithHTTPMethod:request.methodStr
                                                       URLString:request.urlStr
                                                     parameters:request.paramaters
                                                        headers:request.headers
                                                 uploadProgress:nil
                                               downloadProgress:nil
                                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completion) {
                CSRequest *currentRequest = [self requestForTask:task];
                [self.requestsHolder removeObject:request];
                CSResponse *response = [CSResponse responseWithRequest:currentRequest responseObject:responseObject error:nil];
                NSLog(@"%@", response);
                if(request.automaticHandleError && response.error) {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.lastObject animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = response.error.userInfo[@"NSLocalizedDescriptionKey"];
                    [hud hideAnimated:YES afterDelay:2];
                }
                if (response.code == CsCode_AccessToken) {
                    [self request:^(CSRequest * _Nonnull request) {
                        request.method = currentRequest.method;
                        request.baseServer = currentRequest.baseServer;
                        request.path = currentRequest.path;
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:currentRequest.paramaters];
                        [dic setValue:@"" forKey:@"refreshToken"];
                        request.paramaters = dic;
                        request.headers = currentRequest.headers;
                        request.automaticHandleError = currentRequest.automaticHandleError;
                    } completion:^(CSResponse * _Nonnull response) {
                        if (response.code == CsCode_RefreshToken) {
                            //展示登录界面
                        } else {
                            if (completion) {
                                completion(response);
                            }
                        }
                    }];
                } else {
                    if (completion) {
                        completion(response);
                    }
                }
            }
        }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (completion) {
                CSRequest *request = [self requestForTask:task];
                [self.requestsHolder removeObject:request];
                CSResponse *response = [CSResponse responseWithRequest:request responseObject:nil error:error];
                NSLog(@"%@", response);
                if (completion) {
                    completion(response);
                }
            }
        }];
        [task resume];
        request.task = task;
        [self.requestsHolder addObject:request];
    } else {
        NSLog(@"请配置请求path,参数等");
    }
}

- (NSArray<CSRequest *> *)requests {
    return self.requestsHolder;
}

- (void)dealloc {
    [self cancelAllRequests];
}

- (CSRequest *)requestForTask:(NSURLSessionTask *)task {
    __block CSRequest *request = nil;
    [self.lock lock];
    [self.requestsHolder enumerateObjectsUsingBlock:^(CSRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.task == task) {
            request = obj;
            *stop = YES;
        }
    }];
    [self.lock unlock];
    return request;
}

@end
