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
@property(nonatomic, strong)NSURLSessionTask *task;
@property(nonatomic, strong)NSURLRequest *request;
@property(nonatomic, strong)NSURLResponse *response;
@property(nonatomic, strong)NSDictionary *jsonDic;
@property(nonatomic, strong)NSError *error;

@end

@implementation CSResponse

+ (CSResponse *)responseWithTask:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error{
    CSResponse *response = [[CSResponse alloc] init];
    response.task = task;
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

- (NSURLRequest *)request {
    return self.task.currentRequest;
}

- (NSURLResponse *)response {
    return self.task.response;
}


- (BOOL)success {
    return !self.error && self.code == CsCode_Success && self.jsonDic;
}


- (NSString *)description {
    return self.debugDescription;
}

- (NSString *)debugDescription {
    if (self.error) {
        return [NSString stringWithFormat:@"request url:%@\nrequest parameters:%@\nresponse :%@\nhttp error :%@\n",
                self.request.URL.absoluteString,
                self.request.HTTPBody.mj_JSONString,
                self.response,
                self.error];
    } else {
        if (self.success) {
            return [NSString stringWithFormat:@"request url:%@\nrequest parameters:%@\ncs message :%@\ncs jsonDic :%@\n",
                    self.request.URL.absoluteString,
                    self.request.HTTPBody.mj_JSONString,
                    self.message,
                    self.jsonDic
                    ];
            
        } else {
            return [NSString stringWithFormat:@"request url:%@\nrequest parameters:%@\ncs error :%ld\ncs message :%@\n",
                    self.request.URL.absoluteString,
                    self.request.HTTPBody.mj_JSONString,
                    self.code,
                    self.message
                    ];
        }
    }
}

@end
