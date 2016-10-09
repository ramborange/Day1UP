//
//  WebviewController.m
//  Day1UP
//
//  Created by ramborange on 16/9/27.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "WebviewController.h"
#import <WebKit/WebKit.h>
@interface WebviewController ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webview;
@end

@implementation WebviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.webview sizeToFit];
    [self.view addSubview:self.webview];
    self.webview.navigationDelegate = self;
    
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        double progress = [change[@"new"] doubleValue];
        [SVProgressHUD showProgress:progress status:@"加载中"];
        if (progress>=1.0) {
            [self.webview removeObserver:self forKeyPath:@"estimatedProgress"];
            [SVProgressHUD dismissWithDelay:0.5];
        }
    }

}

#pragma mark = wkui delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"didStartProvisionalNavigation");

//    NSLog(@"wdf  %f",webView.estimatedProgress);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSLog(@"didFinishNavigation");
    [SVProgressHUD dismissWithDelay:0.5];
}

- (void)dealloc {
    _webview = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
