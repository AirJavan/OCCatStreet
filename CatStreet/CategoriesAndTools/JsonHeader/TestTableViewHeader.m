//
//  TestHeader.m
//  lottieDemo
//
//  Created by Lindashuai on 2020/1/19.
//  Copyright © 2020 Lindashuai. All rights reserved.
//

#import "TestTableViewHeader.h"
#import <AudioToolbox/AudioToolbox.h>//轻抖动
#import <Lottie/Lottie.h>

@interface TestTableViewHeader ()

@property(nonatomic, strong) LOTAnimationView *loadingView;
@property(nonatomic, strong) NSString *jsonString;

@end

@implementation TestTableViewHeader

- (instancetype)init {
    if (self = [super init]) {
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
        self.mj_h = 45;
    }
    return self;
}

- (void)setJsonName:(NSString *)jsonName {
    self.jsonString = jsonName;
    [self addSubview:self.loadingView];
}

- (LOTAnimationView *)loadingView {
    if(_loadingView == nil) {
        //1.加载本地json
        _loadingView = [LOTAnimationView animationNamed:self.jsonString];
        //2.加载后台给的json(url)
        //_loadingView = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
        _loadingView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width / 2.0) - 15, 10, 30, 30);
        _loadingView.loopAnimation = YES;
        _loadingView.contentMode = UIViewContentModeScaleAspectFill;
        _loadingView.animationSpeed = 1.0;
        _loadingView.loopAnimation = YES;
    }
    return _loadingView;
}

#pragma mark - innerMethod

- (void)beginRefreshing {
    if (@available(iOS 10.0, *)) {//轻抖动
        UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleMedium];
        [impactLight impactOccurred];
    } else {
        AudioServicesPlaySystemSound(1520);
    }
    [super beginRefreshing];
}

- (void)endRefreshing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [super endRefreshing];
    });
}

#pragma mark - 监听控件的刷新状态

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    if(self.jsonString.length > 0) {
        switch (state) {
            case MJRefreshStateIdle:{//普通闲置状态
                [self.loadingView stop];
                //self.loadingView.hidden = YES;
                break;}
            case MJRefreshStatePulling:{//松开就可以进行刷新的状态
                //self.loadingView.hidden = NO;
                break;}
            case MJRefreshStateRefreshing:{//正在刷新中的状态
                self.loadingView.animationProgress = 0;
                [self.loadingView play];
                break;}
            default:
                break;
        }
    }
}

#pragma mark - 实时监听控件 scrollViewContentOffset

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    if(self.jsonString.length > 0) {
        CGPoint point;
        id newVelue = [change valueForKey:NSKeyValueChangeNewKey];
        [(NSValue *)newVelue getValue:&point];
        
        //id newVelue1 = [change objectForKey:NSKeyValueChangeNewKey];
        //CGPoint point1 = ((NSValue *)newVelue1).CGPointValue;//可以取值
        
        //id newVelue2 = [change objectForKey:@"new"];
        //CGPoint point2 = *((__bridge CGPoint *)(newVelue2));//无法取到值
        
        self.loadingView.hidden = !(self.pullingPercent);
        CGFloat progress = point.y / ([UIScreen mainScreen].bounds.size.height / 3.0);
        if(self.state != MJRefreshStateRefreshing) {
            self.loadingView.animationProgress = -progress;
        }
    }
}

@end
