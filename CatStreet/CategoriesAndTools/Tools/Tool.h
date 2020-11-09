//
//  Tool.h
//  CatStreet
//
//  Created by Fluva on 2020/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tool : NSObject

+ (NSString *)deviceId;

///验证手机号码规范
+ (BOOL)checkMobileNumber:(NSString *)moblieNum;

@end

NS_ASSUME_NONNULL_END
