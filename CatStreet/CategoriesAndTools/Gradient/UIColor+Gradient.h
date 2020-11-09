//
//  UIColor+Gradient.h
//  CatStreet
//
//  Created by Fluva on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZQGradientChangeDirection) {
    
    ZQGradientChangeDirectionLevel,             //水平方向渐变
    
    ZQGradientChangeDirectionVertical,          //垂直方向渐变
    
    ZQGradientChangeDirectionUpwardDiagonalLine,//主对角线方向渐变
    
    ZQGradientChangeDirectionDownDiagonalLine,  //副对角线方向渐变
    
};

@interface UIColor (Gradient)

+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size

                  direction:(ZQGradientChangeDirection)direction

                  startColor:(UIColor*)startcolor

                   endColor:(UIColor*)endColor;

@end

NS_ASSUME_NONNULL_END
