//
//  CSRequestBunch.m
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import "CSRequestBunch.h"

@interface CSRequestBunch()
@property (nonatomic, strong)NSMutableArray<CSRequest *>* requestsHolder;
@end

@implementation CSRequestBunch

+ (instancetype)requestBunch {
    return [[CSRequestBunch alloc] init];
}
- (void)cancelAllRequests {
    [self.requests enumerateObjectsUsingBlock:^(CSRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.task cancel];
    }];
}

- (void)cancelRequestWithIdentifier:(NSString *)identifier {
    [self.requests enumerateObjectsUsingBlock:^(CSRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:identifier]) {
            [obj.task cancel];
            *stop = YES;
        }
    }];
}

- (void)request:(void(^)(CSRequest *request))requestConfig completion:(CSNetworkBlock)completion {
    if (requestConfig) {
        CSRequest *request = [CSRequest request];
        requestConfig(request);
        [CSNetwork sendRequest:request completion:^(CSResponse * _Nonnull response) {
            NSLog(@"%@", response);
            
            if(request.automaticHandleError && response.error) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.lastObject animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = response.error.userInfo[@"NSLocalizedDescriptionKey"];
                [hud hideAnimated:YES afterDelay:2];
            }

            if (completion) {
                completion(response);
            }
        }];
        if (request.task) {
            [self.requestsHolder appendObject:request];
        }
    } else {
        NSLog(@"请配置请求path,参数等");
    }
}
- (void)loginRepeat {

}//重新登录


- (NSArray<CSRequest *> *)requests {
    return self.requestsHolder;
}
- (void)dealloc {
    [self cancelAllRequests];
}

@end
