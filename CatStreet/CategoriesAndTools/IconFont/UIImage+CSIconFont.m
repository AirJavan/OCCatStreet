//
//  UIImage+CSIconFont.m
//  CatStreet
//
//  Created by Fluva on 2020/11/3.
//

#import "UIImage+CSIconFont.h"
#import "CSIconFont.h"
#import <SVGKit.h>
#import <CoreText/CoreText.h>

@implementation UIImage (CSIconFont)


+ (UIImage *)iconWithName:(NSString *)name size:(NSInteger)size color:(UIColor *)color,... {
    NSMutableArray *colors = [[NSMutableArray alloc] initWithObjects:color, nil];
    va_list args;
    UIColor *col;
    va_start(args, color);
    while ((col = va_arg(args, UIColor *))) {
        if (col) {
            [colors addObject:col];
        }
    }
    va_end(args);
    return [UIImage iconWithName:name size:size colors:colors];
}

+ (UIImage *)iconWithName:(NSString *)name size:(NSInteger)size colors:(NSArray <UIColor *>*)colors {
    UIImage *image = [UIImage imageNamed:name];
    if (image) return image;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat realSize = size * scale;
    CGRect rect = CGRectMake(0, 0, realSize, realSize);
    CGRect textRect = rect;
    UIFont *font = [CSIconFont fontWithSize:realSize];
    UIGraphicsBeginImageContext(CGSizeMake(realSize, realSize));
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (colors.count == 1) {
        [name drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: colors.firstObject}];
    } else if (colors.count > 1) {
        [name drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: colors.firstObject}];
        CGContextTranslateCTM(context, 0.0f, realSize - (realSize - realSize)*0.5);
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGImageRef alphaMask = NULL;
        alphaMask = CGBitmapContextCreateImage(context);
        CGContextClearRect(context, rect);// 清除之前画的文字
        CGContextClipToMask(context, rect, alphaMask);
        NSMutableArray *cgColors = [[NSMutableArray alloc] init];
        [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [cgColors addObject:(id)obj.CGColor];
        }];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)cgColors, NULL);
        CGPoint startPoint = CGPointMake(textRect.origin.x, textRect.origin.y);
        CGPoint endPoint = CGPointMake(textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height);
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
        CFRelease(alphaMask);
        
    } else {
        [name drawAtPoint:CGPointZero withAttributes:nil];
    }
    image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    return image;
}
UIImage * CSIconMake(NSString *name, NSInteger size, UIColor *color, ...) {
    NSMutableArray *colors = [[NSMutableArray alloc] initWithObjects:color, nil];
    va_list args;
    UIColor *col;
    va_start(args, color);
    while ((col = va_arg(args, UIColor *))) {
        if (col) {
            [colors addObject:col];
        }
    }
    va_end(args);
    return [UIImage iconWithName:name size:size colors:colors];
}

+ (UIImage *)svgNamed:(NSString *)svgNamed cgColor:(CGColorRef)cgColor{
    SVGKImage * svgImage = [SVGKImage imageNamed:svgNamed];
    
    CALayer * layer = [svgImage layerWithIdentifier:@"skinLayer"];
    if( [layer isKindOfClass:[CAShapeLayer class]]){
        CAShapeLayer* shapeLayer = (CAShapeLayer*)layer;
        shapeLayer.fillColor = cgColor;
    }
    
    SVGKLayeredImageView * icon = [[SVGKLayeredImageView alloc] initWithSVGKImage:svgImage];
    return icon.image.UIImage;
}

@end
