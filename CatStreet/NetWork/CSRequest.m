//
//  CSRequest.m
//  CatStreet
//
//  Created by Fluva on 2020/7/21.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import "CSRequest.h"

@interface CSRequest()
@property (nonatomic, strong)NSURLSessionTask *task;
@end

@implementation CSRequest

+ (instancetype)request {
    CSRequest *request = [[CSRequest alloc] init];
    return request;
}

- (NSString *)urlStr {
    if (self.baseServer) {
        if (!self.path) {
            NSLog(@"request path does not exsits, are you sure?");
            return self.baseServer;
        }
        return [self.baseServer stringByAppendingPathComponent:[self.path stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" /"]]];
    }
    NSLog(@"please config base server in info.plist");
    return nil;
}

/// config base server in info.plist eg:
/// <key>ServerConfig</key>
///<dict>
///    <key>Formal</key>
///    <string>http://xxx</string>
///    <key>Test</key>
///    <string>http://xxx</string>
///</dict>
///
- (NSString *)baseServer {
    NSString *server = nil;
    NSDictionary *infoDicNew = [NSBundle mainBundle].infoDictionary;
#if (!DEBUG && !TEST)
    server = [infoDicNew valueForKeyPath:@"ServerConfig.Formal"];
#else
    server = [infoDicNew valueForKeyPath:@"ServerConfig.Test"];
#endif
    return _baseServer ?: server;
}

-(NSString *)methodStr {
    switch (self.method) {
        case CSRequestMethod_GET: return @"GET";
        case CSRequestMethod_POST: return @"POST";
        case CSRequestMethod_HEADER: return @"HEADER";
        case CSRequestMethod_PUT: return @"PUT";
        case CSRequestMethod_DELETE: return @"DELETE";
        default: return @"GET";
    }
}

- (void)didSend:(NSURLSessionTask *)task {
    self.task = task;
}
@end
