//
//  PhoneLoginViewController.m
//  CatStreet
//
//  Created by Fluva on 2020/11/4.
//

#import "PhoneLoginViewController.h"
#import "UserInfo.h"
#import "UIButton+Indicator.h"
#import "LogInViewModel.h"

@interface PhoneLoginViewController ()
<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;

@property (nonatomic, strong) UITextField *phoneNumTfd;

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UITextField *passWordTfd;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIButton *sendCodeBtn;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator ;

@property (nonatomic, assign) LoginType loginType;

@property (nonatomic, strong) LogInViewModel *vm;

@property (nonatomic, assign) BOOL validLoginSignal;  ///登录是否能点击

@property (nonatomic, assign) BOOL validSendCodeSignal; ///是否能够发送验证码

@property (nonatomic, assign) BOOL isSecure; //密码是否可见

@property (nonatomic, assign) NSInteger curCount;

@property (nonatomic, strong) NSTimer *runTimer;

@end


@implementation PhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.vm = [LogInViewModel viewModel];
    
    self.curCount = 60;
    
    self.validSendCodeSignal = YES;
    
    [self setupRightItemWithTitle:@"验证码登录"];
    
    [self setupUI];
}

- (void)righItemAction:(UIBarButtonItem *)item {
    
    self.loginType = self.loginType == LoginType_phonePassword?LoginType_phoneCode:LoginType_phonePassword;
    [self refreshUI];
    [self refreshBtnStatus];
    [self refreshSendCodeStatus];
}


- (void)setupUI {
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 50+TOP_BAR_HEIGHT, 200, 40)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.text = @"密码登录";
    
    self.titleLab.font =  PFFONT_Medium(28);
    [self.view addSubview:self.titleLab];
    

    
    
    
    self.subTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-150, 50+TOP_BAR_HEIGHT+40+10, 300, 20)];
    self.subTitleLab.text = @"未注册手机号验证后将自动登录";
    self.subTitleLab.font = PFFONT_Regular(12);
    self.subTitleLab.textAlignment = NSTextAlignmentCenter;
    self.subTitleLab.textColor =  HEX_COLOR(@"#9C9CA4");
    
    [self.view addSubview:self.subTitleLab];

    
    UILabel *areaNumLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 50+TOP_BAR_HEIGHT+40+10+20+65, 35, 30)];
    areaNumLab.font = PFFONT_Regular(17);
    areaNumLab.text = @"+86";
    
    [self.view addSubview:areaNumLab];
    
    
    
    self.phoneNumTfd = [[UITextField alloc]initWithFrame:CGRectMake(40+35+15,  50+TOP_BAR_HEIGHT+40+10+20+65, SCREEN_WIDTH-(40+35+15)-50, 30)];
    self.phoneNumTfd.placeholder = @"请输入手机号";
    self.phoneNumTfd.delegate = self;
    self.phoneNumTfd.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumTfd.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTfd.font = PFFONT_Regular(15);
    [self.phoneNumTfd addTarget:self action:@selector(inputChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:self.phoneNumTfd];
    
    
    
    self.topLine = [[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.phoneNumTfd.frame)+10, SCREEN_WIDTH-80, 0.5)];
    
    self.topLine.backgroundColor = COLOR_Line;
    
    [self.view addSubview:self.topLine];
    
    
    
    self.sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.sendCodeBtn.userInteractionEnabled = NO;
    self.sendCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.sendCodeBtn.frame = CGRectMake(SCREEN_WIDTH-40-85, CGRectGetMaxY(self.topLine.frame)+25, 80, 30);
    [self.sendCodeBtn setImage:CSIconMake(@"\U0000e69f", 20, @"#636366".color,nil) forState:UIControlStateNormal];
    [self.sendCodeBtn setTitleColor:HEX_COLOR(@"#4F6CFF") forState:UIControlStateNormal];
    [self.sendCodeBtn setAdjustsImageWhenHighlighted:NO];
    self.sendCodeBtn.titleLabel.font = PFFONT_Regular(15);
    [self.sendCodeBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendCodeBtn];




    self.passWordTfd = [[UITextField alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.topLine.frame)+25,  SCREEN_WIDTH-40-5-40-80, 30)];
    self.passWordTfd.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passWordTfd.keyboardType = UIKeyboardTypeDefault;
    [self.passWordTfd setSecureTextEntry:YES];
    self.passWordTfd.delegate = self;
    self.passWordTfd.placeholder = @"请输入验证码";
    self.passWordTfd.font = PFFONT_Thin(15);

    [self.view addSubview:self.passWordTfd];



    self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.passWordTfd.frame)+10, SCREEN_WIDTH-80, 0.5)];

    self.bottomLine.backgroundColor = COLOR_Line;

    [self.view addSubview:self.bottomLine];


    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginBtn.frame = CGRectMake(40, CGRectGetMaxY(self.bottomLine.frame)+40, SCREEN_WIDTH-80, 48);
    self.loginBtn.layer.cornerRadius = 24;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn setAdjustsImageWhenDisabled:NO];
    
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginBtn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(SCREEN_WIDTH-80, 40) direction:ZQGradientChangeDirectionLevel startColor:HEX_COLOR(@"#DFD6E9") endColor:HEX_COLOR(@"#D6D9EC")];
    
    [self.loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    [self.loginBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [self.view addSubview:self.loginBtn];

    
    [self.passWordTfd addTarget:self action:@selector(inputChange:) forControlEvents:UIControlEventEditingChanged];

}



- (void)inputChange:(UITextField *)tfd {
    [self refreshBtnStatus];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.phoneNumTfd) {
        self.topLine.backgroundColor = HEX_COLOR(@"#4F6CFF");
    }else {
        self.bottomLine.backgroundColor = HEX_COLOR(@"#4F6CFF");
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.phoneNumTfd) {
        self.topLine.backgroundColor = COLOR_Line;
    }else {
        self.bottomLine.backgroundColor = COLOR_Line;
    }
}

- (void)refreshUI {
    
    [self.passWordTfd endEditing:YES];
    self.passWordTfd.text =@"";
    
    if (self.loginType == LoginType_phonePassword) {
        self.titleLab.text = @"密码登录";
        self.subTitleLab.text = @"未注册手机号验证后将自动登录";

        [self.sendCodeBtn setTitle:@"" forState:UIControlStateNormal];
        
        self.passWordTfd.keyboardType = UIKeyboardTypeDefault;
        
        if (self.isSecure) {
            
            [self.sendCodeBtn setImage:CSIconMake(@"\U0000e69e", 20, @"#636366".color,nil) forState:UIControlStateNormal];
        }else {
            [self.sendCodeBtn setImage:CSIconMake(@"\U0000e69f", 20, @"#636366".color,nil) forState:UIControlStateNormal];
        }
        
    }else if(self.loginType == LoginType_phoneCode) {
        self.titleLab.text = @"验证码登录";
        self.subTitleLab.text = @"未注册手机号请选择验证码登录";
        

        
        [self.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.sendCodeBtn setImage:nil forState:UIControlStateNormal];
        
        self.passWordTfd.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    
    self.navigationItem.rightBarButtonItem.title = self.loginType == LoginType_phonePassword?@"验证码登录":@"密码登录";
    
}

- (void)refreshBtnStatus {
    if (IsStrEmpty(self.phoneNumTfd.text) || IsStrEmpty(self.passWordTfd.text)) {
        self.loginBtn.userInteractionEnabled = NO;
        self.loginBtn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(SCREEN_WIDTH-80, 40) direction:ZQGradientChangeDirectionLevel startColor:HEX_COLOR(@"#DFD6E9") endColor:HEX_COLOR(@"#D6D9EC")];
    }else {
        self.loginBtn.userInteractionEnabled = YES;
        self.loginBtn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(SCREEN_WIDTH-80, 40) direction:ZQGradientChangeDirectionLevel startColor:HEX_COLOR(@"#AF52DE") endColor:HEX_COLOR(@"#4F6CFF")];
    }
}

- (void)loginAction:(UIButton *)sender {
    
    [self.view endEditing:YES];

//    if (![Tool checkMobileNumber:self.phoneNumTfd.text]) {
//        [MBProgressHUD mh_showTips:@"手机格式不正确"];
//        return;
//    }
    
    

    [self.vm loginWithPhoneNumber:self.phoneNumTfd.text
                           password:self.passWordTfd.text
                       completion:^(UserInfo * _Nonnull userInfo) {
        if (userInfo) {
//            [UserInfo shareInstance];
        }
    }];
}


- (void)sendCode:(UIButton *)sender {
    
    
    if (self.loginType == LoginType_phonePassword) {
        
        self.isSecure = !self.isSecure;
        
        self.passWordTfd.secureTextEntry = self.isSecure;
        if (self.isSecure) {
            
            [self.sendCodeBtn setImage:CSIconMake(@"\U0000e69e", 20, @"#636366".color,nil) forState:UIControlStateNormal];
        }else {
            [self.sendCodeBtn setImage:CSIconMake(@"\U0000e69f", 20, @"#636366".color,nil) forState:UIControlStateNormal];
        }
        
    }else {
        
        if (IsStrEmpty(self.phoneNumTfd.text)) {
            [MBProgressHUD mh_showTips:@"请填写手机号"];
            return;
        }
        if (![Tool checkMobileNumber:self.phoneNumTfd.text]) {
            [MBProgressHUD mh_showTips:@"手机格式不正确"];
            return;
        }
        
        self.curCount = 60;
        self.runTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(runCountProcess)
                                                       userInfo:nil repeats:YES];
        [self.runTimer fire];
    }
}


-(void)runCountProcess{
    @try {
            if(self.curCount<=0)
            {
                [self stopCountProcess];
                self.validSendCodeSignal = YES;
                
            }
            else
            {
                self.validSendCodeSignal = NO;
            }
            [self refreshSendCodeStatus];
            self.curCount = self.curCount-1;
        } @catch (NSException *exception) {
            [self stopCountProcess];
            NSLog(@"RegisterViewController->>runCountProcess:%@", exception);
        }

}

- (void)refreshSendCodeStatus {
    if (self.loginType == LoginType_phoneCode) {
        if (self.validSendCodeSignal) {
            [self.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.sendCodeBtn setTitleColor:HEX_COLOR(@"#4F6CFF") forState:UIControlStateNormal];
        }else {
            [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.curCount] forState:UIControlStateNormal];
            [self.sendCodeBtn setTitleColor:COLOR_LightGray forState:UIControlStateNormal];
        }
        self.sendCodeBtn.enabled = self.validSendCodeSignal;
    }
}

- (void)stopCountProcess
{
    @try {
        if(_runTimer)
        {
            if([_runTimer isValid])
            {
                [_runTimer invalidate];
            }
            _runTimer = nil;
        }
    } @catch (NSException *exception) {
        _runTimer = nil;
        NSLog(@"RegisterViewController->>stopCountProcess:%@", exception);
    }
}

- (void)dealloc {
    //销毁定时器
    if ([_runTimer isValid]) {
        [_runTimer invalidate];
        _runTimer = nil;
    }

}

@end
