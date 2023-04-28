//
//  RegisterUseCycleViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 29.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SwaggerClient/SWGTag.h>
#import "ScannerViewController.h"
#import "Location.h"
#import "ProgressCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterUseCycleViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
    @property (nonatomic, strong) SWGTag* productDataTag;
    @property (weak, nonatomic) IBOutlet UITableView *dataTableView;
    @property (weak, nonatomic) IBOutlet UILabel *productDescription;
    @property (nonatomic) ScannerType scannerType;
    @property (nonatomic) ApplicationType applicationType;
    @property (nonatomic) CLLocationCoordinate2D coordinate;
@end

NS_ASSUME_NONNULL_END
