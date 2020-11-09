//
//  BaseViewController.h
//  CatStreet
//
//  Created by Fluva on 2020/11/3.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
#import "CSBaseViewModel.h"
#import <RTRootNavigationController.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, strong) BaseTableView *tableView;

@property(nonatomic,strong) NSArray * dataSource;

@property (nonatomic, strong) CSBaseViewModel *viewModel;

-(void)setupTableView;

// 创建rightItem;
- (void)setupRightItemWithTitle:(NSString *)title;

- (void)setupRightItemWithImg:(UIImage *)img;

- (void)setupRightItem:(UIBarButtonItem *)item;

- (void)righItemAction:(UIBarButtonItem *)item;
@end

NS_ASSUME_NONNULL_END
