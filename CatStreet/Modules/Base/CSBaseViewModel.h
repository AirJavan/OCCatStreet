//
//  CSBaseViewModel.h
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSRequest.h"
#import "CSRequestBunch.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSBaseViewModel : NSObject
@property (nonatomic, strong) CSRequestBunch *requestBunch;

+ (instancetype)viewModel;

@end

NS_ASSUME_NONNULL_END
