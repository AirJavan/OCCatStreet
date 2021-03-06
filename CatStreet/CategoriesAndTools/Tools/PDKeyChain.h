//
//  PDKeyChain.h
//  PDKeyChain
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface PDKeyChain : NSObject

+ (void)keyChainSave:(NSString *)string;
+ (NSString *)keyChainLoad;
+ (void)keyChainLockPswSave:(NSString *)string;
+ (NSString *)keyChainLockPswLoad;
+ (void)keyChainDelete;

@end
