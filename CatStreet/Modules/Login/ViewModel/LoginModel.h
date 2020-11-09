//
//  LoginModel.h
//  CatStreet
//
//  Created by Fluva on 2020/11/6.
//

#import "CSBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface LoginModel : CSBaseViewModel

@property (nonatomic, readwrite, assign) LoginType loginType;


/// phone
@property (nonatomic, readwrite, copy) NSString *phone;
/// captcha
@property (nonatomic, readwrite, copy) NSString *captcha;
/// password
@property (nonatomic, readwrite, copy) NSString *password;


/// LoginCommand
@property (nonatomic, readonly, strong) RACCommand *loginCommand;

/// 登录按钮有效性
@property (nonatomic, readonly, strong) RACSignal *validLoginSignal;

/// 验证码命令
@property (nonatomic, readonly, strong) RACCommand *captchaCommand;


/// 验证码按钮能否点击
@property (nonatomic, readonly, strong) RACSignal *validCaptchaSignal;

/// 验证码显示
@property (nonatomic, readonly, copy) NSString *captchaTitle;

///// 验证码显示
//@property (nonatomic, readonly, copy) NSString *captchaTitle

/// 验证码显示
//@property (nonatomic, readonly, copy) NSString *captchaTitle

@end

NS_ASSUME_NONNULL_END
