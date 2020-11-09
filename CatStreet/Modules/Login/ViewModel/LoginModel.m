//
//  LoginModel.m
//  CatStreet
//
//  Created by Fluva on 2020/11/6.
//

#import "LoginModel.h"



@interface LoginModel ()


/// LoginCommand
@property (nonatomic, readwrite, strong) RACCommand *loginCommand;

/// 登录按钮有效性
@property (nonatomic, readwrite, strong) RACSignal *validLoginSignal;

/// 验证码命令
@property (nonatomic, readwrite, strong) RACCommand *captchaCommand;


/// 验证码按钮能否点击
@property (nonatomic, readwrite, strong) RACSignal *validCaptchaSignal;

/// 验证码显示
@property (nonatomic, readwrite, copy) NSString *captchaTitle;


@end



@implementation LoginModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
