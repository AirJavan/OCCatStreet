//
//  ComplementPersonInfoVC.m
//  CatStreet
//
//  Created by Fluva on 2020/11/7.
//

#import "ComplementPersonInfoVC.h"
#import "InputCell.h"
#import "UserInfo.h"

@interface ComplementPersonInfoVC ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *stepLab;

@property (nonatomic, assign) NSInteger step; //  第一步 /第二步


@property (nonatomic, strong) NSDictionary *baseInfoDic;

@property (nonatomic, strong) NSDictionary *contactDic;


@property (nonatomic, strong) NSDictionary *otherInfoDic;

@property (nonatomic, strong) UserInfo *user;

@end

@implementation ComplementPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.rightBarButtonItem = nil;
    
    self.step  =1;
    
    [self setupUI];
    [self setupTableView];
    
    [self.tableView registerClass:[InputCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.frame = CGRectMake(0, 50+TOP_BAR_HEIGHT+80, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_BAR_HEIGHT-130);
}


- (void)setupUI {
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 50+TOP_BAR_HEIGHT, 200, 40)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.text = @"完善资料";
    
    self.titleLab.font =  PFFONT_Medium(28);
    [self.view addSubview:self.titleLab];
    
    self.stepLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-150, 50+TOP_BAR_HEIGHT+40+10, 300, 20)];
    self.stepLab.text = @"1/2";
    self.stepLab.font = PFFONT_Regular(14);
    self.stepLab.textAlignment = NSTextAlignmentCenter;
    self.stepLab.textColor =  HEX_COLOR(@"#9C9CA4");
    
    [self.view addSubview:self.stepLab];
}

- (void)loadDic {
    self.user = [[UserInfo alloc]init];
    
    
//    self.baseInfoDic = @{@"昵称":};
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.step;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.step == 1) {
        return 4;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InputCell * cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
