//
//  CSError.h
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSRequest.h"

NS_ASSUME_NONNULL_BEGIN

@class CSResponse;
typedef void(^CSNetworkBlock)(CSResponse *response);

@interface CSResponse : NSObject

@property(nonatomic, assign, readonly)BOOL success;
@property(nonatomic, assign, readonly)NSInteger code;
@property(nonatomic, copy, readonly)NSString *message;
@property(nonatomic, strong, readonly)CSRequest *request;
@property(nonatomic, strong, readonly)NSDictionary *jsonDic;
@property(nonatomic, strong, readonly)NSError *error;

+ (CSResponse *)responseWithRequest:(CSRequest *)request
                  responseObject:(id __nullable)responseObject
                           error:(NSError *__nullable)error;

@end

NS_ASSUME_NONNULL_END
