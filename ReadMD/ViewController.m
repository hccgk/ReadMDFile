//
//  ViewController.m
//  ReadMD
//
//  Created by 何川 on 2019/2/11.
//  Copyright © 2019 何川. All rights reserved.
//

#import "ViewController.h"
//#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 160, 40);
    [btn setTitle:@"读md文件" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toreadacton) forControlEvents:UIControlEventTouchUpInside];
}

-(void)toreadacton{
//    Class vcc =  NSClassFromString(@"ReadMDViewController");
    
    Class vcc =  NSClassFromString(@"MainViewController");

    UIViewController *vvcc = [[vcc alloc] init];
    vvcc.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
    vvcc.title = @"MD文件";
    UINavigationController *navvc = [[UINavigationController alloc] initWithRootViewController:vvcc];
    [self presentViewController:navvc animated:YES completion:^{
        
    }];
    
}


@end
