//
//  ScannerViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 16.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertUtil.h"
#import "Location.h"
#import "NFCHelper.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showProductData,
    showConnectorData,
    registerUseCycle,
    registersterilizationCycle,
    powerStatus,
    showConnectorInfo,
    showProductInfo,
    adminHistory,
    adminMap
} ScannerType;

typedef enum {
    medical,
    measurement,
    industry,
    miltary,
    admin
} ApplicationType;

@interface ScannerViewController : UIViewController <NFCHelperProtocol>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;
@property (weak, nonatomic) IBOutlet UITextField *scanInput;
    @property (nonatomic) ScannerType scannerType;
    @property (nonatomic) ApplicationType applicationType;
    @property (nonatomic) CLLocationCoordinate2D coordinate;
@end

NS_ASSUME_NONNULL_END
