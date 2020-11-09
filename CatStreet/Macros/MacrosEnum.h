//
//  MacrosEnum.h
//  CatStreet
//
//  Created by Fluva on 2020/11/4.
//

#ifndef MacrosEnum_h
#define MacrosEnum_h

@import Foundation;


// 接口返回CODE
typedef NS_ENUM(NSUInteger, CsCode) {
    CsCode_Success = 2000,         //!< 成功
    CsCode_AccessToken = 4001,     //!< accessToken 过期
    CsCode_RefreshToken  = 4003    //!< refreshToken 过期
};


typedef NS_ENUM (NSUInteger, VideoAuthStatus) {
    VideoAuthStatus_UnAuth,       //!<  未认证
    VideoAuthStatus_DidUpload,    //!< 视频已上传
    VideoAuthStatus_Success       //!< 认证成功
};

/// 用户性别
typedef NS_ENUM(NSUInteger, UserGenderType) {
    UserGenderTypeMale = 1,             //!< 男
    UserGenderTypeFemale,               //!<  女
    
};

/// 登录方式
typedef NS_ENUM(NSUInteger, LoginType) {
    LoginType_phonePassword, //!< 手机号密码登录
    LoginType_phoneCode,     //!< 手机号验证码登录
    LoginType_wx,
    LoginType_qq,
    LoginType_apple
};


/// HUD位置
typedef NS_ENUM(NSUInteger, HUDPosition) {
    HUDPosition_Top,
    HUDPosition_center,
    HUDPosition_Bottom
};


//验证码作用
typedef NS_ENUM(NSUInteger, PhoneCodeType) {
    PhoneCodeType_Login,            //!< 登录
    PhoneCodeType_ForgetPassWord
};
#endif /* MacrosEnum_h */
