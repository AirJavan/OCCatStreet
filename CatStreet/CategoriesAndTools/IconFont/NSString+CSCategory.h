//
//  NSString+CSCategory.h
//  CatStreet
//
//  Created by Fluva on 2020/7/28.
//  Copyright © 2020 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CSCategory)

- (UIColor *)color;
- (UIImage *)image;
- (UIImage *)imageWithColor:(NSString *)color; //

@end

NS_ASSUME_NONNULL_END
