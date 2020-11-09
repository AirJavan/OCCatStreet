//
//  Tool.m
//  CatStreet
//
//  Created by Fluva on 2020/11/5.
//

#import "Tool.h"
#import "PDKeyChain.h"

@implementation Tool

+ (NSString *)deviceId
{
    NSString *key = [PDKeyChain keyChainLoad];
    if(key && [key isKindOfClass:[NSString class]] && key.length>0)
    {
        return key;
    }
    key = [Tool generateGuid];
    [PDKeyChain keyChainSave:key];
    return key;
}

+ (NSString *)generateGuid
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    NSString    *uuidString = nil;
    if (uuidObj == NULL)
    {
        uuidString = [self createIdentifier];
        return uuidString;
    }
    
    CFStringRef uuidCFString = CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    
    if (uuidCFString == NULL)
    {
        uuidString = [self createIdentifier];
        return uuidString;
    }
    uuidString = (__bridge NSString *)(uuidCFString);
    uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(uuidCFString);
    
    return uuidString;
}

+ (NSString *)createIdentifier{
    NSString *source = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *identifier = [[NSMutableString alloc] initWithCapacity:8];
    
    while ([identifier length] < 8)
    {
        NSUInteger index = arc4random()%62;
        unichar random = [source characterAtIndex:index];
        [identifier appendFormat:@"%c", random];
    }
    
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    [identifier appendFormat:@"%.0f", nowTime];
    
    return identifier;
}



///验证手机号码规范
+ (BOOL)checkMobileNumber:(NSString *)moblieNum
{
    /**
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181,173,174,177
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|7[347]|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:moblieNum]
         || [regextestcm evaluateWithObject:moblieNum]
         || [regextestct evaluateWithObject:moblieNum]
         || [regextestcu evaluateWithObject:moblieNum])) {
        // 手机号可用
        return YES;
    } else {
        return NO;
    }
}

@end
