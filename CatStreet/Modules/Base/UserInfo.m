//
//  UserInfo.m
//  CatStreet
//
//  Created by Fluva on 2020/11/4.
//

#import "UserInfo.h"
#import "WZLSerializeKit.h"


@implementation UserInfo


WZLSERIALIZE_CODER_DECODER();

WZLSERIALIZE_COPY_WITH_ZONE();

WZLSERIALIZE_DESCRIPTION();

static UserInfo *g_userInfo = nil;

+ (UserInfo *)shareInstance
{
    if(g_userInfo == nil)
    {
        g_userInfo = [UserInfo getLastUser];
        if(g_userInfo == nil)
        {
            g_userInfo = [[UserInfo alloc] init];
        }
    }
    return g_userInfo;
}
    
+ (UserInfo *)getLastUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"lastUserInfo"];
    if(data)
    {
        return [NSKeyedUnarchiver unarchivedObjectOfClass:[UserInfo class] fromData:data error:nil];
    }
    return nil;
}
    
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
                  completion:(CSNetworkBlock)completion {
    
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
    } completion:completion];
}

@end
