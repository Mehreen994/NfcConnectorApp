//
//  MiltaryViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 14.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "MiltaryViewController.h"
#import "ScannerViewController.h"
#import "Location.h"
#import "AppDefines.h"

@interface MiltaryViewController ()<LocationProtocolDelegate> {
    CLLocationCoordinate2D currentLocation;
}
@end

@implementation MiltaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void) viewWillAppear:(BOOL)animated {
    // Location
    LOCATION.delegate = self;
}

- (IBAction)connectorInfoClicked:(id)sender {
    [LOCATION getLocation:SHOW_CONNECTOR_INFO tag:@""];
}

- (IBAction)productInfoClicked:(id)sender {
    [LOCATION getLocation:SHOW_PRODUCT_INFO tag:@""];
}

- (IBAction)useProductClicked:(id)sender {
    [self performSegueWithIdentifier:@"showUseProduct" sender:@"showUseProduct"];
}

-(void) showScanner:(NSString*) buttonType {
    [self performSegueWithIdentifier:@"showScanner" sender:buttonType];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isEqualToString:SHOW_PRODUCT_INFO]) {
        ScannerViewController* destination = segue.destinationViewController;
        destination.scannerType = showProductInfo;
        destination.applicationType = miltary;
        destination.coordinate = currentLocation;
    } else if ([sender isEqualToString:SHOW_CONNECTOR_INFO]) {
        ScannerViewController* destination = segue.destinationViewController;
        destination.scannerType = showConnectorInfo;
        destination.applicationType = miltary;
        destination.coordinate = currentLocation;
    }
}
#pragma mark Location

-(void) onLocationFound:(CLLocationCoordinate2D)coordinate calledBy:(nonnull NSString *)call tag:(nonnull NSString *)tag_id {
    if ([call isEqualToString:SHOW_PRODUCT_INFO] ||
        [call isEqualToString:SHOW_CONNECTOR_INFO]) {
        NSLog(@"miltary onLocationFound ****** coord = %f  long %f", coordinate.latitude, coordinate.longitude);
        currentLocation = coordinate;
        [self showScanner:call];
    }
}
@end
