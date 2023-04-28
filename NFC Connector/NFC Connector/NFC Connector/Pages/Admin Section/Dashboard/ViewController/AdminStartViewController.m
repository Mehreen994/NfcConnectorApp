//
//  AdminStartViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 22.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "AdminStartViewController.h"
#import "ApiUtil.h"
#import "AlertUtil.h"
#import "ScannerViewController.h"

@interface AdminStartViewController ()

@end

@implementation AdminStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - IBActions

- (IBAction)localizationButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"showScannerForMap" sender:nil];
}

- (IBAction)supportButtonClicked:(id)sender {
    NSString * encodedString = [@"mailto:odu-support@auguris.org" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];

    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:[NSURL URLWithString: encodedString] options:@{} completionHandler:nil];
}

- (IBAction)historyButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"showScannerForHistory" sender:nil];
}


#pragma mark - Navigation

- (IBAction)logoutButtonClicked:(id)sender {
    //[self performSegueWithIdentifier:@"doLogout" sender:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showScannerForMap"]) {
       ScannerViewController* scannerViewController = (ScannerViewController*) segue.destinationViewController;
        scannerViewController.scannerType = adminMap;
        scannerViewController.applicationType = admin;
    } else if ([segue.identifier isEqualToString:@"showScannerForHistory"]) {
        ScannerViewController* scannerViewController = (ScannerViewController*) segue.destinationViewController;
        scannerViewController.scannerType = adminHistory;
        scannerViewController.applicationType = admin;
    }
}


@end
