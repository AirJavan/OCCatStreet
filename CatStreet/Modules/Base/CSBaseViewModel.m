//
//  CSBaseViewModel.m
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import "CSBaseViewModel.h"

@implementation CSBaseViewModel

+ (instancetype)viewModel {
    return [[[self class] alloc] init];
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestBunch = [[CSRequestBunch alloc] init];
    }
    return self;
}

-(void)dealloc {
    [self.requestBunch cancelAllRequests];
}

@end

