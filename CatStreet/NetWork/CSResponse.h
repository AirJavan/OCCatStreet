//
//  CSError.h
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSResponse : NSObject

@property(nonatomic, assign, readonly)BOOL success;
@property(nonatomic, assign, readonly)NSInteger code;
@property(nonatomic, copy, readonly)NSString *message;
@property(nonatomic, strong, readonly)NSURLSessionTask *task;
@property(nonatomic, strong, readonly)NSURLRequest *request;
@property(nonatomic, strong, readonly)NSURLResponse *response;
@property(nonatomic, strong, readonly)NSDictionary *jsonDic;
@property(nonatomic, strong, readonly)NSError *error;

+ (CSResponse *)responseWithTask:(NSURLSessionTask *)task
                  responseObject:(id __nullable)responseObject
                           error:(NSError *__nullable)error;

@end

NS_ASSUME_NONNULL_END
