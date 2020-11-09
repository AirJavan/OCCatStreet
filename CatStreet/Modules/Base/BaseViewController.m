//
//  BaseViewController.m
//  CatStreet
//
//  Created by Fluva on 2020/11/3.
//

#import "BaseViewController.h"

#import "BaseTableViewCell.h"

@interface BaseViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, assign) HUDPosition hudPosition;

@property (nonatomic, assign) MBProgressHUDMode hudType;

@property (nonatomic, strong) UIView *hudView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BG;
    
    self.hudPosition = HUDPosition_center; //默认在中间
    
    self.hudType = MBProgressHUDModeText; //默认纯文字
    
    self.navigationController.navigationBar.barTintColor =COLOR_BG;
    
    [self.navigationController.navigationBar setClipsToBounds:YES];
        
}


- (void)setupRightItemWithTitle:(NSString *)title {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(righItemAction:)];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"PingFangSC-Regular" size:17],NSFontAttributeName, nil] forState:UIControlStateNormal];
    item.tintColor =  COLOR_Purple;
    [self setupRightItem:item];
}

- (void)setupRightItemWithImg:(UIImage *)img {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(righItemAction:)];
    [self setupRightItem:item];
}


- (void)setupRightItem:(UIBarButtonItem *)item {
    self.navigationItem.rightBarButtonItem = item;
}

- (void)righItemAction:(UIBarButtonItem *)item {
    
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[@"\U0000e699" imageWithColor:@"#000000"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


-(void)setupTableView{
    [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell"];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"baseCell"];
    }
    return cell;
}


-(BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}


//#pragma mark MBprogressHUD
//
//// 文字
//- (void)showInfo:(NSString *)info {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//
//    hud.mode = self.hudType;
//    hud.label.text = info;
//
//    hud.offset = CGPointMake(0.f, self.hudPosition);
//
//    if (self.hudType == MBProgressHUDModeText) {
//        [hud hideAnimated:YES afterDelay:3.f];
//    }else if(self.hudType == MBProgressHUDModeCustomView) {
//        hud.customView = self.hudView;
//        hud.square = YES;
//    }
//    
//}
//
//
//- (void)showInfo:(NSString *)info position:(HUDPosition)position {
//    self.hudPosition = position;
//    [self showInfo:info];
//}
//
//
//- (void)showSuccess:(NSString *)info {
//    self.hudType = MBProgressHUDModeCustomView;
//    UIImage *image = [[@"\U0000e698" imageWithColor:@"#000000"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    self.hudView = [[UIImageView alloc] initWithImage:image];
//    [self showInfo:info];
//    [self hideAfterDelay:3.f];
//}
//
//- (void)showError:(NSString *)info {
//    self.hudType = MBProgressHUDModeCustomView;
//    UIImage *image = [[@"\U0000e6a0" imageWithColor:@"#000000"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    self.hudView = [[UIImageView alloc] initWithImage:image];
//    [self showInfo:info];
//    [self hideAfterDelay:3.f];
//}
//
//- (void)showLoading:(NSString *)info {
//    
//}
//
//- (void)hideAfterDelay:(NSTimeInterval)dely {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[MBProgressHUD HUDForView:self.navigationController.view] hideAnimated:YES afterDelay:dely];
//    });
//}
//
//
//- (void)hideHud {//供子类调用
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//    });
//}


- (void)dealloc {
    if (self.viewModel) {
        [self.viewModel.requestBunch cancelAllRequests];
    }
}
@end
