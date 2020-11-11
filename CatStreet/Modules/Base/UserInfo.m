//
//  UserInfo.m
//  CatStreet
//
//  Created by Fluva on 2020/11/4.
//

#import "UserInfo.h"
#import "WZLSerializeKit.h"


@implementation UserInfo


WZLSERIALIZE_CODER_DECODER();

WZLSERIALIZE_COPY_WITH_ZONE();

WZLSERIALIZE_DESCRIPTION();

static UserInfo *g_userInfo = nil;

+ (UserInfo *)shareInstance
{
    if(g_userInfo == nil)
    {
        g_userInfo = [UserInfo getLastUser];
        if(g_userInfo == nil)
        {
            g_userInfo = [[UserInfo alloc] init];
        }
    }
    return g_userInfo;
}
    
+ (UserInfo *)getLastUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"lastUserInfo"];
    if(data)
    {
        return [NSKeyedUnarchiver unarchivedObjectOfClass:[UserInfo class] fromData:data error:nil];
    }
    return nil;
}
    
@end
