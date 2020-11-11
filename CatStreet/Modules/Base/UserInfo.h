//
//  UserInfo.h
//  CatStreet
//
//  Created by Fluva on 2020/11/4.
//

#import "CSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : CSBaseModel
<NSCopying, NSCoding>


@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *catId;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *selfDesc;

@property (nonatomic, copy) NSString *wechatNo;
@property (nonatomic, copy) NSString *qqNo;
@property (nonatomic, copy) NSString *timeId;


@property (nonatomic, assign) CGFloat *height;
@property (nonatomic, assign) CGFloat *weight;


@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, assign) BOOL IM_isLogin;

@property (nonatomic, assign) BOOL isRealPeople;



@property (nonatomic, assign) BOOL isPerfect; /*是否完善资料*/

@property (nonatomic, assign) BOOL isMember;


@property (nonatomic) long memberEndTime;/*会员过期时间*/

@property (nonatomic, assign) UserGenderType sex;

@property (nonatomic, assign) LoginType channel; /*登录方式*/

@property (nonatomic, assign) VideoAuthStatus isAuth; /*是否视频认证*/


+ (UserInfo *)shareInstance;

@end

#define DWObjectCodingImplmentation CodingImplmentation

NS_ASSUME_NONNULL_END
