//
//  UseMeasurementProductViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 14.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "UseMeasurementProductViewController.h"
#import "ScannerViewController.h"
#import "Location.h"
#import "AppDefines.h"
@interface UseMeasurementProductViewController () <LocationProtocolDelegate> {
    CLLocationCoordinate2D currentLocation;
}
@end

@implementation UseMeasurementProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        destination.applicationType = measurement;
        destination.coordinate = currentLocation;
    } else if ([sender isEqualToString:SHOW_CONNECTOR_DATA]) {
        ScannerViewController* destination = segue.destinationViewController;
        destination.scannerType = showConnectorData;
        destination.applicationType = measurement;
        destination.coordinate = currentLocation;
    } else if ([sender isEqualToString:REGISTER_CYCLE]) {
        ScannerViewController* destination = segue.destinationViewController;
        destination.scannerType = registerUseCycle;
        destination.applicationType = measurement;
        destination.coordinate = currentLocation;
    } else if ([sender isEqualToString:POWER_STATUS]) {
           ScannerViewController* destination = segue.destinationViewController;
           destination.scannerType = powerStatus;
           destination.applicationType = industry;
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

- (IBAction)powerStatusClicked:(id)sender {
    [LOCATION getLocation:POWER_STATUS tag:@""];
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
    if ([call isEqualToString:REGISTER_CYCLE] ||
        [call isEqualToString:POWER_STATUS] ||
        [call isEqualToString:SHOW_CONNECTOR_DATA] ||
        [call isEqualToString:SHOW_PRODUCT_DATA]) {
        NSLog(@"UseMeasurement onLocationFound ****** coord = %f  long %f", coordinate.latitude, coordinate.longitude);
        currentLocation = coordinate;
        [self showScanner:call];
    }
}

@end
