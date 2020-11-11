//
//  CSRequest.h
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSUInteger, CSRequestMethod) {
    CSRequestMethod_GET,
    CSRequestMethod_POST,
    CSRequestMethod_HEADER,
    CSRequestMethod_PUT,
    CSRequestMethod_DELETE,
};

@interface CSRequest : NSObject


@property (nonatomic, copy, readonly)NSString *urlStr;
@property (nonatomic, assign)CSRequestMethod method;
@property (nonatomic, copy, readonly)NSString *methodStr;

@property (nonatomic, copy)NSString *baseServer;
@property (nonatomic, copy)NSString *path;
@property (nonatomic, copy)NSDictionary *paramaters;
@property (nonatomic, copy)NSDictionary *headers;

@property (nonatomic, assign)BOOL automaticHandleError;
@property (nonatomic, strong)NSURLSessionTask *task;

+ (instancetype)request;

@end

NS_ASSUME_NONNULL_END
