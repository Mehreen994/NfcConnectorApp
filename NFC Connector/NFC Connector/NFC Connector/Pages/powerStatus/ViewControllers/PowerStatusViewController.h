//
//  PowerStatusViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal on 08.12.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SwaggerClient/SWGTag.h>
#import <SwaggerClient/SWGPowerConsumption.h>
#import "ScannerViewController.h"
#import "Location.h"
#import "powerSettingView.h"
#import "HCLineChartView.h"

@interface PowerStatusViewController : UIViewController <powerSwitchDelegate>
    @property (nonatomic, strong) SWGTag* productDataTag;
    @property (nonatomic, strong) NSString* tagId;
    @property (nonatomic) ScannerType scannerType;
    @property (nonatomic) ApplicationType applicationType;
@property (weak, nonatomic) IBOutlet UILabel *yaxisLabel;

@property (weak, nonatomic) IBOutlet HCLineChartView *chartView;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end
