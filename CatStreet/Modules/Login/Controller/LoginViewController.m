//  LoginViewController.m
//  CatStreet
//
//  Created by Fluva on 2020/11/3.
//

#import "LoginViewController.h"
#import "PhoneLoginViewController.h"
#import <RTRootNavigationController.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationController.navigationBarHidden = YES;
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.view.frame.size direction:ZQGradientChangeDirectionVertical startColor:RGBA(180, 182, 201, 1) endColor:RGBA(180, 182, 201, 0)];
    [self.view addSubview:bgView];
    
    [self setupUI];
    
}

- (void)setupUI {
    
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneBtn setTitle:@"  手机登录" forState:UIControlStateNormal];
    [phoneBtn setAdjustsImageWhenHighlighted:NO];
    [phoneBtn setImage:[@"\U0000e695" imageWithColor:@"#FFFFFF"] forState:UIControlStateNormal];
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    phoneBtn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(300, 48) direction:ZQGradientChangeDirectionLevel startColor:HEX_COLOR(@"#AF52DE") endColor:HEX_COLOR(@"#4F6CFF")];
    [phoneBtn addTarget:self action:@selector(signInWithPhone:) forControlEvents:UIControlEventTouchUpInside];
    
    phoneBtn.frame = CGRectMake(SCREEN_WIDTH/2-300/2, SCREEN_HEIGHT - 380, 300, 48);
    phoneBtn.layer.cornerRadius = 24;
    phoneBtn.layer.masksToBounds = YES;
//    phoneBtn.isEnabled
    [self.view addSubview:phoneBtn];
    
    
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxBtn setTitle:@"  微信登录" forState:UIControlStateNormal];
    [wxBtn setAdjustsImageWhenHighlighted:NO];
    [wxBtn setImage:[@"\U0000e696" imageWithColor:@"#FFFFFF"] forState:UIControlStateNormal];
    wxBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    wxBtn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(300, 48) direction:ZQGradientChangeDirectionLevel startColor:HEX_COLOR(@"#42CD75") endColor:HEX_COLOR(@"#58E88E")];
    [wxBtn addTarget:self action:@selector(signInWithWx:) forControlEvents:UIControlEventTouchUpInside];
    
    wxBtn.frame = CGRectMake(SCREEN_WIDTH/2-300/2, CGRectGetMaxY(phoneBtn.frame)+15, 300, 48);
    
    wxBtn.layer.cornerRadius = 24;
    wxBtn.layer.masksToBounds = YES;
    
    [self.view addSubview:wxBtn];
    
    
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setTitle:@"  QQ登录" forState:UIControlStateNormal];
    [qqBtn setAdjustsImageWhenHighlighted:NO];
    [qqBtn setImage:[@"\U0000e697" imageWithColor:@"#FFFFFF"] forState:UIControlStateNormal];
    qqBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    qqBtn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(300, 48) direction:ZQGradientChangeDirectionLevel startColor:HEX_COLOR(@"#3598FF") endColor:HEX_COLOR(@"#5AABFF")];
    [qqBtn addTarget:self action:@selector(signInWithQQ:) forControlEvents:UIControlEventTouchUpInside];
    qqBtn.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT - 300);
    qqBtn.frame = CGRectMake(SCREEN_WIDTH/2-300/2, CGRectGetMaxY(wxBtn.frame)+15, 300, 48);
    qqBtn.bounds = CGRectMake(0, 0, 300, 48);
    qqBtn.layer.cornerRadius = 24;
    qqBtn.layer.masksToBounds = YES;
    
    [self.view addSubview:qqBtn];

    UIButton *appleBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    appleBtn.backgroundColor = [UIColor whiteColor];
    appleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [appleBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [appleBtn setAdjustsImageWhenHighlighted:NO];
    [appleBtn addTarget:self action:@selector(signInWithApple:) forControlEvents:UIControlEventTouchUpInside];
    appleBtn.frame = CGRectMake(SCREEN_WIDTH/2-300/2, CGRectGetMaxY(qqBtn.frame)+15, 300, 48);
    appleBtn.layer.cornerRadius = 24;
    appleBtn.layer.masksToBounds = YES;
    appleBtn.layer.borderWidth = 1;
    appleBtn.layer.borderColor = UIColor.blackColor.CGColor;
    [appleBtn setTitle:@"  通过Apple登录" forState:UIControlStateNormal];
    [appleBtn setImage:[@"\U0000e6f9" imageWithColor:@"#000000"] forState:UIControlStateNormal];
    [self.view addSubview:appleBtn];
    
    
    YYLabel *tipLab = [[YYLabel alloc]init];
    tipLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self.view addSubview:tipLab];
    
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(qqBtn).offset(15);
        make.bottom .equalTo(self.view.mas_bottom).offset(-40);
    }];
    
    
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"我已经阅读并同意《用户协议》和 《隐私政策》"];
    text.color = HEX_COLOR(@"#9C9CA4");
    [text setTextHighlightRange:NSMakeRange(8, 6) color:[UIColor colorWithHexString:@"#6E6A94"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
//        BaseWebViewController *v = [BaseWebViewController new];
//        v.titleString = @"用户使用协议";
//        v.urlStr = @"http://www.mmjiequ.com/active/publishStandard.html";
//        v.type = WEB_LOAD_TYPE_URL;
//        v.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:v animated:YES];
    }];
    

    
    [text setTextHighlightRange:NSMakeRange(16, 6) color:[UIColor colorWithHexString:@"#6E6A94"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
//        BaseWebViewController *v = [BaseWebViewController new];
//        v.titleString = @"用户使用协议";
//        v.urlStr = @"http://www.mmjiequ.com/active/publishStandard.html";
//        v.type = WEB_LOAD_TYPE_URL;
//        v.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:v animated:YES];
    }];
    
    tipLab.attributedText = text;
    
    UIButton * selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectedBtn setImage:CSIconMake(@"\U0000e6f4", 20, @"#6E6A94".color,nil) forState:UIControlStateNormal];
    [selectedBtn addTarget:self action:@selector(agreeDelegateClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectedBtn];
    
    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tipLab);
        make.right.equalTo(tipLab.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}



- (void)signInWithPhone:(UIButton *)sender {
        
    PhoneLoginViewController *pVc = [[PhoneLoginViewController alloc]init];
    
    [self.rt_navigationController pushViewController:pVc animated:YES complete:nil];
    
}

- (void)signInWithWx:(UIButton *)sender {
    
    
}

- (void)signInWithQQ:(UIButton *)sender {
    
    
}


- (void)agreeDelegateClick:(UIButton *)sender {
    
}


- (void)signInWithApple:(UIButton *)sender {
    
}

@end
