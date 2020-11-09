//
//  MacrosDevice.h
//  CatStreet
//
//  Created by Fluva on 2020/11/4.
//

#ifndef MacrosDevice_h
#define MacrosDevice_h


#define COLOR_BG             HEX_COLOR(@"#FAFAFA")  //背景色
#define COLOR_Line           HEX_COLOR(@"#DBDBE0")  //线条颜色
#define COLOR_Black          HEX_COLOR(@"#16142D")
#define COLOR_Purple         HEX_COLOR(@"#6E6A94")
#define COLOR_Blue           HEX_COLOR(@"#4F6CFF")
#define COLOR_Red            HEX_COLOR(@"#F74868")
#define COLOR_LightGray      HEX_COLOR(@"#9C9CA4")
#define COLOR_Gray           HEX_COLOR(@"#636366")
#define COLOR_White          HEX_COLOR(@"#F2F2F6")



#define PFFONT_Medium(s)      [UIFont fontWithName:@"PingFangSC-Medium" size:s]           /*苹方中黑体*/
#define PFFONT_Semibold(s)    [UIFont fontWithName:@"PingFangSC-Semibold" size:s]         /*苹方中粗体*/
#define PFFONT_Light(s)       [UIFont fontWithName:@"PingFangSC-Light" size:s]            /*苹方细体 */
#define PFFONT_Ultralight(s)  [UIFont fontWithName:@"PingFangSC-Ultralight" size:s]       /*苹方极细体*/
#define PFFONT_Regular(s)     [UIFont fontWithName:@"PingFangSC-Regular" size:s]          /*苹方常规 */
#define PFFONT_Thin(s)        [UIFont fontWithName:@"PingFangSC-Thin" size:s]             /*苹方纤细体*/

#define SYS_FONT(s)  [UIFont systemFontOfSize:s]

/// 类型相关
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

/// 屏幕尺寸相关
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

/// 手机类型相关
#define IS_IPHONE_4_OR_LESS  (IS_IPHONE && SCREEN_MAX_LENGTH  < 568.0)
#define IS_IPHONE_5          (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6          (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P         (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X          (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)


/// 导航条高度
#define TOP_BAR_HEIGHT (IS_IPHONE_X?88.0f:64.0f)
/// tabBar高度
#define TAB_BAR_HEIGHT (IS_IPHONE_X?83.0f:49.0f)
/// 工具条高度 (常见的高度)
#define TOOL_BAR_HEIGHT_44  44.0f
#define TOOL_BAR_HEIGHT_49  49.0f
/// 状态栏高度
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height




///------
/// iOS Version
///------
#define MHIOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

#define iOS7_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define iOS8_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define iOS9_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)
#define iOS10_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)

#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#endif /* MacrosDevice_h */
