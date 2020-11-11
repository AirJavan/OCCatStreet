//
//  CSRequestBunch.h
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSRequest.h"
#import "CSResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSRequestBunch : NSObject


@property (nonatomic, strong, readonly)NSArray<CSRequest *>* requests;

+ (instancetype)requestBunch;

- (void)cancelAllRequests;

- (void)request:(void(^)(CSRequest *request))requestConfig completion:(CSNetworkBlock)completion;

@end

NS_ASSUME_NONNULL_END
