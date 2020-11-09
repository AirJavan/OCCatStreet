//
//
//  MBProgressHUD+MHExtension.m
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 CoderMikeHe. All rights reserved.
//

#import "MBProgressHUD+MHExtension.h"

@implementation MBProgressHUD (MHExtension)

#pragma mark - Added To  window
/// 提示信息
+ (MBProgressHUD *)mh_showTips:(NSString *)tipStr{
    return [self mh_showTips:tipStr addedToView:nil];
}

/// 提示成功
+ (MBProgressHUD *)mh_showSuccessTips:(NSString *)success {
    return [self mh_showSuccessTips:success addedToView:nil];
}

/// 提示错误
+ (MBProgressHUD *)mh_showErrorTips:(NSError *)error{
    return [self mh_showErrorTips:error addedToView:nil];
}

/// 进度view
+ (MBProgressHUD *)mh_showProgressHUD:(NSString *)titleStr
{
    return [self mh_showProgressHUD:titleStr addedToView:nil];
}

/// hide hud
+ (void)mh_hideHUD
{
    [self mh_hideHUDForView:nil];
}


#pragma mark - Added To Special View
/// 提示信息
+ (MBProgressHUD *)mh_showTips:(NSString *)tipStr addedToView:(UIView *)view
{
    return [self _showHUDWithTips:tipStr isAutomaticHide:YES type:HUDTypeTextOnly addedToView:view];
}

/// 提示成功
+ (MBProgressHUD *)mh_showSuccessTips:(NSString *)tipStr addedToView:(UIView *)view {
    return [self _showHUDWithTips:tipStr isAutomaticHide:YES type:HUDTypeSuccess addedToView:view];
}

/// 提示错误
+ (MBProgressHUD *)mh_showErrorTips:(NSError *)error addedToView:(UIView *)view
{
    return [self _showHUDWithTips:[self mh_tipsFromError:error] isAutomaticHide:YES type:HUDTypeError addedToView:view];
}


/// 进度view
+ (MBProgressHUD *)mh_showProgressHUD:(NSString *)titleStr addedToView:(UIView *)view{
    return [self _showHUDWithTips:titleStr isAutomaticHide:NO  type:HUDTypeProgress addedToView:view];
}

// 隐藏HUD
+ (void)mh_hideHUDForView:(UIView *)view
{
    [self hideHUDForView:[self _willShowingToViewWithSourceView:view] animated:YES];
}

#pragma mark - 辅助方法
/// 获取将要显示的view
+ (UIView *)_willShowingToViewWithSourceView:(UIView *)sourceView
{
    if (sourceView) return sourceView;
    
    sourceView =  [[UIApplication sharedApplication].delegate window];
    if (!sourceView) sourceView = [[[UIApplication sharedApplication] windows] lastObject];
    
    return sourceView;
}

+ (instancetype )_showHUDWithTips:(NSString *)tipStr isAutomaticHide:(BOOL)isAutomaticHide type:(HUDType)type addedToView:(UIView *)view
{
    view = [self _willShowingToViewWithSourceView:view];
    
    /// 也可以show之前 hid掉之前的
    [self mh_hideHUDForView:view];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    if (type == HUDTypeTextOnly) {
        HUD.mode = MBProgressHUDModeText;
    }else if (type == HUDTypeSuccess) {
        HUD.mode = MBProgressHUDModeCustomView;
        UIImage *image = [[@"\U0000e698" imageWithColor:@"#000000"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        HUD.customView = [[UIImageView alloc] initWithImage:image];
        
    }else if (type == HUDTypeError) {
        HUD.mode = MBProgressHUDModeCustomView;
        UIImage *image = [[@"\U0000e6a0" imageWithColor:@"#000000"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        HUD.customView = [[UIImageView alloc] initWithImage:image];
        
    }else if (type == HUDTypeProgress) {
        HUD.mode = MBProgressHUDModeIndeterminate;
    }
    
    
    
    
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.offset = CGPointMake(0, -70);
    HUD.label.font = isAutomaticHide?PFFONT_Thin(17.f):PFFONT_Thin(14.f);
    HUD.label.textColor = [UIColor whiteColor];
    HUD.contentColor = [UIColor whiteColor];
    HUD.label.text = tipStr;
    HUD.bezelView.layer.cornerRadius = 8.0f;
    HUD.bezelView.layer.masksToBounds = YES;
    HUD.bezelView.color = RGBA(0, 0, 0, .6f);
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.minSize =isAutomaticHide?CGSizeMake([UIScreen mainScreen].bounds.size.width-250.f, 45):CGSizeMake(120, 120);
    HUD.margin = 18.2f;
    HUD.removeFromSuperViewOnHide = YES;
    if (isAutomaticHide) [HUD hideAnimated:YES afterDelay:1.0f];
    return HUD;
}


#pragma mark - 辅助属性
+ (NSString *)mh_tipsFromError:(NSError *)error{
    return error.userInfo[NSLocalizedDescriptionKey];
}
@end
