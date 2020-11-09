//
//  ViewController.m
//  CatStreet
//
//  Created by Fluva on 2020/10/31.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"状态栏高度=%f",[[UIApplication sharedApplication] statusBarFrame].size.height);
}


@end
