//
//  OrderWebViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 22.10.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "OrderWebViewController.h"
#import "MeasurementViewController.h"
#import "MedicalViewController.h"
#import "MiltaryViewController.h"
#import "IndustryViewController.h"

@interface OrderWebViewController ()

@end

@implementation OrderWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.activityIndicator startAnimating];
    [self loadWebView];
}

-(void) loadWebView {
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, _webviewContainer.frame.size.width, _webviewContainer.frame.size.height) configuration:theConfiguration];
    webView.navigationDelegate = self;

    NSURL *nsurl=[NSURL URLWithString:self.webUrl];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
    [self.webviewContainer addSubview:webView];
}

- (IBAction)closeWebView:(id)sender {
    for(UIViewController* controller in [self.navigationController viewControllers]) {
        if ([controller isKindOfClass:[MedicalViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        } else if ([controller isKindOfClass:[MeasurementViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        } else if ([controller isKindOfClass:[MiltaryViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        } else if ([controller isKindOfClass:[IndustryViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}

- (void)webView:(WKWebView *)webView
didFinishNavigation:(WKNavigation *)navigation {
    [self.activityIndicator stopAnimating];
}

@end
