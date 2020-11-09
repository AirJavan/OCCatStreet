//
//  CSNetwork.h
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSResponse.h"
#import "CSRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CSNetworkBlock)(CSResponse *response);

@interface CSNetwork : NSObject

+ (nullable NSURLSessionTask *)sendRequest:(CSRequest *)request completion:(CSNetworkBlock)completion;

@end

NS_ASSUME_NONNULL_END
