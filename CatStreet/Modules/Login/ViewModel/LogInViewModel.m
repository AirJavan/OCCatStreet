//
//  LogInViewModel.m
//  CatStreet
//
//  Created by 贾向毅 on 2020/11/11.
//

#import "LogInViewModel.h"

@implementation LogInViewModel

- (void)requestVerificationCodeWithPhoneNumber:(NSString *)number
                                    completion:(CSNetworkBlock)completion {
    
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)time];
    
    
    NSString *stringSignTemp = [NSString stringWithFormat:@"phoneType=0&phoneNum=%@&timestamp=%@sWHbHGr8pA", number,timeString];
    NSString *sign = stringSignTemp.md5String;
    
    
    
    
    [self.requestBunch request:^(CSRequest * _Nonnull request) {
        request.method = CSRequestMethod_POST;
        request.path = @"/user/getVerifCode";
        request.paramaters = @{@"phoneNum":number,
                               @"phoneType":[NSNumber numberWithInt:0],
                               @"timestamp":timeString,
                               @"sign":sign
        };
    } completion:completion];
}


- (void)loginWithPhoneNumber:(NSString *)number
                    password:(NSString *)password
                  completion:(void(^)(UserInfo *userInfo))completion {
    
    NSMutableDictionary *params =  [[NSMutableDictionary alloc]init];
    NSString *deviceId = [Tool deviceId];
    
    [params setObject:number forKey:@"phone"];
    [params setObject:password forKey:@"password"];
    [params setObject:deviceId forKey:@"deviceInfo"];
    [params setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appVersion"];
    
    
    [self.requestBunch request:^(CSRequest * _Nonnull request) {
        request.method = CSRequestMethod_POST;
        request.automaticHandleError = YES;
        request.path = @"/user/loginApp";
        request.paramaters = @{@"phone":number,
                               @"password":password,
                               @"deviceInfo":deviceId,
                               @"appVersion":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
        };
    } completion:^(CSResponse * _Nonnull response) {
        if (completion) {
            if (response.success) {
                completion([UserInfo mj_objectWithKeyValues:response.jsonDic]);
            } else {
                completion(nil);
            }
        }
    }];
}


@end
