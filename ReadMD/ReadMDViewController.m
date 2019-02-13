//
//  ReadMDViewController.m
//  ReadMD
//
//  Created by 何川 on 2019/2/11.
//  Copyright © 2019 何川. All rights reserved.
//

#import "ReadMDViewController.h"
#import <MMMarkdown/MMMarkdown.h>
#import <WebKit/WebKit.h>
@interface ReadMDViewController ()

@end

@implementation ReadMDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    NSError  *error;
//    NSString *markdown   = @"# Example\nWhat a library!";
    NSString *markdown   =  [NSString stringWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:&error];
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
    
    
    
    WKWebView   *mdview = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [mdview sizeToFit];
    [mdview loadHTMLString:htmlString baseURL:[NSURL URLWithString:@""]];

    
    
    [self.view addSubview:mdview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
