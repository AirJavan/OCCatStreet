//
//  CSError.m
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import "CSResponse.h"

@interface CSResponse()

@property(nonatomic, assign)BOOL success;
@property(nonatomic, assign)NSInteger code;
@property(nonatomic, copy)NSString *message;
@property(nonatomic, strong)CSRequest *request;
@property(nonatomic, strong)NSDictionary *jsonDic;
@property(nonatomic, strong)NSError *error;

@end

@implementation CSResponse

+ (CSResponse *)responseWithRequest:(CSRequest *)request responseObject:(id)responseObject error:(NSError *)error{
    CSResponse *response = [[CSResponse alloc] init];
    response.request = request;
    if (error) {
        response.error = error;
    } else {
        NSInteger cscode = [[responseObject objectForKey:@"result"] integerValue];
        response.code = cscode;
        response.message = [responseObject objectForKey:@"msg"];
        if (cscode == CsCode_Success && responseObject) {
            response.jsonDic = [responseObject objectForKey:@"data"];
        }
    }
    return response;
}

- (BOOL)success {
    return !self.error && self.code == CsCode_Success && self.jsonDic;
}


- (NSString *)description {
    return self.debugDescription;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"request :%@\nresponse :%@\nhttp error :%@\n",
            self.request,
            self.jsonDic,
            self.error];
}

@end
