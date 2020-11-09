//
//  UIImage+CSIconFont.h
//  CatStreet
//
//  Created by Fluva on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CSIconFont)

+ (UIImage *)iconWithName:(NSString *)name size:(NSInteger)size color:(UIColor *)color,...;
+ (UIImage *)iconWithName:(NSString *)name size:(NSInteger)size colors:(NSArray <UIColor *>*)colors;

+ (UIImage *)svgNamed:(NSString *)svgNamed cgColor:(CGColorRef)cgColor;

UIImage *CSIconMake(NSString *name, NSInteger size, UIColor *color, ...);

@end


NS_ASSUME_NONNULL_END
