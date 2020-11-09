//
//  MainTabBarController.m
//  CatStreet
//
//  Created by Fluva on 2020/11/3.
//

#import "MainTabBarController.h"
#import <RTRootNavigationController.h>

#import "SameCityViewController.h"
#import "RadioViewController.h"
#import "StreetViewController.h"
#import "NewsViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"


@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
//    [self customizeInterface];
}

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                               tabBarItemsAttributes:self.tabBarItemsAttributesForController];
    
    //   [self customizeTabBarAppearance:tabBarController];
    self.navigationController.navigationBar.hidden = YES;
    return (self = (MainTabBarController *)tabBarController);
}

- (NSArray *)viewControllers {
    SameCityViewController *firstViewController = [[SameCityViewController alloc] init];
    RTRootNavigationController *firstNavigationController = [[RTRootNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    [firstViewController cyl_setHideNavigationBarSeparator:YES];
    
    
    RadioViewController *secondViewController = [[RadioViewController alloc] init];
    RTRootNavigationController *secondNavigationController = [[RTRootNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    [secondViewController cyl_setHideNavigationBarSeparator:YES];
    
    
    StreetViewController *thirdViewController = [[StreetViewController alloc] init];
    RTRootNavigationController *thirdNavigationController = [[RTRootNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    [thirdViewController cyl_setHideNavigationBarSeparator:YES];
    
    
    
    NewsViewController *fourthViewController = [[NewsViewController alloc] init];
    RTRootNavigationController *fourthNavigationController = [[RTRootNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    [fourthViewController cyl_setHideNavigationBarSeparator:YES];
    
    
    
    MineViewController *fifthViewController = [[MineViewController alloc] init];
    RTRootNavigationController *fifthNavigationController = [[RTRootNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    [fifthViewController cyl_setHideNavigationBarSeparator:YES];
    
    
    NSArray *viewControllers = @[
        firstNavigationController,
        secondNavigationController,
        thirdNavigationController,
        fourthNavigationController,
        fifthNavigationController
    ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    
    
    NSArray *imgNameAry = @[@"\U0000e6a8", @"\U0000e6a2", @"\U0000e6a7", @"\U0000e6a5", @"\U0000e6ab"];
    NSArray *SelectedImgNameAry = @[@"\U0000e6a6", @"\U0000e6a4", @"\U0000e6a3", @"\U0000e6aa", @"\U0000e6a9"];
    
    NSMutableArray *imgAry= [[NSMutableArray alloc]init];
    NSMutableArray *selectedImgAry= [[NSMutableArray alloc]init];
    
    for (int i=0 ; i<imgNameAry.count; i++) {
        UIImage *image = [CSIconMake(imgNameAry[i], 24, HEX_COLOR(@"#6E6A94"),nil) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        
        UIImage *selectedImage = [CSIconMake(SelectedImgNameAry[i], 24, HEX_COLOR(@"#AF52DE"),HEX_COLOR(@"4F6CFF"),nil) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [imgAry addObject:image];
        
        [selectedImgAry addObject:selectedImage];
    }
    
    
    
    
    
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle:@"同城",
        CYLTabBarItemImage:imgAry[0],
        CYLTabBarItemSelectedImage:selectedImgAry[0]};
    
    
    NSDictionary *secondTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"电台",
        CYLTabBarItemImage : imgAry[1],
        CYLTabBarItemSelectedImage : selectedImgAry[1]};
    
    NSDictionary *thirdTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"街区",
        CYLTabBarItemImage : imgAry[2],
        CYLTabBarItemSelectedImage : selectedImgAry[2]};
    
    
    NSDictionary *fourthTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"消息",
        CYLTabBarItemImage : imgAry[3],
        CYLTabBarItemSelectedImage : selectedImgAry[3]};
    
    
    NSDictionary *fifthTabBarItemsAttributes =@{
        CYLTabBarItemTitle : @"我的",
        CYLTabBarItemImage : imgAry[4],
        CYLTabBarItemSelectedImage : selectedImgAry[4]};
    
       NSArray *tabBarItemsAttributes = @[
                                          firstTabBarItemsAttributes,
                                          secondTabBarItemsAttributes,
                                          thirdTabBarItemsAttributes,
                                          fourthTabBarItemsAttributes,
                                          fifthTabBarItemsAttributes
                                          ];
    return tabBarItemsAttributes;
}

@end


