//
//  MacrosCode.h
//  CatStreet
//
//  Created by Fluva on 2020/11/7.
//

#ifndef MacrosCode_h
#define MacrosCode_h

#define HEX_COLOR(a) [UIColor colorWithHexString:a]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

///是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
///字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))


#define AutoW(W) [UIScreen mainScreen].bounds.size.width*((W)/414.0)
#define AutoH(H) [UIScreen mainScreen].bounds.size.height*((H)/896.0)

#


#endif /* MacrosCode_h */
