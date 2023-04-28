//
//  WebViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 19.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "WebViewController.h"
#import "ScannerViewController.h"

#import "MeasurementViewController.h"
#import "MedicalViewController.h"
#import "MiltaryViewController.h"
#import "IndustryViewController.h"
#import "AlertUtil.h"
#import "ApiUtil.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(checkAlert) withObject:nil afterDelay:1.0];
    // Do any additional setup after loading the view.
    [self.activityIndicator startAnimating];
    [self loadWebView];
}

-(void) checkAlert {
    if (self.productDataTag) {
        if (self.webViewType == webViewConnectorInfo) {
            [ApiUtil createConnectorInfoPageEvent:self.productDataTag.uid lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude] completionHandler:^(SWGTag * _Nonnull output1, NSError * _Nonnull error1) {
            }];
        } else if (self.webViewType == webViewProductInfo) {
            [ApiUtil createProductInfoPageEvent:self.productDataTag.uid lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude] completionHandler:^(SWGTag * _Nonnull output1, NSError * _Nonnull error1) {
            }];
        }
        int alert = [self.productDataTag.alertStatus intValue];
        if (alert == 1) {
            NSLog(@"----- Alert 1 , no need to do anything -------");
        } else if (alert == 2) {
            NSLog(@"----- Alert 2  -------");
            [AlertUtil showAlert2WithCompletionHandler:^{
            }];
        } else if (alert == 3) {
            NSLog(@"----- Alert 3  -------");
            [AlertUtil showAlert3WithCompletionHandler:^{
            }];
        } else if (alert == 4 || alert == 5) {
            NSLog(@"----- Alert 45  -------");
            [AlertUtil showAlert45WithCompletionHandler:^{
            } SuccessBlock:^{
            } WarningBlock:^{
            } useCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.useCycles intValue]] totalCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.maxUsecycles intValue]] justWarning:YES];
        } else if (alert == 6) {
            NSLog(@"----- Alert 6  -------");
            [AlertUtil showAlert6WithCompletionHandler:^{
            } SuccessBlock:^{
            } WarningBlock:^{
            } validityData:[self getDate:self.productDataTag.validTo] justWarning:YES];
        } else if (alert == 7 || alert == 8) {
            NSLog(@"----- Alert 78  -------");
            [AlertUtil showAlert78WithCompletionHandler:^{
            } OrderReplacementBlock:^{
            } ContinueUsingBlock:^{
            } useCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.useCycles intValue]] totalCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.maxUsecycles intValue]] justWarning:YES];
        } else if (alert == 9) {
            NSLog(@"----- Alert 9  -------");
            [AlertUtil showAlert9WithCompletionHandler:^{
            } SuccessBlock:^{
            } WarningBlock:^{
            } validityData:[self getDate:self.productDataTag.validTo] justWarning:YES];
        }
    }
}

-(NSString*) getDate: (NSDate*) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    // Convert to new Date Format
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    return newDate;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
