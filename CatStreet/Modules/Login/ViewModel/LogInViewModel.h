//
//  LogInViewModel.h
//  CatStreet
//
//  Created by 贾向毅 on 2020/11/11.
//

#import "CSBaseViewModel.h"
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogInViewModel : CSBaseViewModel



/**
 获取验证码
 */
- (void)requestVerificationCodeWithPhoneNumber:(NSString *)number
                                    completion:(CSNetworkBlock)completion;

/**
 登录
 */
- (void)loginWithPhoneNumber:(NSString *)number
                    password:(NSString *)password
                  completion:(void(^)(UserInfo *userInfo))completion;

@end

NS_ASSUME_NONNULL_END
