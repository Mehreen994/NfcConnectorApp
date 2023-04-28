//
//  ScannerViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 16.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "ScannerViewController.h"
#import "ApiUtil.h"
#import "Location.h"
#import "WebViewController.h"
#import "ShowProductDataViewController.h"
#import "ShowConnectorDataViewController.h"
#import "RegisterUseCycleViewController.h"
#import "PowerStatusViewController.h"
#import "MapViewController.h"
#import "HistoryViewController.h"

@interface ScannerViewController () {
    SWGTag* current_tag;
}
@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NFCHELPER setDelegate:self];
    [NFCHELPER startSession];
    //[self doPerformPostScan:@"044EC89A855C81"];

    if (self.applicationType == admin) {
        self.barButtonItem.tintColor = [UIColor whiteColor];
    }
}

-(void) doPerformPostScan: (NSString*) tagData {
    switch (self.scannerType) {
        case showConnectorInfo:
            [self doPostConnectorInfo:tagData];
            break;
        case showProductInfo:
            [self doPostProductInfo:tagData];
            break;
        case registerUseCycle:
            [self doPostRegisterUseCycle:tagData];
            break;
        case registersterilizationCycle:
            [self doPostRegisterSterilizedCycle:tagData];
            break;
        case powerStatus:
            [self doPostPowerStatus:tagData];
            break;
        case showProductData:
            [self doPostShowProductData:tagData];
            break;
        case showConnectorData:
            [self doPostShowScannerData:tagData];
            break;
        case adminMap:
            [self doPostAdminMap:tagData];
            break;
        case adminHistory:
            [self doPostAdminHistory:tagData];
            break;

        default:
            break;
    }
}



-(void) showWebView: (NSString*) urlString type:(WebViewType) webtype {
    if (webtype == webViewProductInfo) {
        [self performSegueWithIdentifier:@"showWebViewProduct" sender:urlString];
    } else if (webtype == webViewConnectorInfo) {
        [self performSegueWithIdentifier:@"showWebViewConnector" sender:urlString];
    }

}



#pragma mark - Other Post Calls

-(void) getTagInformation: (NSString*) tagId completionHandler: (void (^)(SWGTag* output)) handler {
    [ApiUtil getTagWithId:tagId lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude]
        completionHandler:^(SWGTag * _Nonnull output, NSError * _Nonnull error) {
        if (error != nil) {
            [AlertUtil showAlertWithTitle:NSLocalizedString(@"errorReadingTagInfoTitle", "Error") message:NSLocalizedString(@"errorReadingTagInfo", "NFC-Tag identified - product not registered !")  completionHandler:^{
                handler(nil);
                [self goBack];
            }];
            return;
        }
        handler(output);
        return;
    }];
}

-(void) doPostConnectorInfo: (NSString*) tagData {
    [self getTagInformation:tagData completionHandler:^(SWGTag *output) {
        if (output != nil) {
            self->current_tag = output;
            [self showWebView:output.linkConnector type:webViewConnectorInfo];
        }
    }];
}

-(void) doPostProductInfo: (NSString*) tagData {
    [self getTagInformation:tagData completionHandler:^(SWGTag *output) {
        if (output != nil) {
            self->current_tag = output;
            [self showWebView:output.linkProduct type:webViewProductInfo];
        }
    }];
}

-(void) doPostPowerStatus: (NSString*) tagData {
    [self getTagInformation:tagData completionHandler:^(SWGTag *output) {
        if (output != nil) {
            self->current_tag = output;
            [self performSegueWithIdentifier:@"showPowerStatus" sender:tagData];
        }
    }];
}

-(void) doPostShowProductData: (NSString*) tagData {
    [self getTagInformation:tagData completionHandler:^(SWGTag *output) {
        if (output != nil) {
            self->current_tag = output;
            [self performSegueWithIdentifier:@"showProductData" sender:output];
        }
    }];
}

-(void) doPostShowScannerData: (NSString*) tagData {
    [self getTagInformation:tagData completionHandler:^(SWGTag *output) {
        if (output != nil) {
            self->current_tag = output;
            [self performSegueWithIdentifier:@"showScannerData" sender:output];
        }
    }];
}

-(void) doPostRegisterUseCycle: (NSString*) tagData {
    [self getTagInformation:tagData completionHandler:^(SWGTag *output) {
        if (output != nil) {
            self->current_tag = output;
            [self performSegueWithIdentifier:@"showCycleData" sender:output];
        }
    }];
}

-(void) doPostRegisterSterilizedCycle: (NSString*) tagData {
    [self getTagInformation:tagData completionHandler:^(SWGTag *output) {
        if (output != nil) {
            self->current_tag = output;
            [self performSegueWithIdentifier:@"showCycleData" sender:output];
        }
    }];
}
#pragma mark - Admin Post Calls
-(void) doPostAdminMap: (NSString*) tagData {
    [ApiUtil getHistoryWithTag:tagData completionHandler:^(SWGHistory * _Nonnull output, NSError * _Nonnull error) {
        if (error) {
            [AlertUtil showAlertWithTitle:@"Error" message:@"Failed to load the History." completionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self goBack];
                });
            }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"showMap" sender:output];
            });
        }
    }];
}

-(void) doPostAdminHistory: (NSString*) tagData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"showHistory" sender:tagData];
    });
}
#pragma mark - Navigation

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    [NFCHELPER setDelegate:nil];
    [NFCHELPER stopSession];

    if ([segue.identifier isEqualToString:@"showWebViewProduct"]) {
        WebViewController* destination = segue.destinationViewController;
        destination.productDataTag = current_tag;
        destination.webUrl = (NSString*) sender;
        destination.coordinate = self.coordinate;
        destination.webViewType = webViewProductInfo;
    } else if ([segue.identifier isEqualToString:@"showWebViewConnector"]) {
        WebViewController* destination = segue.destinationViewController;
        destination.productDataTag = current_tag;
        destination.webUrl = (NSString*) sender;
        destination.coordinate = self.coordinate;
        destination.webViewType = webViewConnectorInfo;
    } else if ([segue.identifier isEqualToString:@"showProductData"]) {
        ShowProductDataViewController* destination = segue.destinationViewController;
        destination.productDataTag = (SWGTag*) sender;
        destination.applicationType = self.applicationType;
        destination.coordinate = self.coordinate;
    } else if ([segue.identifier isEqualToString:@"showScannerData"]) {
        ShowConnectorDataViewController* destination = segue.destinationViewController;
        destination.productDataTag = (SWGTag*) sender;
        destination.applicationType = self.applicationType;
        destination.coordinate = self.coordinate;
    } else if ([segue.identifier isEqualToString:@"showCycleData"]) {
        RegisterUseCycleViewController* destination = segue.destinationViewController;
        destination.productDataTag = (SWGTag*) sender;
        destination.scannerType = self.scannerType;
        destination.coordinate = self.coordinate;
        destination.applicationType = self.applicationType;
    } else if ([segue.identifier isEqualToString:@"showMap"]) {
        MapViewController* destination = segue.destinationViewController;
        destination.history = (SWGHistory*) sender;
    } else if ([segue.identifier isEqualToString:@"showHistory"]) {
        HistoryViewController* destination = segue.destinationViewController;
        destination.tagString = (NSString*) sender;
    } else if ([segue.identifier isEqualToString:@"showPowerStatus"]) {
        PowerStatusViewController* destination = segue.destinationViewController;
        destination.productDataTag = (SWGTag*) self->current_tag;
        destination.scannerType = self.scannerType;
        destination.coordinate = self.coordinate;
        destination.tagId = (NSString*) sender;
        destination.applicationType = self.applicationType;
    }

}

#pragma mark - NFC Helper Delegate

-(void) goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) nfcSessionStarted {
    NSLog(@"*** session Started ***");
}

-(void) nfcSessionStartFailed {
    NSLog(@"*** session Start Failed ***");
}

-(void) nfcSessionStopped {
    NSLog(@"*** session Stopped ***");
    [self goBack];
}

-(void) nfcSessionStopFailed {
    NSLog(@"*** session Stop Failed ***");
}
-(void) nfcReadError {
    NSLog(@"*** Tag Read Error ***");
    dispatch_async(dispatch_get_main_queue(), ^{
        [AlertUtil showAlertWithTitle:@"Error" message:@"Failed to read tag information." completionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [NFCHELPER setDelegate:nil];
                [NFCHELPER stopSession];
                [self goBack];
            });
        }];
    });
}
-(void) nfcReadData:(NSString*) data {
    NSLog(@"*** Tag Data %@ ***", data);
    if (data != nil && ![data isEqualToString:@""]) {
        [NFCHELPER setDelegate:nil];
        [NFCHELPER stopSession];
        [self doPerformPostScan:data];
    } else {
        [AlertUtil showAlertWithTitle:@"Error" message:@"Wrong NFC Tag. Please try again." completionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [NFCHELPER setDelegate:nil];
                [NFCHELPER stopSession];
                [self goBack];
            });
        }];
    }

}
@end
