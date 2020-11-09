//
//  NSString+CSCategory.m
//  CatStreet
//
//  Created by Fluva on 2020/7/28.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import "NSString+CSCategory.h"

@implementation NSString (CSCategory)

- (UIColor *)color {
    return [UIColor colorWithHexString:self];
}

- (UIImage *)imageWithColor:(NSString *)color {
    return CSIconMake(self, 24, color.color, nil);
}


- (UIImage *)image {
    return CSIconMake(self, 24, @"#AF52DE".color, nil);
}

@end
