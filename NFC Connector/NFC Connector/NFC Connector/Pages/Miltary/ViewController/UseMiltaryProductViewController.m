//
//  UseMiltaryProductViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 14.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "UseMiltaryProductViewController.h"
#import "ScannerViewController.h"
#import "Location.h"
#import "AppDefines.h"
@interface UseMiltaryProductViewController () <LocationProtocolDelegate> {
    CLLocationCoordinate2D currentLocation;
}
@end

@implementation UseMiltaryProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated {
    // Location
    LOCATION.delegate = self;
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isEqualToString:SHOW_PRODUCT_DATA]) {
        ScannerViewController* destination = segue.destinationViewController;
        destination.scannerType = showProductData;
        destination.applicationType = miltary;
        destination.coordinate = currentLocation;
    } else if ([sender isEqualToString:SHOW_CONNECTOR_DATA]) {
        ScannerViewController* destination = segue.destinationViewController;
        destination.scannerType = showConnectorData;
        destination.applicationType = miltary;
        destination.coordinate = currentLocation;
    } else if ([sender isEqualToString:REGISTER_CYCLE]) {
        ScannerViewController* destination = segue.destinationViewController;
        destination.scannerType = registerUseCycle;
        destination.applicationType = miltary;
        destination.coordinate = currentLocation;
    } else if ([sender isEqualToString:REGISTER_STER_CYCLE]) {
        ScannerViewController* destination = segue.destinationViewController;
        destination.scannerType = registersterilizationCycle;
        destination.applicationType = miltary;
        destination.coordinate = currentLocation;
    }
}

-(void) showScanner:(NSString*) buttonType {
    [self performSegueWithIdentifier:@"gotoScanner" sender:buttonType];
}

#pragma mark - Actions Methods

- (IBAction)registerUseCycleClicked:(id)sender {
    [LOCATION getLocation:REGISTER_CYCLE tag:@""];
}
- (IBAction)registerSterilizationClicked:(id)sender {
    [LOCATION getLocation:REGISTER_STER_CYCLE tag:@""];
}
- (IBAction)showConnectorDataClicked:(id)sender {
    [LOCATION getLocation:SHOW_CONNECTOR_DATA tag:@""];
}
- (IBAction)showProductDataClicked:(id)sender {
    [LOCATION getLocation:SHOW_PRODUCT_DATA tag:@""];
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark Location

-(void) onLocationFound:(CLLocationCoordinate2D)coordinate calledBy:(nonnull NSString *)call tag:(nonnull NSString *)tag_id {
    if ([call isEqualToString:SHOW_PRODUCT_DATA] ||
        [call isEqualToString:SHOW_CONNECTOR_DATA] ||
        [call isEqualToString:REGISTER_CYCLE] ||
        [call isEqualToString:POWER_STATUS]) {
        NSLog(@"Usemiltary onLocationFound ****** coord = %f  long %f", coordinate.latitude, coordinate.longitude);
        currentLocation = coordinate;
        [self showScanner:call];
    }
}
@end
